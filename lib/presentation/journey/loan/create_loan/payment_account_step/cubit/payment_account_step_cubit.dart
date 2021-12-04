import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/linked_payment_loan_detail_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';

part 'payment_account_step_state.dart';

class PaymentAccountStepCubit extends Cubit<PaymentAccountStepState> {
  PaymentAccountStepCubit() : super(PaymentAccountStepInitial());

  late LinkedPaymentLoanDetailResponse? linkedPaymentSelected;

  late CreateLoanCubit _createLoanCubit;

  void initData(CreateLoanCubit createLoanCubit,
      {LinkedPaymentLoanDetailResponse? linkedPaymentSelected}) {
    _createLoanCubit = createLoanCubit;
    this.linkedPaymentSelected = linkedPaymentSelected;

    emit(
        PaymentAccountStepLoaded(linkedPaymentSelected: linkedPaymentSelected));
  }

  // set create loan request model value in create loan cubit
  Future saveData() =>
      _createLoanCubit.setLinkedPaymentData(linkedPaymentSelected!);

  void linkedPaymentChanged(LinkedPaymentResponse data) {
    final currentState = state;
    if (currentState is PaymentAccountStepLoaded) {
      linkedPaymentSelected = data.toLinkedPaymentDetailLoan();
      emit(currentState.copyWith(linkedPaymentSelected: linkedPaymentSelected));
    }
  }
}
