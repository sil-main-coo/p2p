part of 'review_loan_cubit.dart';

abstract class ReviewLoanState extends Equatable {
  const ReviewLoanState();
}

class ReviewLoanInitial extends ReviewLoanState {
  @override
  List<Object> get props => [];
}

class ReviewLoanLoading extends ReviewLoanState {
  @override
  List<Object> get props => [];
}

class ReviewLoanSuccess extends ReviewLoanState {
  @override
  List<Object> get props => [];
}

class ReviewLoanFailure extends ReviewLoanState {
  final String msg;

  ReviewLoanFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
