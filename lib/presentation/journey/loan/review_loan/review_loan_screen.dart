import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';
import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';

import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_title_value_widget.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_route.dart';

import 'cubit/review_loan_cubit.dart';
import 'widgets/review_loan_checkbox_button_widget.dart';

class ReviewLoanScreen extends StatelessWidget {
  const ReviewLoanScreen(
      {Key? key,
      required this.loanRequest,
      required this.loanAppActionEnum})
      : super(key: key);

  final CreateLoanRequest loanRequest;
  final LoanAppActionEnum loanAppActionEnum;

  void _showCreateLoanFailureDialog(BuildContext context, String msg) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.createLoanTitle,
        message: msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () {
          Navigator.pop(context);
        });
  }

  Future _sendLoanPressed(BuildContext context) async {
    // push to otp screen
    final otp = await Navigator.pushNamed(
        context, AuthenticationRoute.verifyOtpID,
        arguments: {
          AuthenticationRoute.phoneArg: loanRequest.phone,
          AuthenticationRoute.verifyTypeArg: VerifyConstants.CreateLoan
        });

    if (otp != null) {
      //   // verify otp success -> send loan profile
      BlocProvider.of<ReviewLoanCubit>(context).sendLoanProfile(
          request: loanRequest, loanAction: loanAppActionEnum);
    }
  }

  void _createLoanSuccess(BuildContext context) {
    // print('success');
    Navigator.pushNamedAndRemoveUntil(
        context,
        LoanRoute.createLoanSuccessHasNotifyID,
        ModalRoute.withName(HomeRoute.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewLoanCubit, ReviewLoanState>(
      listener: (context, state) {
        if (state is ReviewLoanLoading) {
          getIt.get<AppLoadingDialog>().showDefault(context);
          return;
        }

        if (state is ReviewLoanFailure) {
          getIt.get<AppLoadingDialog>().popDialog();
          _showCreateLoanFailureDialog(context, state.msg);
          return;
        }

        if (state is ReviewLoanSuccess) {
          getIt.get<AppLoadingDialog>().popDialog(context: context);
          _createLoanSuccess(context);
          return;
        }
      },
      child: Scaffold(
        appBar: AppbarAction(
          titleText: S.current.detailLoan,
          callbackLeading: () => Navigator.pop(context),
        ),
        body: CompactLayout(
          child: Column(
            children: [
              _detailLoanContainer(),
              VerticalSpace.init16(),
              ReviewLoanCheckBoxButtonWidget(
                phone: loanRequest.phone!,
                loanAppActionEnum: loanAppActionEnum,
                buttonCallback: () async => await _sendLoanPressed(context),
              ),
              VerticalSpace.init16(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailLoanContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(color: mColorBordersLines)),
      child: Column(
        children: [
          AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.phoneNumber}',
            valueText: loanRequest.phone!,
          ),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              titleLabel: '${S.current.dateCreateLoan}',
              valueText: loanRequest.dateLoanStringFormatted),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              isBoldValueText: true,
              titleLabel: '${S.current.amountLoan}',
              valueText: loanRequest.loanAmountStringFormatted),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              isBoldValueText: true,
              titleLabel: '${S.current.durationLoan}',
              valueText: '${loanRequest.loanDuration!.toString()} '
                  '${loanRequest.loanDurationTranslated!.toLowerCase()}'),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              titleLabel: '${S.current.expectedInterestRate}',
              valueText: loanRequest.expectedInterestRateStringFormatted),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              titleLabel: '${S.current.serviceCharge}',
              valueText: loanRequest.serviceFeesStringFormatted),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              isBoldValueText: true,
              titleLabel: '${S.current.expectedPayment}',
              valueText: loanRequest.expectedTotalPaymentStringFormatted),
          AppListTileTitleValueWidget(
              hideTopBorder: true,
              hideBottomBorder: true,
              titleLabel: '${S.current.purposeLoan}',
              valueText: loanRequest.purposeLoan!),
        ],
      ),
    );
  }
}
