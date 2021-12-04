part of 'payment_account_step_cubit.dart';

@immutable
abstract class PaymentAccountStepState extends Equatable {}

class PaymentAccountStepInitial extends PaymentAccountStepState {
  @override
  List<Object> get props => [];
}

class PaymentAccountStepLoaded extends PaymentAccountStepState {
  bool isCurrent;
  final LinkedPaymentLoanDetailResponse? linkedPaymentSelected;

  PaymentAccountStepLoaded(
      {this.isCurrent = true, required this.linkedPaymentSelected});

  PaymentAccountStepLoaded copyWith(
      {LinkedPaymentLoanDetailResponse? linkedPaymentSelected}) {
    return PaymentAccountStepLoaded(
        isCurrent: !isCurrent, linkedPaymentSelected: linkedPaymentSelected);
  }

  @override
  List<Object> get props =>
      [isCurrent, if (linkedPaymentSelected != null) linkedPaymentSelected!];
}
