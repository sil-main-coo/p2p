part of '../create_loan_loaded_widget.dart';

class IDInfoStepWidget extends StatelessWidget {
  IDInfoStepWidget({Key? key, required this.stepName}) : super(key: key);

  final String stepName;

  final _formKey = GlobalKey<FormState>();

  void _nextStep(BuildContext context) {
    if (_isValidate()) {
      BlocProvider.of<IDInfoStepCubit>(context).saveData();
      BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
    }
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }

  bool _isValidate() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IDInfoStepCubit, IDInfoStepState>(
      builder: (context, state) {
        if (state is IDInfoStepLoaded) {
          return StepCreateLoanLayout(
            title: S.current.createLoanTitle,
            subTitle: '$stepName: ${S.current.ID}',
            backStep: () => _backStep(context),
            nextStep: state.isValid ? () => _nextStep(context) : null,
            body: _step5Form(context, state),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _step5Form(
    BuildContext context,
    IDInfoStepLoaded state,
  ) {
    final spaceWidget = VerticalSpace(
      height: 24,
    );

    return CompactLayout(
      paddingHorizontalZero: true,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ItemImageWidget(
              errorText: state
                  .profileValidAttribute?[
                      StepCreateLoanConstants.IdCardWithUserName]
                  ?.errorText,
              typePicture: TypePicture.idCardWithUserImage,
              imageBytes: state.idCardWithUserImage,
              deletePictureCallback: () =>
                  BlocProvider.of<IDInfoStepCubit>(context)
                      .deletePicture(TypePicture.idCardWithUserImage),
            ),
            spaceWidget,
            ItemImageWidget(
              errorText: state
                  .profileValidAttribute?[
                      StepCreateLoanConstants.IdCardFrontName]
                  ?.errorText,
              typePicture: TypePicture.idCardFrontImage,
              imageBytes: state.idCardFrontImage,
              deletePictureCallback: () =>
                  BlocProvider.of<IDInfoStepCubit>(context)
                      .deletePicture(TypePicture.idCardFrontImage),
            ),
            spaceWidget,
            ItemImageWidget(
              errorText: state
                  .profileValidAttribute?[
                      StepCreateLoanConstants.IdCardBackName]
                  ?.errorText,
              typePicture: TypePicture.idCardBackImage,
              imageBytes: state.idCardBackImage,
              deletePictureCallback: () =>
                  BlocProvider.of<IDInfoStepCubit>(context)
                      .deletePicture(TypePicture.idCardBackImage),
            )
          ],
        ),
      ),
    );
  }
}
