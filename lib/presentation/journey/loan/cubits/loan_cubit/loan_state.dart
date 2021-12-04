part of 'loan_cubit.dart';

abstract class LoanState extends Equatable {
  const LoanState();
}

class LoanInitial extends LoanState {
  @override
  List<Object> get props => [];
}

class LoanLoading extends LoanState {
  @override
  List<Object> get props => [];
}

class LoanLoaded extends LoanState {
  final List<LoanApplicationResponse> loanApplications;
  final LoanAppActionEnum? actionEnum;

  bool isCurrent;

  LoanLoaded({
    required this.loanApplications,
    this.actionEnum,
    this.isCurrent = true,
  });

  LoanLoaded copyWith(
      {List<LoanApplicationResponse>? loanApplications,
      LoanAppActionEnum? actionEnum}) {
    return LoanLoaded(
        isCurrent: !isCurrent,
        loanApplications: loanApplications ?? this.loanApplications,
        actionEnum: actionEnum);
  }

  @override
  List<Object> get props =>
      [loanApplications, isCurrent, if (actionEnum != null) actionEnum!];
}

class LoanFailure extends LoanState {
  final String msg;

  const LoanFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
