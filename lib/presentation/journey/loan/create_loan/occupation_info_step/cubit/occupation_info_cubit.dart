import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/model/occupation_info_response.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';

import '../../step_create_loan_constants.dart';

part 'occupation_info_state.dart';

class OccupationInfoStepCubit extends Cubit<OccupationInfoStepState> {
  OccupationInfoStepCubit() : super(OccupationInfoStepInitial());

  late OccupationInfoStepResponse occupationDataResponse;

  late CreateLoanCubit _createLoanCubit;

  void initData(
      {required CreateLoanCubit createLoanCubit,
      required OccupationInfoStepResponse occupationDataResponse}) {
    _createLoanCubit = createLoanCubit;
    this.occupationDataResponse = occupationDataResponse;

    emit(OccupationInfoStepLoaded(
        occupationDataResponse: this.occupationDataResponse));
  }

  // set create loan request model value in create loan cubit
  Future saveData(bool isStudent) =>
      _createLoanCubit.setOccupationData(occupationDataResponse, isStudent);

  void simpleDataChanged(
      {required String workplaceName,
      String? monthlyIncome,
      String? workplacePhone}) {
    this.occupationDataResponse.workplaceName = workplaceName;
    this.occupationDataResponse.workplacePhone = workplacePhone;
    if (monthlyIncome != null && monthlyIncome.isNotEmpty) {
      this.occupationDataResponse.monthlyIncome =
          int.parse(monthlyIncome.toAllDigit);
    }
  }

  void occupationChanged(OccupationResponse data) {
    if (state is OccupationInfoStepLoaded) {
      this.occupationDataResponse.occupation = data;
      occupationDataResponse
          .profileValidAttribute?[StepCreateLoanConstants.OccupationName]
          ?.setValidValue();
      emit((state as OccupationInfoStepLoaded)
          .copyWith(occupationDataResponse: this.occupationDataResponse));
    }
  }

  void positionOccupationChanged(OccupationPositionResponse data) {
    if (state is OccupationInfoStepLoaded) {
      this.occupationDataResponse.occupationPosition = data;
      occupationDataResponse.profileValidAttribute?[
              StepCreateLoanConstants.OccupationPositionName]
          ?.setValidValue();
      emit((state as OccupationInfoStepLoaded)
          .copyWith(occupationDataResponse: this.occupationDataResponse));
    }
  }

  void setWorkPlaceValidAttribute() {
    if (occupationDataResponse
            .profileValidAttribute?[StepCreateLoanConstants.WorkplaceName]
            ?.errorText !=
        null) {
      occupationDataResponse
          .profileValidAttribute?[StepCreateLoanConstants.WorkplaceName]
          ?.setValidValue();
      emit((state as OccupationInfoStepLoaded)
          .copyWith(occupationDataResponse: this.occupationDataResponse));
    }
  }

  void addressWorkplaceChanged(AddressSelected data) {
    if (state is OccupationInfoStepLoaded) {
      this.occupationDataResponse.occupationAddress = data;
      emit((state as OccupationInfoStepLoaded)
          .copyWith(occupationDataResponse: this.occupationDataResponse));
    }
  }
}
