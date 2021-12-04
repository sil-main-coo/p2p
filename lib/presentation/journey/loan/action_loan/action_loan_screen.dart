import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_title_value_widget.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/loan_utils/loan_push_to_action_utils.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';

import '../loan_route.dart';

class ActionLoanScreen extends StatelessWidget {
  ActionLoanScreen({Key? key, required this.actionEnum, required this.loan})
      : super(key: key);

  final LoanAppActionEnum actionEnum;
  final LoanApplicationResponse loan;

  final _loadingDialog = AppLoadingDialog();

  // use to handling action of loan. eg: update/confirm interest rate...
  final LoanPushToActionUtils _loanPushToActionUtils = LoanPushToActionUtils();

  late String _titleAppbar;
  late Widget _button;
  List<Widget> _listTileItem = [];
  String? _noteText;

  void _interestRateConfirm(BuildContext context) {
    BlocProvider.of<LoanCubit>(context).confirmInterestRateLoan(loan);
  }

  void _disbursement(BuildContext context) {
    _loanPushToActionUtils.pushToContract(context, false, loanSimple: loan);
  }

  void _interestRateConfirmSuccess(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context,
        LoanRoute.confirmInterestRateSuccess,
        ModalRoute.withName(HomeRoute.id));
  }

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    switch (actionEnum) {
      case LoanAppActionEnum.CONFIRM_INTEREST_RATE:
        _titleAppbar = S.current.interestRateConfirm;
        _noteText = S.current.confirmInterestRateNote;

        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanAmountConfirm}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.expectedInterestRate}',
            valueText: loan.expectedInterestRateStringFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.serviceCharge}',
            valueText: loan.serviceFeesFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.monthlyInstallment}',
            valueText: loan.monthlyInstallment));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            hideBottomBorder: true,
            titleLabel: '${S.current.loanProduct}',
            valueText: loan.loanProduct!));

        _button = _buttonsWidget(
          label1: S.current.confirm,
          onPressed1: () => _interestRateConfirm(context),
        );
        break;
      case LoanAppActionEnum.EARLY_DISBURSEMENT:
        _titleAppbar = S.current.earlyDisbursement;

        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.phoneNumber}',
            valueText: loan.phone ?? 'Unknown'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.fullName}',
            valueText: 'Unknown'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanAmountConfirm}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            valueColor: mColorBodyTextGreen,
            titleLabel: '${S.current.amountRaised}',
            valueText: loan.raisedAmountFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.raisedDayLeft}',
            valueText: loan.raisedDayLeftFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.expectedInterestRate}',
            valueText: loan.expectedInterestRateStringFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.serviceCharge}',
            valueText: loan.serviceFeesFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.monthlyInstallment}',
            valueText: loan.monthlyInstallment));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            hideBottomBorder: true,
            titleLabel: '${S.current.loanProduct}',
            valueText: loan.loanProduct!));

        _button = _buttonsWidget(
            label1: S.current.signContractToDisburse,
            onPressed1: () => _disbursement(context),
            label2: '${S.current.no}, ${S.current.continueRaised}',
            onPressed2: () => Navigator.pop(context));
        break;
      case LoanAppActionEnum.DISBURSEMENT:
        _titleAppbar = S.current.disbursement;

        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.phoneNumber}',
            valueText: loan.phone ?? ''));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.fullName}',
            valueText: 'Unknown'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanAmountConfirm}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            valueColor: mColorBodyTextGreen,
            titleLabel: '${S.current.amountRaised}',
            valueText: loan.raisedAmountFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.expectedInterestRate}',
            valueText: loan.expectedInterestRateStringFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.serviceCharge}',
            valueText: loan.serviceFeesFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.monthlyInstallment}',
            valueText: loan.monthlyInstallment));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            hideBottomBorder: true,
            titleLabel: '${S.current.loanProduct}',
            valueText: loan.loanProduct!));

        _button = _buttonsWidget(
            label1: S.current.signContractToDisburse,
            onPressed1: () => _disbursement(context));
        _noteText = S.current.disburseNote;
        break;
      case LoanAppActionEnum.PAYMENT:
        _titleAppbar = S.current.pay;
        break;
      default:
        _titleAppbar = S.current.detailLoan;
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<LoanCubit, LoanState>(
          listener: (context, state) {
            if (state is LoanLoaded &&
                state.actionEnum == LoanAppActionEnum.CONFIRM_INTEREST_RATE) {
              _interestRateConfirmSuccess(context);
            }
          },
        ),
        BlocListener<LoaderCubit, LoaderState>(
            bloc: BlocProvider.of<LoanCubit>(context).loaderCubit,
            listener: (context, state) {
              if (state is LoanLoaded) {
                switch (state.runtimeType) {
                  case LoaderLoaded:
                    _loadingDialog.popDialog();
                    break;
                  case LoaderSuccess:
                    break;
                  case LoaderFailure:
                    _showFailureDialog(
                        context, (state as LoaderFailure).messages[0]);
                    break;
                  default:
                    _loadingDialog.showDefault(context);
                }
              }
            })
      ],
      child: Scaffold(
        appBar: AppbarAction(
          titleText: _titleAppbar,
          callbackLeading: () => Navigator.pop(context),
        ),
        body: CompactLayout(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    border: Border.all(color: mColorBordersLines)),
                child: Column(
                  children: _listTileItem,
                ),
              ),
              VerticalSpace.init16(),
              _button,
              if (_noteText != null)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.w),
                    child: Text(
                      _noteText!,
                      style: Theme.of(context).textTheme.textSub,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonsWidget(
      {required String label1,
      required Function onPressed1,
      String? label2,
      Function? onPressed2}) {
    return Column(
      children: [
        RaisedGradientButton(
          label: label1,
          onPressed: () => onPressed1(),
        ),
        if (label2 != null && onPressed2 != null)
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: AppTextButton(
              label: label2,
              onPressed: () => onPressed2(),
            ),
          ),
        VerticalSpace.init32(),
      ],
    );
  }
}
