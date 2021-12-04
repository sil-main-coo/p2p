part of '../create_loan_loaded_widget.dart';

class ConnectFacebookStepWidget extends StatelessWidget {
  const ConnectFacebookStepWidget({Key? key, required this.stepName})
      : super(key: key);

  final String stepName;

  Function? _nextStep(BuildContext context) {
    final connectSocialState = context.watch<ConnectSocialCubit>().state;

    if (connectSocialState is ConnectSocialLogged) {
      return () {
        BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
      };
    }
    return null;
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }

  @override
  Widget build(BuildContext context) {
    return StepCreateLoanLayout(
      title: S.current.createLoanTitle,
      subTitle: '$stepName: ${S.current.connectFacebook}',
      backStep: () => _backStep(context),
      nextStep: _nextStep(context),
      body: ConnectFacebookLayout(),
    );
  }
}
