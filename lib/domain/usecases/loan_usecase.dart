import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';

class LoanUseCase {
  final LoanRepository loanRepository;

  LoanUseCase({required this.loanRepository});

  Future<List<LoanApplicationResponse>?>? getLoanApplicationsByBorrower() =>
      loanRepository.getLoanApplicationsByBorrower();

  Future<void> removeLoan(bool isRemote, LoanApplicationResponse item) =>
      loanRepository.removeLoan(isRemote, item);
}
