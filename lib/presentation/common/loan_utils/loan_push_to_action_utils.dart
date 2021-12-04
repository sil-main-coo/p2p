import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/widgets/has_loan/cancel_loan_request_dialog.dart';

/// This class include push actions method of loan
/// eg: push to create new loan, push to detail, push to payment, push to disbursement...
class LoanPushToActionUtils {
  void detailLoan(BuildContext context, LoanApplicationResponse item,
      {String? title}) {
    Navigator.pushNamed(context, LoanRoute.detailLoanID, arguments: {
      LoanRoute.argLoanSimple: item,
      LoanRoute.argDetailLoanTitle: title,
    });
  }

  void editLoan(BuildContext context, LoanApplicationResponse loan) {
    final homeLoaded = BlocProvider.of<HomeCubit>(context).state as HomeLoaded;

    Navigator.pushNamed(context, LoanRoute.createLoanID, arguments: {
      LoanRoute.argLoanProducts: homeLoaded.loanProducts,
      LoanRoute.argLoanSimple: loan,
      LoanRoute.argIsRemoteLoan: true, // is remote loan ?
    });
  }

  void completeLoan(BuildContext context, LoanApplicationResponse loan) async {
    final homeLoaded = BlocProvider.of<HomeCubit>(context).state as HomeLoaded;

    final loanUpdated =
        await Navigator.pushNamed(context, LoanRoute.createLoanID, arguments: {
      LoanRoute.argLoanProducts: homeLoaded.loanProducts,
      LoanRoute.argLoanSimple: loan,
      LoanRoute.argIsRemoteLoan: false, // is remote loan ?
    });

    // if have draftLoan -> update it in loan list
    if (loanUpdated != null && loanUpdated is LoanApplicationResponse) {
      BlocProvider.of<LoanCubit>(context).updateALoanInListByKey(loanUpdated);
    }
  }

  void cancelLoan(BuildContext context, LoanApplicationResponse loan) {
    CancelLoanRequestDialog.show(context, loan.statusText, () async {
      await BlocProvider.of<LoanCubit>(context).removeLoanApplication(loan);
    });
  }

  void deleteLoanRequest(BuildContext context, LoanApplicationResponse loan) {
    // todo: implement _deleteLoanRequest
  }

  void pushToInterestRateConfirm(
      BuildContext context, LoanApplicationResponse loan) {
    Navigator.pushNamed(context, LoanRoute.actionLoanID, arguments: {
      LoanRoute.argReviewLoanAppAction: LoanAppActionEnum.CONFIRM_INTEREST_RATE,
      LoanRoute.argLoanSimple: loan,
    });
  }

  void pushToDisbursement(BuildContext context, LoanApplicationResponse loan) {
    Navigator.pushNamed(context, LoanRoute.actionLoanID, arguments: {
      LoanRoute.argReviewLoanAppAction: LoanAppActionEnum.DISBURSEMENT,
      LoanRoute.argLoanSimple: loan,
    });
  }

  void pushToEarlyDisbursement(
      BuildContext context, LoanApplicationResponse loan) {
    Navigator.pushNamed(context, LoanRoute.actionLoanID, arguments: {
      LoanRoute.argReviewLoanAppAction: LoanAppActionEnum.EARLY_DISBURSEMENT,
      LoanRoute.argLoanSimple: loan,
    });
  }

  void pushToPay(BuildContext context, LoanApplicationResponse loan) {
    Navigator.pushNamed(context, LoanRoute.loanPaymentID, arguments: {
      LoanRoute.argLoanSimple: loan,
    });
  }

  void pushToHistoryPayment(
      BuildContext context, LoanApplicationResponse loan) {
    Navigator.pushNamed(context, LoanRoute.historyPaymentID, arguments: {
      LoanRoute.argLoanSimple: loan,
    });
  }

  Future pushToCreateLoanDefault(
      BuildContext context, List<LoanProductsResponse> loanProducts) async {
    final draftLoan =
        await Navigator.pushNamed(context, LoanRoute.createLoanID, arguments: {
      LoanRoute.argLoanProducts: loanProducts,
      LoanRoute.argLoanSelected: loanProducts[0],
    });

    // if have draftLoan -> add it to loan list
    if (draftLoan != null && draftLoan is LoanApplicationResponse) {
      BlocProvider.of<LoanCubit>(context).addALoanToList(draftLoan);
    }
  }

  // if not yet signed -> pass `loanSimple` param in to method
  void pushToContract(BuildContext context, bool isSigned,
      {LoanApplicationResponse? loanSimple}) {
    Navigator.pushNamed(context, LoanRoute.loanContractID, arguments: {
      LoanRoute.argIsSignedContract: isSigned,
      LoanRoute.argLoanSimple: loanSimple
    });
  }
}
