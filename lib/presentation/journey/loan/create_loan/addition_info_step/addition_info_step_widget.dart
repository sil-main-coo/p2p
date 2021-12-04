part of '../create_loan_loaded_widget.dart';

class AdditionInfoStepWidget extends StatelessWidget {
  AdditionInfoStepWidget(
      {Key? key, required this.stepName, required this.additionalInfoList})
      : super(key: key);

  final String stepName;
  final List<AdditionalInfos> additionalInfoList;

  void _nextStep(BuildContext context) {
    BlocProvider.of<AdditionInfoStepCubit>(context).saveData();
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionInfoStepCubit, AdditionInfoStepState>(
      builder: (context, state) {
        if (state is AdditionInfoStepLoaded) {
          return StepCreateLoanLayout(
            title: S.current.createLoanTitle,
            subTitle: '$stepName: ${S.current.additionInfo}',
            backStep: () => _backStep(context),
            nextStep: state.isValid ? () => _nextStep(context) : null,
            body: AdditionalInfoFormWidget(
              additionalInfoList: additionalInfoList,
              mapTextValues: state.mapTextValues,
              mapPictureValues: state.mapPictureValues,
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
