part of '../create_loan_loaded_widget.dart';

class OccupationInfoStepWidget extends StatefulWidget {
  OccupationInfoStepWidget({Key? key, required this.stepName})
      : super(key: key);

  final String stepName;

  @override
  _OccupationInfoStepState createState() => _OccupationInfoStepState();
}

class _OccupationInfoStepState extends State<OccupationInfoStepWidget> {
  final _formKey = GlobalKey<FormState>();

  final _ctrlOccupation = TextEditingController();

  final _ctrlPositionOccupation = TextEditingController();

  final _ctrlWorkplaceName = TextEditingController();

  final _ctrlMonthlyIncome = TextEditingController();

  final _ctrlAddressOccupation = TextEditingController();

  final _ctrlPhoneOccupation = TextEditingController();

  late OccupationInfoStepCubit occupationInfoStepCubit;

  late bool isStudent;

  void _nextStep(BuildContext context) {
    if (_isValidate()) {
      if (isStudent) {
        occupationInfoStepCubit.simpleDataChanged(
            workplaceName: _ctrlWorkplaceName.text.trim(),
            workplacePhone: _ctrlPhoneOccupation.text.trim());
      } else {
        occupationInfoStepCubit.simpleDataChanged(
            workplaceName: _ctrlWorkplaceName.text.trim(),
            monthlyIncome: _ctrlMonthlyIncome.text.trim(),
            workplacePhone: _ctrlPhoneOccupation.text.trim());
      }
      occupationInfoStepCubit.saveData(isStudent);
      BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
    }
  }

  bool _isValidate() {
    return _formKey.currentState!.validate();
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }

  @override
  void dispose() {
    super.dispose();
    _ctrlOccupation.dispose();
    _ctrlPositionOccupation.dispose();
    _ctrlWorkplaceName.dispose();
    _ctrlMonthlyIncome.dispose();
    _ctrlAddressOccupation.dispose();
    _ctrlPhoneOccupation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    occupationInfoStepCubit = BlocProvider.of<OccupationInfoStepCubit>(context);

    return StepCreateLoanLayout(
      title: S.current.createLoanTitle,
      subTitle: '${widget.stepName}: ${S.current.occupationInfo}',
      backStep: () => _backStep(context),
      nextStep: () => _nextStep(context),
      body: BlocBuilder<OccupationInfoStepCubit, OccupationInfoStepState>(
        builder: (context, state) {
          if (state is OccupationInfoStepLoaded) {
            return _step3Form(context, state.occupationDataResponse);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _step3Form(
      BuildContext context, OccupationInfoStepResponse occupationDataResponse) {
    final createLoanState =
        BlocProvider.of<CreateLoanCubit>(context).state as CreateLoanLoaded;
    final masterDataResponse = createLoanState.loanMasterDataResponse;
    final spaceWidget = VerticalSpace(
      height: 24,
    );
    final occupation = occupationDataResponse.occupation;
    final profileValidAttributes = occupationDataResponse.profileValidAttribute;

    isStudent = (occupation != null &&
        occupation.code == OccupationEnums.Student.toString().enumToName);

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  _occupationSelect(context, masterDataResponse.occupations!,
                      occupation, profileValidAttributes),
                  Visibility(
                    visible: !isStudent,
                    child: Column(
                      children: [
                        spaceWidget,
                        _positionOccupation(
                            context,
                            masterDataResponse.occupationPositions!,
                            occupationDataResponse.occupationPosition,
                            profileValidAttributes,
                            isStudent),
                      ],
                    ),
                  ),
                  spaceWidget,
                  _workplaceName(
                      isStudent,
                      occupationDataResponse.workplaceName,
                      profileValidAttributes),
                  Visibility(
                    visible: !isStudent,
                    child: Column(
                      children: [
                        spaceWidget,
                        _monthIncomeWidget(context, isStudent,
                            occupationDataResponse.monthlyIncome),
                      ],
                    ),
                  ),
                  spaceWidget,
                  _addressOccupation(context, masterDataResponse.addresses!,
                      occupationDataResponse.occupationAddress, isStudent),
                  spaceWidget,
                  _phoneOccupation(
                      isStudent, occupationDataResponse.workplacePhone),
                  VerticalSpace(
                    height: 12,
                  ),
                  Text(
                    S.current.occupationNote,
                    style: Theme.of(context).textTheme.textSub,
                  )
                ]))));
  }

  Widget _occupationSelect(
      BuildContext context,
      List<OccupationResponse> data,
      OccupationResponse? dataSelected,
      Map<String, ValidateAttribute>? profileValidAttributes) {
    return AppTextFieldSuffixDropDown(
      controller: _ctrlOccupation,
      initialValue: dataSelected?.name,
      errorText: profileValidAttributes?[StepCreateLoanConstants.OccupationName]
          ?.errorText,
      validator: (occupation) {
        if (AppValidators.isEmptyStringData(occupation)) {
          return '${S.current.validatorEmptyField} '
              '${S.current.occupation.toLowerCase()} '
              '${S.current.yourself.toLowerCase()} '
              '${S.current.validatorToNextMsg.toLowerCase()}';
        }
        return null;
      },
      onTapFieldCallback: () {
        SelectOccupationDialog.show(
            context: context,
            data: data,
            dataSelected: dataSelected,
            callbackSelect: (occupation) {
              _ctrlOccupation.text = occupation.name!;
              occupationInfoStepCubit.occupationChanged(occupation);
            });
      },
      labelText: S.current.occupation,
      isRequired: true,
      hintText: '${S.current.occupation} ${S.current.yourself.toLowerCase()}',
    );
  }

  Widget _positionOccupation(
      BuildContext context,
      List<OccupationPositionResponse> data,
      OccupationPositionResponse? selected,
      Map<String, ValidateAttribute>? profileValidAttributes,
      bool isStudent) {
    return Column(
      children: [
        AppTextFieldSuffixDropDown(
          controller: _ctrlPositionOccupation,
          initialValue: selected != null ? selected.toString() : null,
          errorText: profileValidAttributes?[
                  StepCreateLoanConstants.OccupationPositionName]
              ?.errorText,
          validator: isStudent
              ? null
              : (occupation) {
                  if (AppValidators.isEmptyStringData(occupation)) {
                    return '${S.current.validatorEmptyField} '
                        '${S.current.positionOccupation.toLowerCase()} '
                        '${S.current.yourself.toLowerCase()} '
                        '${S.current.validatorToNextMsg.toLowerCase()}';
                  }
                  return null;
                },
          onTapFieldCallback: () {
            SelectPositionOccupationDialog.show(
                context: context,
                title: S.current.positionOccupation,
                data: data,
                dataSelected: selected,
                callbackSelect: (position) {
                  _ctrlPositionOccupation.text = position.name!;
                  occupationInfoStepCubit.positionOccupationChanged(position);
                });
          },
          labelText: S.current.positionOccupation,
          isRequired: true,
          hintText: S.current.positionOccupationHint,
        ),
      ],
    );
  }

  Widget _workplaceName(bool isStudent, String? name,
      Map<String, ValidateAttribute>? profileValidAttributes) {
    final label = isStudent ? S.current.nameSchool : S.current.nameOccupation;
    final hintText =
        isStudent ? S.current.nameSchoolHint : S.current.nameOccupationHint;

    return AppTextField(
      controller: _ctrlWorkplaceName,
      initialValue: name,
      errorText: profileValidAttributes?[StepCreateLoanConstants.WorkplaceName]
          ?.errorText,
      maxLen: 50,
      onChanged: (value) =>
          occupationInfoStepCubit.setWorkPlaceValidAttribute(),
      validator: (value) {
        if (AppValidators.isEmptyStringData(value)) {
          return isStudent
              ? '${S.current.validatorEmptyField} '
                  '${label.toLowerCase()} '
                  '${S.current.yourself.toLowerCase()} '
                  '${S.current.validatorToNextMsg.toLowerCase()}'
              : S.current.MSG30;
        }
        return null;
      },
      labelText: label,
      isRequired: true,
      hintText: hintText,
    );
  }

  Widget _monthIncomeWidget(
      BuildContext context, bool isStudent, int? monthlyIncome) {
    return Visibility(
      visible: !isStudent,
      child: AppTextField.money(
        initialValue: monthlyIncome == null
            ? null
            : monthlyIncome.toDefaultFormatNumberString,
        maxLen: 50,
        controller: _ctrlMonthlyIncome,
        validator: isStudent
            ? null
            : (value) {
                if (AppValidators.isEmptyStringData(value)) {
                  return S.current.MSG31;
                }
                return null;
              },
        labelText: S.current.monthlyIncome,
        isRequired: true,
        suffixIcon: Text(
          S.current.money_currency,
          style: Theme.of(context).textTheme.textContentTextField,
        ),
        hintText:
            '${S.current.monthlyIncome} ${S.current.yourself.toLowerCase()}',
      ),
    );
  }

  Widget _addressOccupation(BuildContext context, Addresses addresses,
      AddressSelected? initAddress, bool isStudent) {
    final label =
        isStudent ? S.current.addressSchool : S.current.addressOccupation;
    final validatorText = isStudent
        ? '${S.current.validatorEmptyField} '
            '${label.toLowerCase()} '
            '${S.current.yourself.toLowerCase()} '
            '${S.current.validatorToNextMsg.toLowerCase()}'
        : S.current.MSG39;

    return AppTextFieldSuffixNavigator(
      controller: _ctrlAddressOccupation,
      initialValue: initAddress == null ? null : initAddress.toString(),
      validatorText: validatorText,
      onTapFieldCallback: () async {
        final addressSelected = await Navigator.pushNamed(
            context, SelectAddressRoute.id,
            arguments: {
              SelectAddressRoute.argTitle: S.current.temporaryAddress,
              SelectAddressRoute.argAddresses: addresses,
              SelectAddressRoute.argAddressSelected: initAddress,
            });

        if (addressSelected != null && addressSelected is AddressSelected) {
          _ctrlAddressOccupation.text = addressSelected.toString();
          occupationInfoStepCubit.addressWorkplaceChanged(addressSelected);
        }
      },
      labelText: label,
      isRequired: true,
      hintText: S.current.clickToSelectAddress,
    );
  }

  Widget _phoneOccupation(bool isStudent, String? initText) {
    final label = isStudent ? S.current.phoneSchool : S.current.phoneOccupation;

    return AppTextField.phone(
      controller: _ctrlPhoneOccupation,
      maxLen: 11,
      initialValue: initText,
      labelText: label,
      hintText: '$label ${S.current.yourself.toLowerCase()}',
    );
  }
}
