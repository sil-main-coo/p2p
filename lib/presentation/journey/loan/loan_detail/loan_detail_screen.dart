import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/constants/loan_application_status_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_outline_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/loan_utils/loan_push_to_action_utils.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_title_value_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';

class LoanDetailScreen extends StatelessWidget {
  LoanDetailScreen({Key? key, required this.loan, this.appBarTitle})
      : super(key: key) {
    switch (loan.status!) {
      case LoanApplicationStatus.Submitted:
        _title = S.current.submittedLoanStatusTitle;
        break;
      case LoanApplicationStatus.UpdateRequired:
        _title = S.current.updateRequiredStatusTitle;
        break;
      case LoanApplicationStatus.MoreInfoRequired:
        _title = S.current.moreInfoRequiredStatusTitle;
        break;
      case LoanApplicationStatus.Reject:
        _title = S.current.rejectStatusTitle;
        break;
      case LoanApplicationStatus.InterestRateConfirm:
        _title = '${S.current.congratulation}, '
            '${S.current.interestRateConfirmStatusTitle} '
            '${loan.expectedInterestRateStringFormatted}';
        _msg = S.current.interestRateConfirmStatusMsg;
        break;
      case LoanApplicationStatus.OnMarket:
        _title = S.current.onMarketStatusTitle;
        _msg = S.current.onMarketStatusMsg;
        break;
      case LoanApplicationStatus.FundRaised:
        if (loan.raisedAmount == 0) {
          _title = S.current.onMarketStatusTitle;
          _msg = S.current.onMarketStatusMsg;
        } else if (loan.isRaisedEnough) {
          _title = '${S.current.congratulation}, '
              '${S.current.fundRaisedEnoughStatusTitle}';
          _msg = S.current.fundRaisedEnoughStatusMsg;
        } else {
          _title = '${S.current.fundRaisedNotEnoughStatusTitle1} '
              '${loan.raisedAmountFormatted} '
              '${S.current.fundRaisedNotEnoughStatusTitle2} '
              '${loan.numberDayRaised} ';
          _msg = S.current.fundRaisedNotEnoughStatusMsg;
        }
        break;
      case LoanApplicationStatus.FundOvertime:
        _title = S.current.fundOverTimeStatusTitle;
        if (loan.isEnoughToDisbursement) {
          _title = '${S.current.fundOverTimeStatusTitle} '
              '${loan.raisedAmountFormatted}';
          _msg = S.current.fundRaisedEnoughStatusMsg;
        } else {
          _title = '${S.current.fundOverTimeNotEnoughStatusTitle}';
          _msg = S.current.fundOverTimeNotEnoughStatusMsg;
        }
        break;
      case LoanApplicationStatus.DisburmentPending:
        _title = '${S.current.disbursementPendingStatusTitle}';
        break;
      case LoanApplicationStatus.OnLoan:
        if (loan.debtAmount != null && loan.debtAmount != 0) {
          // over due loan
          _title = '${S.current.overDueLoan} x ngày.';
          _msg =
              '${S.current.youNeedToPay} xxxđ ${S.current.overDueLoanMsg}.\n';
          _msg1 = S.current.overDueLoanMsg1;
        } else {
          _title =
              '${S.current.welcome}, ${S.current.youAreBorrowing} ${loan.loanAmountActualFormatted}.';
          _msg = '${S.current.youNeedToPay} xxxđ ${S.current.inThisMonth}.\n'
              '${S.current.pleasePayBeforeDate} dd/MM/yyyy.';
        }

        break;
    }
  }

  final LoanApplicationResponse loan;
  final String? appBarTitle;

  String? _title;
  String? _msg, _msg1;
  Widget? _buttons;
  List<Widget> _listTileItem = [];

  final _loadingDialog = AppLoadingDialog();

  // use to handling action of loan. eg: update/confirm interest rate...
  final LoanPushToActionUtils _loanPushToActionUtils = LoanPushToActionUtils();

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _removeLoanSuccess(BuildContext context) {
    // confirm interest success
    print('remove a loan');
  }

  void _mapStatusLoanToWidgets(BuildContext context) {
    _listTileItem.add(AppListTileTitleValueWidget(
      hideTopBorder: true,
      titleLabel: '${S.current.phoneNumber}',
      valueText: loan.phone!,
    ));

    switch (loan.status!) {
      case LoanApplicationStatus.Submitted:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateCreateLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.editLoan,
          outLineLabel: S.current.cancelLoanRequest,
          onPressedGradient: () =>
              _loanPushToActionUtils.editLoan(context, loan),
          onPressedOutLine: () =>
              _loanPushToActionUtils.cancelLoan(context, loan),
        );
        break;
      case LoanApplicationStatus.UpdateRequired:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateCreateLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.updateInfo,
          outLineLabel: S.current.cancelLoanRequest,
          onPressedGradient: () =>
              _loanPushToActionUtils.editLoan(context, loan),
          onPressedOutLine: () =>
              _loanPushToActionUtils.cancelLoan(context, loan),
        );
        break;
      case LoanApplicationStatus.MoreInfoRequired:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateCreateLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.implementInfo,
          outLineLabel: S.current.cancelLoanRequest,
          onPressedGradient: () =>
              _loanPushToActionUtils.editLoan(context, loan),
          onPressedOutLine: () =>
              _loanPushToActionUtils.cancelLoan(context, loan),
        );
        break;
      case LoanApplicationStatus.Reject:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateCreateLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountExpectedLoan}',
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.deleteLoanRequest,
          onPressedGradient: () =>
              _loanPushToActionUtils.deleteLoanRequest(context, loan),
        );
        break;
      case LoanApplicationStatus.InterestRateConfirm:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
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

        _buttons = _buttonsWidget(
          gradientLabel: S.current.interestRateConfirm,
          onPressedGradient: () =>
              _loanPushToActionUtils.pushToInterestRateConfirm(context, loan),
        );
        break;
      case LoanApplicationStatus.OnMarket:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
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
            titleLabel: '${S.current.deadlineLoanRaise}',
            valueText: loan.createDateTimeFormattedWithHourMinute!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        break;
      case LoanApplicationStatus.FundRaised:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
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

        if (loan.isRaisedEnough) {
          _buttons = _buttonsWidget(
            gradientLabel: S.current.disbursement,
            onPressedGradient: () =>
                _loanPushToActionUtils.pushToDisbursement(context, loan),
          );
        } else if (loan.isEnoughToDisbursement) {
          _listTileItem.add(AppListTileTitleValueWidget(
              hideTopBorder: true,
              isBoldValueText: true,
              isScaleDownTitle: true,
              titleLabel: '${S.current.raisedDayLeft}',
              valueText: loan.raisedDayLeftFormatted));
          _buttons = _buttonsWidget(
            outLineLabel: S.current.earlyDisbursement,
            onPressedOutLine: () =>
                _loanPushToActionUtils.pushToEarlyDisbursement(context, loan),
          );
        }

        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        break;
      case LoanApplicationStatus.FundOvertime:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
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
            valueColor:
                loan.isEnoughToDisbursement ? mColorBodyTextGreen : mColorBad,
            titleLabel: '${S.current.amountRaised}',
            valueText: loan.raisedAmountFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            valueColor: mColorBad,
            titleLabel: '${S.current.raisedDayLeft}',
            valueText: '0 ngày'));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.loanDurationConfirm}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        if (loan.isEnoughToDisbursement) {
          _buttons = _buttonsWidget(
            gradientLabel: S.current.disbursement,
            onPressedGradient: () =>
                _loanPushToActionUtils.pushToDisbursement(context, loan),
          );
        } else {
          _buttons = _buttonsWidget(
            gradientLabel: S.current.createNewLoan,
            onPressedGradient: () =>
                _loanPushToActionUtils.pushToCreateLoanDefault(
                    context,
                    (BlocProvider.of<HomeCubit>(context).state as HomeLoaded)
                        .loanProducts!),
            outLineLabel: S.current.deleteLoanRequest,
            onPressedOutLine: () =>
                _loanPushToActionUtils.deleteLoanRequest(context, loan),
          );
        }
        break;
      case LoanApplicationStatus.DisburmentPending:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateSubmitLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueColor: mColorBodyTextGreen,
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.readContract,
          onPressedGradient: () =>
              _loanPushToActionUtils.pushToContract(context, true),
        );
        break;
      case LoanApplicationStatus.OnLoan:
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            titleLabel: '${S.current.dateLoan}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.amountLoan}',
            valueColor: mColorBodyTextGreen,
            valueText: loan.loanAmountActualFormatted));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isScaleDownTitle: true,
            isBoldValueText: true,
            titleLabel: '${S.current.numberMonthPaid}',
            valueText: "0 tháng"));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isScaleDownTitle: true,
            titleLabel: '${S.current.nextPaymentDate}',
            valueText: loan.createDateTimeFormatted!));
        _listTileItem.add(AppListTileTitleValueWidget(
            hideTopBorder: true,
            isBoldValueText: true,
            titleLabel: '${S.current.durationLoan}',
            valueText: '${loan.loanDuration!.toString()} '
                '${loan.durationUnitTranslated.toLowerCase()}'));
        _buttons = _buttonsWidget(
          gradientLabel: S.current.pay,
          outLineLabel: S.current.historyPayment,
          onPressedGradient: () =>
              _loanPushToActionUtils.pushToPay(context, loan),
          onPressedOutLine: () =>
              _loanPushToActionUtils.pushToHistoryPayment(context, loan),
        );
        break;
    }

    _listTileItem.add(AppListTileTitleValueWidget(
        hideTopBorder: true,
        titleLabel: '${S.current.status}',
        valueColor: loan.statusColor,
        valueText: '${loan.statusText}'));
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
        hideBottomBorder: true,
        titleLabel: '${S.current.loanProduct}',
        valueText: loan.loanProduct!));
  }

  @override
  Widget build(BuildContext context) {
    _mapStatusLoanToWidgets(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<LoanCubit, LoanState>(
          listener: (context, state) {
            if (state is LoanLoaded &&
                state.actionEnum == LoanAppActionEnum.REMOVE) {
              _removeLoanSuccess(context);
            }
          },
        ),
        BlocListener<LoaderCubit, LoaderState>(
            bloc: BlocProvider.of<LoanCubit>(context).loaderCubit,
            listener: (context, state) {
              if (state is LoanLoaded) {
                switch (state.runtimeType) {
                  case LoaderLoaded:
                    _loadingDialog.popDialog(context: context);
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
          titleText: appBarTitle ?? S.current.detailLoan,
          callbackLeading: () => Navigator.pop(context),
        ),
        body: CompactLayout(
          // padding: EdgeInsets.all(PlatformLayoutConstants.marginCompactLayout),
          child: Column(
            children: [
              _titleWidget(context),
              VerticalSpace.init16(),
              _loanDetailContainer(),
              VerticalSpace.init16(),
              if (_buttons != null)
                Column(
                  children: [
                    _buttons!,
                    VerticalSpace.init16(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title!,
            style: titleStyle,
          ),
          VerticalSpace.init16(),
          if (_msg != null)
            RichText(
                text: TextSpan(
                    style:
                        Theme.of(context).textTheme.textDescriptionGreyNormal,
                    text: _msg!,
                    children: [
                  if (_msg1 != null)
                    TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .textDescriptionGreyNormal
                          .copyWith(fontWeight: FontWeight.bold),
                      text: _msg1!,
                    )
                ]))
        ],
      ),
    );
  }

  Widget _loanDetailContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(color: mColorBordersLines)),
      child: Column(
        children: _listTileItem,
      ),
    );
  }

  Widget _buttonsWidget(
      {String? gradientLabel,
      Function? onPressedGradient,
      String? outLineLabel,
      Function? onPressedOutLine}) {
    return Column(
      children: [
        if (gradientLabel != null && onPressedGradient != null)
          Column(
            children: [
              RaisedGradientButton(
                label: gradientLabel,
                onPressed: () => onPressedGradient(),
              ),
              VerticalSpace.init8(),
            ],
          ),
        if (outLineLabel != null && onPressedOutLine != null)
          Column(
            children: [
              AppOutLineButton(
                label: outLineLabel,
                onPressed: () => onPressedOutLine(),
              ),
              VerticalSpace.init8(),
            ],
          )
      ],
    );
  }
}
