import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/presentation/journey/loan/action_loan/action_loan_screen.dart';

import 'package:p2p_borrower/presentation/journey/loan/create_loan/create_loan_screen.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_contract/loan_contract_screen.dart';
import 'package:p2p_borrower/presentation/journey/loan/payment/payment_screen.dart';
import 'confim_interest_rate_success/confirm_interest_rate_success_screen.dart';
import 'create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';
import 'create_loan/cubits/step_navigator_cubit/step_create_loan_navigator_cubit.dart';
import 'create_success/create_loan_success_has_noti_screen.dart';
import 'history_payment/history_payment_screen.dart';
import 'loan_detail/loan_detail_screen.dart';
import 'review_loan/cubit/review_loan_cubit.dart';
import 'review_loan/review_loan_screen.dart';
import 'sign_contract_success/sign_contract_success_screen.dart';

class LoanRoute extends RouteDefine {
  static const createLoanID = 'create-loan-id';
  static const createReviewLoanID = 'create-review-loan';
  static const createLoanSuccessHasNotifyID = 'create-loan-success-has-notify';
  static const detailLoanID = 'detail-loan-id';
  static const actionLoanID = 'action-loan-id';
  static const loanContractID = 'loan-contract-id';
  static const confirmInterestRateSuccess = 'interest-rate-success';
  static const signContractSuccessID = 'sign-contract-success-id';
  static const historyPaymentID = 'history-payment-id';
  static const loanPaymentID = 'loan-payment-id';

  static const argLoanProducts = 'arg-loan-products';
  static const argLoanSelected = 'arg-loan-selected';
  static const argLoanRequest = 'arg-loan-request';
  static const argLoanSimple = 'arg-loan-simple';
  static const argHiveKeyLoanSimple = 'arg-hive-key-loan-simple';
  static const argIsRemoteLoan = 'arg-is-remote-loan';
  static const argReviewLoanAppAction = 'arg-review-loan-app-action';
  static const argDetailLoanTitle = 'arg-detail-loan-title';
  static const argIsSignedContract = 'arg-is-signed-contract';

  @override
  List<Path> initRoute(Object? arguments) {
    Map<String, dynamic>? args;

    if (arguments != null) {
      args = arguments as Map<String, dynamic>;
    }
    return [
      Path(
          name: createLoanID,
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(create: (_) {
                  bool isRemote;
                  LoanAppActionEnum? loanAction;

                  if (args![argLoanSimple] == null) {
                    // create new loan
                    isRemote = false;
                    loanAction = LoanAppActionEnum.CREATE;
                  } else {
                    // edit loan
                    isRemote =
                        args[argIsRemoteLoan] ?? true; // default is remote loan
                    if (isRemote) {
                      loanAction = LoanAppActionEnum.UPDATE;
                    } else {
                      loanAction = LoanAppActionEnum.CREATE;
                    }
                  }

                  return getIt.get<CreateLoanCubit>()
                    ..fetchMasterLoanData(
                        loanSimple: args[argLoanSimple],
                        loanProducts: args[argLoanProducts],
                        loanAction: loanAction,
                        isRemote: isRemote,
                        loanProductSelected: args[argLoanSelected]);
                }),
                BlocProvider(
                    create: (_) => StepCreateLoanNavigatorCubit()..initStep()),
              ], child: CreateLoanScreen())),
      Path(
          name: createReviewLoanID,
          builder: (context) => BlocProvider(
                create: (context) => getIt.get<ReviewLoanCubit>()
                  ..initData(args![argHiveKeyLoanSimple],
                      BlocProvider.of<LoanCubit>(context)),
                child: ReviewLoanScreen(
                  loanRequest: args![argLoanRequest],
                  loanAppActionEnum: args[argReviewLoanAppAction],
                ),
              )),
      Path(
          name: createLoanSuccessHasNotifyID,
          builder: (context) => CreateLoanSuccessHasNotifyScreen()),
      Path(
          name: detailLoanID,
          builder: (context) => LoanDetailScreen(loan: args![argLoanSimple])),
      Path(
          name: confirmInterestRateSuccess,
          builder: (context) => ConfirmInterestRateSuccessScreen()),
      Path(
          name: actionLoanID,
          builder: (context) => ActionLoanScreen(
                actionEnum: args![argReviewLoanAppAction],
                loan: args[argLoanSimple],
              )),
      Path(
          name: loanContractID,
          builder: (context) => LoanContractScreen(
                isSigned: args![argIsSignedContract],
                loanSimple: args[argLoanSimple],
              )),
      Path(
          name: signContractSuccessID,
          builder: (context) => SignContractSuccessScreen()),
      Path(
          name: historyPaymentID, builder: (context) => HistoryPaymentScreen()),
      Path(
          name: loanPaymentID, builder: (context) => PaymentScreen()),
    ];
  }
}
