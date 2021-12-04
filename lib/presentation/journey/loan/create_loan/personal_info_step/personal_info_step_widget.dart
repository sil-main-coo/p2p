part of '../create_loan_loaded_widget.dart';

class PersonalInfoWidget extends StatefulWidget {
  PersonalInfoWidget({Key? key, required this.stepName}) : super(key: key);

  final String stepName;

  @override
  _PersonalInfoStepState createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoWidget>
    with AutomaticKeepAliveClientMixin {
  late PersonalInfoStepCubit personalInfoStepCubit;

  final _ctrlFullName = TextEditingController();
  final _ctrlBirthday = TextEditingController();
  final _ctrlIssueDate = TextEditingController();
  final _ctrlIDCardNumber = TextEditingController();
  final _ctrlIDCardIssueBy = TextEditingController();
  final _ctrlPermanentAddress = TextEditingController();
  final _ctrlTemporaryAddress = TextEditingController();
  final _ctrlOwnerShipType = TextEditingController();
  final _ctrlMaritalStatus = TextEditingController();
  final _ctrlRelativePersonPicker1 = TextEditingController();
  final _ctrlRelativePersonPicker2 = TextEditingController();
  final _ctrlRelativePersonPhone1 = TextEditingController();
  final _ctrlRelativePersonPhone2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _nextStep(BuildContext context) {
    if (_isValidate()) {
      personalInfoStepCubit.simpleProfileDataChanged(
          _ctrlFullName.text.trim(),
          _ctrlIDCardNumber.text.trim(),
          _ctrlIDCardIssueBy.text.trim(),
          _ctrlRelativePersonPhone1.text.trim(),
          _ctrlRelativePersonPhone2.text.trim());
      personalInfoStepCubit.saveData();
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
  void dispose() {
    super.dispose();
    _ctrlFullName.dispose();
    _ctrlBirthday.dispose();
    _ctrlIssueDate.dispose();
    _ctrlIDCardNumber.dispose();
    _ctrlIDCardIssueBy.dispose();
    _ctrlPermanentAddress.dispose();
    _ctrlTemporaryAddress.dispose();
    _ctrlOwnerShipType.dispose();
    _ctrlMaritalStatus.dispose();
    _ctrlRelativePersonPicker1.dispose();
    _ctrlRelativePersonPicker2.dispose();
    _ctrlRelativePersonPhone1.dispose();
    _ctrlRelativePersonPhone2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    personalInfoStepCubit = BlocProvider.of<PersonalInfoStepCubit>(context);

    return StepCreateLoanLayout(
      title: S.current.createLoanTitle,
      subTitle: '${widget.stepName}: ${S.current.personalInfo}',
      backStep: () => _backStep(context),
      nextStep: () => _nextStep(context),
      body: BlocBuilder<PersonalInfoStepCubit, PersonalInfoStepState>(
        builder: (context, state) {
          if (state is PersonalInfoStepLoaded) {
            return _step2Form(context, state.infoDataResponse);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _step2Form(BuildContext context, PersonalInfoStepModel response) {
    final createLoanState =
        BlocProvider.of<CreateLoanCubit>(context).state as CreateLoanLoaded;
    final masterDataResponse = createLoanState.loanMasterDataResponse;
    final spaceWidget = VerticalSpace(
      height: 24,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FullNameFieldWidget(
                controller: _ctrlFullName,
                initialValue: response.profile?.fullName,
                errorText: response
                    .profileValidAttribute?[StepCreateLoanConstants.FullName]
                    ?.errorText,
                onChanged: (_) =>
                    personalInfoStepCubit.setFullNameValidAttribute(),
              ),
              spaceWidget,
              SexSelectionWidget(
                key: ValueKey(response.profile?.gender),
                initValue: response.profile?.gender,
                errorText: response
                    .profileValidAttribute?[StepCreateLoanConstants.GenderName]
                    ?.errorText,
                onChanged: (value) => personalInfoStepCubit.sexChanged(value),
              ),
              spaceWidget,
              BirthdayPickerWidget(
                controller: _ctrlBirthday,
                errorText: response
                    .profileValidAttribute?[
                        StepCreateLoanConstants.DateOfBirthName]
                    ?.errorText,
                initialDateTime: response.profile?.dateOfBirthDateTime,
                onPressedDone: (value) =>
                    personalInfoStepCubit.birthdayDateChanged(value),
              ),
              spaceWidget,
              IDCardNumberWidget(
                controller: _ctrlIDCardNumber,
                initialValue: response.profile?.idCardNumber,
                errorText: response
                    .profileValidAttribute?[
                        StepCreateLoanConstants.IdCardNumberName]
                    ?.errorText,
              ),
              spaceWidget,
              IDCardDatePickerWidget(
                controller: _ctrlIssueDate,
                initialDateTime: response.profile?.idCardIssuedDateTime,
                onPressedDone: (value) {
                  personalInfoStepCubit.idCardDateChanged(value);
                },
              ),
              spaceWidget,
              IDCardByWidget(
                controller: _ctrlIDCardIssueBy,
                initialValue: response.profile?.idCardIssuedBy,
              ),
              spaceWidget,
              _relativePersonsPhoneWidget(
                  response, masterDataResponse.relativePersonTypes!),
              spaceWidget,
              _permanentAddressWidget(masterDataResponse.addresses!,
                  response.residentAddress, response.addressValidAttribute),
              spaceWidget,
              _temporaryAddressWidget(masterDataResponse.addresses!,
                  response.currentAddress, response.addressValidAttribute),
              spaceWidget,
              OwnerShipTypeWidget(
                controller: _ctrlOwnerShipType,
                onPressedDone: (value) {
                  personalInfoStepCubit.ownerShipTypeChanged(value);
                },
                list: masterDataResponse.ownerShipTypes!,
                selected: response.ownerShipType,
              ),
              spaceWidget,
              MaritalStatusWidget(
                controller: _ctrlMaritalStatus,
                maritalStatuses: masterDataResponse.maritalStatuses!,
                selected: response.maritalStatus,
                onPressedDone: (value) {
                  personalInfoStepCubit.maritalStatusChanged(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _relativePersonsPhoneWidget(PersonalInfoStepModel infoDataResponse,
      List<RelativePersonRequest> relativePersonTypes) {
    return Column(
      children: [
        RelativePersonWidget(
            indexLabel: 1,
            onFieldChanged: (value) {
              personalInfoStepCubit.setPhoneRelativePerson1ValidAttribute();
            },
            errorTextPicker: infoDataResponse
                .relativeValidAttribute?[
                    StepCreateLoanConstants.RelativePerson1Name]
                ?.errorText,
            errorTextField: infoDataResponse
                .relativeValidAttribute?[
                    StepCreateLoanConstants.RelativePerson1PhoneName]
                ?.errorText,
            label: S.current.phoneOfRelative,
            ctrlRelativePersonPhone: _ctrlRelativePersonPhone1,
            ctrlRelativePersonPicker: _ctrlRelativePersonPicker1,
            relativePersonTypes: relativePersonTypes,
            relativeSelected: infoDataResponse.relativePerson1,
            onPressedDone: (value) {
              personalInfoStepCubit.relativePerson1Changed(value);
            }),
        RelativePersonWidget(
            indexLabel: 2,
            onFieldChanged: (value) {
              personalInfoStepCubit.setPhoneRelativePerson2ValidAttribute();
            },
            errorTextPicker: infoDataResponse
                .relativeValidAttribute?[
                    StepCreateLoanConstants.RelativePerson2Name]
                ?.errorText,
            errorTextField: infoDataResponse
                .relativeValidAttribute?[
                    StepCreateLoanConstants.RelativePerson2PhoneName]
                ?.errorText,
            ctrlRelativePersonPhone: _ctrlRelativePersonPhone2,
            ctrlRelativePersonPicker: _ctrlRelativePersonPicker2,
            relativePersonTypes: relativePersonTypes,
            relativeSelected: infoDataResponse.relativePerson2,
            onPressedDone: (value) {
              personalInfoStepCubit.relativePerson2Changed(value);
            }),
      ],
    );
  }

  Widget _permanentAddressWidget(
      Addresses addresses,
      AddressSelected? residentAddress,
      Map<String, ValidateAttribute>? addressValidAttribute) {
    return AppTextFieldSuffixNavigator(
      controller: _ctrlPermanentAddress,
      initialValue: residentAddress == null ? null : residentAddress.toString(),
      validatorText: S.current.MSG37,
      errorText:
          addressValidAttribute?[StepCreateLoanConstants.ResidentAddressIdName]
              ?.errorText,
      onTapFieldCallback: () async {
        final addressSelected = await Navigator.pushNamed(
            context, SelectAddressRoute.id,
            arguments: {
              SelectAddressRoute.argTitle: S.current.permanentAddress,
              SelectAddressRoute.argAddresses: addresses,
              SelectAddressRoute.argAddressSelected: residentAddress,
            });

        if (addressSelected != null && addressSelected is AddressSelected) {
          _ctrlPermanentAddress.text = addressSelected.toString();
          personalInfoStepCubit.residentAddressChanged(addressSelected);
        }
      },
      labelText: S.current.permanentAddress,
      isRequired: true,
      hintText: S.current.clickToSelectAddress,
    );
  }

  Widget _temporaryAddressWidget(
      Addresses addresses,
      AddressSelected? temporaryAddress,
      Map<String, ValidateAttribute>? addressValidAttribute) {
    return Column(
      children: [
        AppTextFieldSuffixNavigator(
          controller: _ctrlTemporaryAddress,
          initialValue:
              temporaryAddress == null ? null : temporaryAddress.toString(),
          validatorText: S.current.MSG38,
          errorText: addressValidAttribute?[
                  StepCreateLoanConstants.CurrentAddressIdName]
              ?.errorText,
          onTapFieldCallback: () async {
            final addressSelected = await Navigator.pushNamed(
                context, SelectAddressRoute.id,
                arguments: {
                  SelectAddressRoute.argTitle: S.current.temporaryAddress,
                  SelectAddressRoute.argAddresses: addresses,
                  SelectAddressRoute.argAddressSelected: temporaryAddress,
                });

            if (addressSelected != null && addressSelected is AddressSelected) {
              _ctrlTemporaryAddress.text = addressSelected.toString();
              personalInfoStepCubit.currentAddressChanged(addressSelected);
            }
          },
          labelText: S.current.temporaryAddress,
          isRequired: true,
          hintText: S.current.clickToSelectAddress,
        ),
        VerticalSpace(
          height: 12,
        ),
        Text(
          S.current.contactInfoNote,
          style: Theme.of(context).textTheme.textSub,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
