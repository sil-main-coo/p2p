part of 'step_create_loan_navigator_cubit.dart';

abstract class StepCreateLoanNavigatorState extends Equatable {
  final int index;

  StepCreateLoanNavigatorState({this.index = 0});

  @override
  List<Object> get props => [this.index];
}

class StepCreateLoanInitial extends StepCreateLoanNavigatorState {
  StepCreateLoanInitial({int index = 0}) : super(index: index);
}

class StepCreateLoanEnd extends StepCreateLoanNavigatorState {
  StepCreateLoanEnd({required int index}) : super(index: index);
}

class StepCreateLoanExit extends StepCreateLoanNavigatorState {}

class StepCreateLoanLoading extends StepCreateLoanNavigatorState {
  StepCreateLoanLoading(int index) : super(index: index);
}
