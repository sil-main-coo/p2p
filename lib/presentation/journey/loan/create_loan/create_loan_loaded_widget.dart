import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/linked_payment_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/connect_facebook_layout.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/linking_payment_fragment.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/addition_info_step/cubit/addition_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/addition_info_step/widgets/additional_info_form_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/id_info_step/cubit/id_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/id_info_step/widgets/item_image_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/loan_info_step/cubit/loan_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/loan_info_step/widgets/expected_interest_rate_dialog_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/loan_info_step/widgets/select_loan_product_dialog_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/cubit/occupation_info_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/model/occupation_info_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/widgets/occupation_select_dialog.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/widgets/position_occupation_select_dialog.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/payment_account_step/cubit/payment_account_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/cubit/personal_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/model/personal_info_step_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/birthday_picker_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/full_name_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/id_card_by_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/id_card_date_picker_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/id_card_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/marital_status_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/owner_ship_type_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/relative_person_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/widgets/sex_selection_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/step_create_loan_constants.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_route.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/occupation_enums.dart';
import 'package:p2p_borrower/common/constants/type_picture.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/data/model/response/addresses_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_slider_value_widget.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_title_value_widget.dart';
import 'package:p2p_borrower/common/extensions/app_string_extension.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_dropdown.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_navigator.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/acttion_payment_screen_enum.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/step_navigator_cubit/step_create_loan_navigator_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/widgets/step_create_loan_layout.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';
import 'package:p2p_borrower/presentation/journey/select_address/select_address_route.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

part 'loan_info_step/loan_info_step_widget.dart';

part 'personal_info_step/personal_info_step_widget.dart';

part 'occupation_info_step/occupation_info_step_widget.dart';

part 'payment_account_step/payment_account_step_widget.dart';

part 'id_info_step/id_info_step_widget.dart';

part 'addition_info_step/addition_info_step_widget.dart';

part 'connect_facebook_step/connect_facebook_step_widget.dart';

class CreateLoanLoadedWidget extends StatelessWidget {
  CreateLoanLoadedWidget(
    this.loanProductSelected, {
    Key? key,
  }) : super(key: key) {
    _showAdditionInfo = loanProductSelected.additionalInfos != null &&
        loanProductSelected.additionalInfos!.isNotEmpty;
    if (_showAdditionInfo) {
      _stepTitles = [
        S.current.loanAmount,
        S.current.personal,
        S.current.job,
        S.current.account,
        S.current.identity,
        S.current.additional,
        S.current.facebook,
      ];
    } else {
      _stepTitles = [
        S.current.loanAmount,
        S.current.personal,
        S.current.job,
        S.current.account,
        S.current.identity,
        S.current.facebook,
      ];
    }
  }

  final LoanProductsResponse loanProductSelected;

  late List<String> _stepTitles;
  late bool _showAdditionInfo;

  final _bottomStepHeight = 36.h;
  final ItemScrollController _scrollController = ItemScrollController();

  void _finishStep(BuildContext context, StepCreateLoanEnd state) {
    final createLoanCubit = BlocProvider.of<CreateLoanCubit>(context);
    Navigator.pushNamed(context, LoanRoute.createReviewLoanID, arguments: {
      LoanRoute.argLoanRequest: createLoanCubit.confirmLoanData(),
      LoanRoute.argHiveKeyLoanSimple: createLoanCubit.keySimpleLoan,
      LoanRoute.argReviewLoanAppAction: createLoanCubit.loanAction,
    });
  }

  void _exit(BuildContext context, StepCreateLoanExit state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.exit,
        message: S.current.createLoanExitMsg,
        leftLabel: S.current.no,
        callBackLeft: () => Navigator.pop(context, false),
        rightLabel: S.current.exit,
        callBackRight: () {
          Navigator.pop(context);
          // pop with draft loan
          Navigator.pop(context,
              BlocProvider.of<CreateLoanCubit>(context).loanSimpleInit);
        });
  }

  void _jumpToStep(StepCreateLoanInitial state) {
    _scrollController.scrollTo(
        index: state.index, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StepCreateLoanNavigatorCubit,
        StepCreateLoanNavigatorState>(
      listener: (context, state) {
        if (state is StepCreateLoanInitial) {
          _jumpToStep(state);
          return;
        }
        if (state is StepCreateLoanEnd) {
          _finishStep(context, state);
          return;
        }
        if (state is StepCreateLoanExit) {
          _exit(context, state);
          return;
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: IndexedStack(
                    index: state.index,
                    children: _pageSteps(context),
                  ),
                ),
                VerticalSpace(height: _bottomStepHeight)
              ],
            ),
            _bottomStepInProgress(context, state.index)
          ],
        );
      },
    );
  }

  List<Widget> _pageSteps(BuildContext context) {
    return [
      BlocProvider(
          create: (context) =>
              BlocProvider.of<CreateLoanCubit>(context).loanInfoStepCubit,
          child: LoanInfoStepWidget(
            stepName: S.current.step1,
          )),
      BlocProvider(
        create: (context) =>
            BlocProvider.of<CreateLoanCubit>(context).personalInfoStepCubit,
        child: PersonalInfoWidget(
          stepName: S.current.step2,
        ),
      ),
      BlocProvider(
        create: (context) =>
            BlocProvider.of<CreateLoanCubit>(context).occupationInfoStepCubit,
        child: OccupationInfoStepWidget(
          stepName: S.current.step3,
        ),
      ),
      BlocProvider(
        create: (context) =>
            BlocProvider.of<CreateLoanCubit>(context).paymentAccountStepCubit,
        child: PaymentAccountStepWidget(
          stepName: S.current.step4,
        ),
      ),
      BlocProvider(
        create: (context) =>
            BlocProvider.of<CreateLoanCubit>(context).idInfoStepCubit,
        child: IDInfoStepWidget(
          stepName: S.current.step5,
        ),
      ),
      if (_showAdditionInfo)
        BlocProvider(
          create: (context) =>
              BlocProvider.of<CreateLoanCubit>(context).additionInfoStepCubit,
          child: AdditionInfoStepWidget(
              stepName: _showAdditionInfo ? S.current.step6 : '',
              additionalInfoList: loanProductSelected.additionalInfos!),
        ),
      ConnectFacebookStepWidget(
        stepName: _showAdditionInfo ? S.current.step7 : S.current.step6,
      )
    ];
  }

  Widget _bottomStepInProgress(BuildContext context, int indexSelected) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        // color: Colors.red,
        height: _bottomStepHeight,
        padding:
            EdgeInsets.only(left: 12.w, top: 8.w, bottom: 8.w, right: 12.w),
        child: ScrollablePositionedList.separated(
          itemScrollController: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _stepTitles.length,
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            final stepTextStyle = Theme.of(context).textTheme.caption!.copyWith(
                fontWeight: FontWeight.bold,
                color: index <= indexSelected
                    ? mColorBodyTextGreen
                    : mColorSubtext);

            return Center(
                child: Text(
              _stepTitles[index].toUpperCase(),
              style: stepTextStyle,
            ));
          },
          separatorBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HorizontalSpace.init4(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.w,
                  color: index <= (indexSelected)
                      ? mColorBodyTextGreen
                      : mColorSubtext,
                ),
                HorizontalSpace.init4(),
              ],
            );
          },
        ),
      ),
    );
  }
}
