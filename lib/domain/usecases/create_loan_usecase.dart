import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';
import 'package:p2p_borrower/domain/repositories/payment_repository.dart';

class CreateLoanUseCase {
  final LoanRepository loanRepository;
  final PaymentRepository paymentRepository;

  CreateLoanUseCase(
      {required this.loanRepository, required this.paymentRepository});

  Future<LoanMasterDataResponse?>? fetchLoanMasterData() =>
      loanRepository.fetchLoanMasterData();

  Future<List<LinkedPaymentResponse>?>? fetchLinkedPayment() =>
      paymentRepository.getLinkedPayment();

  Future<CreateLoanResponse?>? createLoan(
          dynamic hiveKeyLoanSimple, CreateLoanRequest request) =>
      loanRepository.createLoan(hiveKeyLoanSimple, request);

  Future<LoanApplicationDetailResponse?> getADetailLoan(bool isRemote,
          {dynamic simpleKey, int? loanID}) =>
      loanRepository.getADetailLoan(isRemote,
          loanID: loanID, simpleKey: simpleKey);

  Future<dynamic> setALoanInfoToLocal(LoanApplicationResponse simpleLoan,
          LoanApplicationDetailResponse detailLoan, bool isNewLoan) =>
      loanRepository.setALoanInfoToLocal(simpleLoan, detailLoan, isNewLoan);
}
