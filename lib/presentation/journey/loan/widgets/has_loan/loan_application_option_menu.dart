import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/common/constants/loan_application_status_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/dropdown_menu/dropdown_menu_model.dart';
import 'package:p2p_borrower/presentation/common/components/dropdown_menu/dropdown_with_arrow.dart';
import 'package:p2p_borrower/presentation/common/loan_utils/loan_push_to_action_utils.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class LoanApplicationOptionMenu extends StatelessWidget {
  LoanApplicationOptionMenu({Key? key, required this.item}) : super(key: key);

  final LoanApplicationResponse? item;

  late List<DropDownMenuModel> itemModels;
  final LoanPushToActionUtils _loanPushToActionUtils = LoanPushToActionUtils();

  @override
  Widget build(BuildContext context) {
    switch (item!.status!) {
      case LoanApplicationStatus.Draft:
        itemModels = [
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.completeLoan(context, item!),
              label: S.current.completeLoan,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.cancelLoan(context, item!),
              label: S.current.cancelLoanRequest,
              color: mColorBad)
        ];
        break;
      case LoanApplicationStatus.Submitted:
        itemModels = [
          DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.editLoan(context, item!),
              label: S.current.editLoan,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.cancelLoan(context, item!),
              label: S.current.cancelLoanRequest,
              color: mColorBad)
        ];
        break;
      case LoanApplicationStatus.UpdateRequired:
        itemModels = [
          DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.editLoan(context, item!),
              label: S.current.updateInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.cancelLoan(context, item!),
              label: S.current.cancelLoanRequest,
              color: mColorBad)
        ];
        break;
      case LoanApplicationStatus.MoreInfoRequired:
        itemModels = [
          DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.editLoan(context, item!),
              label: S.current.implementInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.cancelLoan(context, item!),
              label: S.current.cancelLoanRequest,
              color: mColorBad)
        ];
        break;
      case LoanApplicationStatus.Reject:
        itemModels = [
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.deleteLoanRequest(context, item!),
              label: S.current.deleteLoanRequest,
              borderBottom: true,
              color: mColorBad),
        ];
        break;
      case LoanApplicationStatus.InterestRateConfirm:
        itemModels = [
          DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.pushToInterestRateConfirm(
                  context, item!),
              label: S.current.interestRateConfirm,
              borderBottom: true,
              color: mColorBodyTextGreen),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
        ];
        break;
      case LoanApplicationStatus.OnMarket:
        itemModels = [
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
        ];
        break;
      case LoanApplicationStatus.FundRaised:
        itemModels = [];
        if (item!.isRaisedEnough) {
          itemModels.add(DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.pushToDisbursement(context, item!),
              label: S.current.disbursement,
              borderBottom: true,
              color: mColorBodyTextGreen));
        } else if (item!.isEnoughToDisbursement) {
          itemModels.add(DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.pushToEarlyDisbursement(
                  context, item!),
              label: S.current.earlyDisbursement,
              borderBottom: true,
              color: mColorBodyTextGreen));
        }

        itemModels.add(DropDownMenuModel(
            onPressed: () => _loanPushToActionUtils.detailLoan(context, item!),
            label: S.current.detailInfo,
            borderBottom: true,
            color: mColorBodyText));
        break;
      case LoanApplicationStatus.FundOvertime:
        itemModels = [];
        if (item!.isEnoughToDisbursement) {
          itemModels.add(DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.pushToDisbursement(context, item!),
              label: S.current.disbursement,
              borderBottom: true,
              color: mColorBodyTextGreen));
        }
        itemModels.add(DropDownMenuModel(
            onPressed: () => _loanPushToActionUtils.detailLoan(context, item!),
            label: S.current.detailInfo,
            borderBottom: true,
            color: mColorBodyText));
        if (!item!.isEnoughToDisbursement) {
          itemModels.add(DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.deleteLoanRequest(context, item!),
              label: S.current.deleteLoanRequest,
              borderBottom: true,
              color: mColorBad));
        }
        break;
      case LoanApplicationStatus.DisburmentPending:
        itemModels = [
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
        ];
        break;
      case LoanApplicationStatus.OnLoan:
        itemModels = [
          DropDownMenuModel(
              onPressed: () => _loanPushToActionUtils.pushToPay(context, item!),
              label: S.current.pay,
              borderBottom: true,
              color: mColorBodyTextGreen),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.detailLoan(context, item!),
              label: S.current.detailInfo,
              borderBottom: true,
              color: mColorBodyText),
          DropDownMenuModel(
              onPressed: () =>
                  _loanPushToActionUtils.pushToHistoryPayment(context, item!),
              label: S.current.historyPayment,
              color: mColorBodyText),
        ];
        break;
      default:
        itemModels = [
          DropDownMenuModel(
              onPressed: () {}, label: S.current.removeLoan, color: mColorBad)
        ];
    }

    return DropDownWithArrow(
      childrenModel: itemModels,
      widthBox: 278.w,
      sizeIcon: 16.w,
      backgroundColor: Colors.white,
      icon: SvgPicture.asset(
        IconConstants.icDetail,
        color: mColorDescription,
      ),
    );
  }
}
