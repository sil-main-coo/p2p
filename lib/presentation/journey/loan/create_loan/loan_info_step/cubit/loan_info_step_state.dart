part of 'loan_info_step_cubit.dart';

abstract class LoanInfoStepState extends Equatable {
  const LoanInfoStepState();
}

class LoanInfoStepInitial extends LoanInfoStepState {
  @override
  List<Object> get props => [];
}

class LoanInfoStepLoaded extends LoanInfoStepState {
  final String serviceCharge, expectedAmountCharge;
  final int? initAmount, initDuration;

  LoanInfoStepLoaded({
    this.initAmount,
    this.initDuration,
    required this.serviceCharge,
    required this.expectedAmountCharge,
  });

  LoanInfoStepLoaded copyWith(
      {LoanProductsResponse? loanProductSelected,
      List<LoanProductsResponse>? loanProducts,
      String? serviceCharge,
      String? expectedAmountCharge,
      LoanMasterDataResponse? masterDataResponse,
      int? initAmount,
      int? initDuration}) {
    return LoanInfoStepLoaded(
        expectedAmountCharge: expectedAmountCharge ?? this.expectedAmountCharge,
        serviceCharge: serviceCharge ?? this.serviceCharge,
        initAmount: initAmount ?? this.initAmount,
        initDuration: initDuration ?? this.initDuration);
  }

  @override
  List<Object> get props => [
        serviceCharge,
        expectedAmountCharge,
        if (initAmount != null) initAmount!,
        if (initDuration != null) initDuration!
      ];
}
