part of 'linking_payment_cubit.dart';

abstract class LinkingPaymentState extends Equatable {
  const LinkingPaymentState();
}

class LinkingPaymentInitial extends LinkingPaymentState {
  @override
  List<Object> get props => [];
}

class LinkingPaymentLoading extends LinkingPaymentState {
  @override
  List<Object?> get props => [];
}

class LinkingPaymentFailure extends LinkingPaymentState {
  final String msg;

  const LinkingPaymentFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class LinkingPaymentLoaded extends LinkingPaymentState {
  final List<PaymentServiceResponse> bankServices;
  final List<PaymentServiceResponse> virtualWalletServices;
  final PaymentServiceResponse? bankSelected;
  final PaymentServiceResponse? walletSelected;
  final bool isValid;
  final int? indexTab;
  final bool isSuccessAction;
  final LinkedPaymentResponse? linkedPayment;
  final bool isLoadingAction;
  final String? errorAction;
  bool isCurrent;

  LinkingPaymentLoaded(
      {required this.bankServices,
      required this.virtualWalletServices,
      required this.isValid,
      this.linkedPayment,
      this.isSuccessAction = false,
      this.isLoadingAction = false,
      this.errorAction,
      this.indexTab,
      this.bankSelected,
      this.walletSelected,
      this.isCurrent = true});

  LinkingPaymentLoaded failureAction(String error) {
    return LinkingPaymentLoaded(
        isCurrent: !isCurrent,
        isValid: isValid,
        indexTab: indexTab,
        virtualWalletServices: virtualWalletServices,
        walletSelected: walletSelected,
        bankSelected: bankSelected,
        bankServices: bankServices,
        errorAction: error);
  }

  LinkingPaymentLoaded successAction(
      {required LinkedPaymentResponse linkedPayment}) {
    return LinkingPaymentLoaded(
        isCurrent: !isCurrent,
        isValid: isValid,
        indexTab: indexTab,
        virtualWalletServices: virtualWalletServices,
        walletSelected: walletSelected,
        bankSelected: bankSelected,
        bankServices: bankServices,
        linkedPayment: linkedPayment,
        errorAction: null,
        isSuccessAction: true);
  }

  LinkingPaymentLoaded loading() {
    return LinkingPaymentLoaded(
        isCurrent: !isCurrent,
        isValid: isValid,
        indexTab: indexTab,
        virtualWalletServices: virtualWalletServices,
        walletSelected: walletSelected,
        bankSelected: bankSelected,
        bankServices: bankServices,
        isLoadingAction: true);
  }

  LinkingPaymentLoaded copyWith({
    List<PaymentServiceResponse>? bankServices,
    List<PaymentServiceResponse>? virtualWalletServices,
    bool? isValid,
    PaymentServiceResponse? bankSelected,
    PaymentServiceResponse? walletSelected,
    int? indexTab,
  }) {
    return LinkingPaymentLoaded(
        isCurrent: !isCurrent,
        isValid: isValid ?? this.isValid,
        indexTab: indexTab ?? this.indexTab,
        virtualWalletServices:
            virtualWalletServices ?? this.virtualWalletServices,
        walletSelected: walletSelected ?? this.walletSelected,
        bankSelected: bankSelected ?? this.bankSelected,
        bankServices: bankServices ?? this.bankServices,
        isLoadingAction: this.isLoadingAction,
        isSuccessAction: this.isSuccessAction,
        errorAction: this.errorAction);
  }

  @override
  List<Object> get props => [
        bankServices,
        virtualWalletServices,
        isCurrent,
        if (bankSelected != null) bankSelected!,
        if (walletSelected != null) walletSelected!,
        if (indexTab != null) indexTab!,
        if (errorAction != null) errorAction!,
        if (linkedPayment != null) linkedPayment!,
        isLoadingAction,
        isSuccessAction,
      ];
}
