import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';

class HomeUseCase {
  final LoanRepository loanRepository;

  HomeUseCase({required this.loanRepository});

  Future<List<LoanProductsResponse>?>? fetchLoanTypeProducts() async =>
      await loanRepository.fetchLoanTypeProducts();
}
