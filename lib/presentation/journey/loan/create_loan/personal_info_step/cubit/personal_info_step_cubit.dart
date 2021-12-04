import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';
import 'package:intl/intl.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';

import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/model/personal_info_step_response.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';

import '../../step_create_loan_constants.dart';

part 'personal_info_step_state.dart';

class PersonalInfoStepCubit extends Cubit<PersonalInfoStepState> {
  PersonalInfoStepCubit() : super(PersonalInfoStepInitial());

  late PersonalInfoStepModel infoDataResponse;

  late CreateLoanCubit _createLoanCubit;

  void initData(
      {required CreateLoanCubit createLoanCubit,
      required PersonalInfoStepModel infoDataResponse}) {
    _createLoanCubit = createLoanCubit;
    this.infoDataResponse = infoDataResponse;

    emit(PersonalInfoStepLoaded(infoDataResponse: this.infoDataResponse));
  }

  Future saveData() => _createLoanCubit.setPersonalInfoData(infoDataResponse);

  void simpleProfileDataChanged(String fullName, String idNumber, String idBy,
      String phone1, String phone2) {
    this.infoDataResponse.profile!.fullName = fullName;
    this.infoDataResponse.profile!.idCardNumber = idNumber;
    this.infoDataResponse.profile!.idCardIssuedBy = idBy;
    this.infoDataResponse.relativePerson1!.phone = phone1;
    this.infoDataResponse.relativePerson2!.phone = phone2;
  }

  void setFullNameValidAttribute() {
    if (infoDataResponse
            .profileValidAttribute?[StepCreateLoanConstants.FullName]
            ?.errorText !=
        null) {
      infoDataResponse.profileValidAttribute?[StepCreateLoanConstants.FullName]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void sexChanged(String data) {
    this.infoDataResponse.profile!.gender = data;
    infoDataResponse.profileValidAttribute?[StepCreateLoanConstants.GenderName]
        ?.setValidValue();
    emit((state as PersonalInfoStepLoaded)
        .copyWith(infoDataResponse: this.infoDataResponse));
  }

  void birthdayDateChanged(DateTime data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.profile!.dateOfBirth =
          DateFormat(DateTimeFormatConstants.iso8601WithMillisecondsOnly)
              .format(data);
      infoDataResponse
          .profileValidAttribute?[StepCreateLoanConstants.DateOfBirthName]
          ?.setValidValue();

      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void idCardDateChanged(DateTime data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.profile!.idCardIssuedDate =
          DateFormat(DateTimeFormatConstants.iso8601WithMillisecondsOnly)
              .format(data);
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void relativePerson1Changed(RelativePersonRequest data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.relativePerson1 = data;
      infoDataResponse
          .relativeValidAttribute?[StepCreateLoanConstants.RelativePerson1Name]
          ?.setValidValue();

      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void setPhoneRelativePerson1ValidAttribute() {
    if (infoDataResponse
            .relativeValidAttribute?[
                StepCreateLoanConstants.RelativePerson1PhoneName]
            ?.errorText !=
        null) {
      infoDataResponse.relativeValidAttribute?[
              StepCreateLoanConstants.RelativePerson1PhoneName]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void setPhoneRelativePerson2ValidAttribute() {
    if (infoDataResponse
            .relativeValidAttribute?[
                StepCreateLoanConstants.RelativePerson2PhoneName]
            ?.errorText !=
        null) {
      infoDataResponse.relativeValidAttribute?[
              StepCreateLoanConstants.RelativePerson2PhoneName]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void relativePerson2Changed(RelativePersonRequest data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.relativePerson2 = data;
      infoDataResponse
          .relativeValidAttribute?[StepCreateLoanConstants.RelativePerson2Name]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void residentAddressChanged(AddressSelected data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.residentAddress = data;
      infoDataResponse
          .addressValidAttribute?[StepCreateLoanConstants.ResidentAddressIdName]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void currentAddressChanged(AddressSelected data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.currentAddress = data;
      infoDataResponse
          .addressValidAttribute?[StepCreateLoanConstants.CurrentAddressIdName]
          ?.setValidValue();
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void ownerShipTypeChanged(OwnerShipTypeResponse data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.ownerShipType = data;
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }

  void maritalStatusChanged(MaritalStatusResponse data) {
    if (state is PersonalInfoStepLoaded) {
      this.infoDataResponse.maritalStatus = data;
      emit((state as PersonalInfoStepLoaded)
          .copyWith(infoDataResponse: this.infoDataResponse));
    }
  }
}
