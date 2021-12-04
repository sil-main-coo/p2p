import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/request/loan_status_request.dart';
import 'package:p2p_borrower/data/model/response/base_response.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';

class UpdateLoanUseCase {
  final LoanRepository loanRepository;

  UpdateLoanUseCase({required this.loanRepository});

  Future<CreateLoanResponse?>? updateLoan(CreateLoanRequest request) =>
      loanRepository.updateLoan(request);

  Future<List<ValidateAttribute>?> getValidateAttributeLoan(int loanID) =>
      loanRepository.getValidateAttributeLoan(loanID);

  Future<BaseResponse?>? signLoanContract(LoanStatusRequest request) =>
      loanRepository.signLoanContract(request);
}
