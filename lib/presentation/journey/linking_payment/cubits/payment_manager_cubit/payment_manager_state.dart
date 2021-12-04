part of 'payment_manager_cubit.dart';

abstract class PaymentManagerState extends Equatable {
  const PaymentManagerState();
}

class PaymentManagerInitial extends PaymentManagerState {
  @override
  List<Object> get props => [];
}

class PaymentManagerLoading extends PaymentManagerState {
  @override
  List<Object?> get props => [];
}

class PaymentManagerLoaded extends PaymentManagerState {
  final List<LinkedPaymentResponse> linkedPayments;
  bool isLoadingAction;
  bool isSuccess;
  final String? error;

  bool isCurrent;

  PaymentManagerLoaded(
      {required this.linkedPayments,
      this.isCurrent = true,
      this.error,
      this.isLoadingAction = false,
      this.isSuccess = false});

  PaymentManagerLoaded copyWith(
      {required List<LinkedPaymentResponse>? linkedPayments}) {
    return PaymentManagerLoaded(
      isCurrent: !isCurrent,
      linkedPayments: linkedPayments ?? this.linkedPayments,
    );
  }

  PaymentManagerLoaded loadingAction() {
    return PaymentManagerLoaded(
        isCurrent: !isCurrent,
        linkedPayments: this.linkedPayments,
        isLoadingAction: true);
  }

  PaymentManagerLoaded failureAction(String error) {
    return PaymentManagerLoaded(
        isCurrent: !isCurrent,
        linkedPayments: this.linkedPayments,
        error: error);
  }

  PaymentManagerLoaded successAction(
      {required List<LinkedPaymentResponse>? linkedPayments}) {
    return PaymentManagerLoaded(
        isCurrent: !isCurrent,
        linkedPayments: linkedPayments ?? this.linkedPayments,
        isSuccess: true);
  }

  @override
  List<Object?> get props => [
        isCurrent,
        isLoadingAction,
        isSuccess,
        linkedPayments,
        if (error != null) error!
      ];
}

class PaymentManagerFailure extends PaymentManagerState {
  final String msg;

  const PaymentManagerFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
