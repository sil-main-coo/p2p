import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'step_create_loan_navigator_state.dart';

class StepCreateLoanNavigatorCubit extends Cubit<StepCreateLoanNavigatorState> {
  StepCreateLoanNavigatorCubit() : super(StepCreateLoanInitial());

  late int _START_STEP;
  late int _END_STEP;

  void initStep() {
    _START_STEP = 0;
    // if (loanProductSelected.additionalInfos!.isEmpty) {
    //   _END_STEP = 5;
    // } else {
    _END_STEP = 6;
    // }
  }

  void incrementStep() {
    emit(StepCreateLoanLoading(state.index));
    if (state.index == _END_STEP) {
      emit(StepCreateLoanEnd(index: state.index));
      return;
    }
    emit(StepCreateLoanInitial(index: state.index + 1));
  }

  void decrementStep() {
    emit(StepCreateLoanLoading(state.index));
    if (state.index == _START_STEP) {
      emit(StepCreateLoanExit());
      return;
    }

    emit(StepCreateLoanInitial(index: state.index - 1));
  }
}
