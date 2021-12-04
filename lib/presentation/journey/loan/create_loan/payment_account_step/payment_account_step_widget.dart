part of '../create_loan_loaded_widget.dart';

class PaymentAccountStepWidget extends StatelessWidget {
  const PaymentAccountStepWidget({Key? key, required this.stepName})
      : super(key: key);

  final String stepName;

  void _nextStep(BuildContext context) {
    BlocProvider.of<PaymentAccountStepCubit>(context).saveData();
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentAccountStepCubit, PaymentAccountStepState>(
        builder: (context, state) {
      if (state is PaymentAccountStepLoaded) {
        return StepCreateLoanLayout(
          title: S.current.createLoanTitle,
          subTitle: '$stepName: ${S.current.paymentAccount}',
          backStep: () => _backStep(context),
          nextStep: _isValid(context, state.linkedPaymentSelected)
              ? () => _nextStep(context)
              : null,
          body: LinkingPaymentFragment(
            action: ActionPaymentScreenEnum.SELECT,
          ),
        );
      }
      return SizedBox();
    });
  }

  bool _isValid(BuildContext context,
      LinkedPaymentLoanDetailResponse? linkedPaymentSelected) {
    final paymentCubitState = context.watch<PaymentManagerCubit>().state;

    if (paymentCubitState is PaymentManagerLoaded) {
      return (paymentCubitState.linkedPayments.isNotEmpty &&
          linkedPaymentSelected != null &&
          paymentCubitState.linkedPayments.indexWhere(
                  (element) => element.id == linkedPaymentSelected.id) !=
              -1);
    }
    return false;
  }
}
