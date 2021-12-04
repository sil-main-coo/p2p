part of 'create_loan_cubit.dart';

abstract class CreateLoanState extends Equatable {
  const CreateLoanState();
}

class CreateLoanInitial extends CreateLoanState {
  @override
  List<Object> get props => [];
}

class CreateLoanLoading extends CreateLoanState {
  @override
  List<Object?> get props => [];
}

class CreateLoanLoaded extends CreateLoanState {
  final LoanMasterDataResponse loanMasterDataResponse;
  final List<LoanProductsResponse> loanProducts;
  final LoanProductsResponse loanProductSelected;

  CreateLoanLoaded(
      {required this.loanMasterDataResponse,
      required this.loanProducts,
      required this.loanProductSelected});

  @override
  List<Object?> get props =>
      [loanMasterDataResponse, loanProducts, loanProductSelected];
}

class CreateLoanFailure extends CreateLoanState {
  final String msg;

  const CreateLoanFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
