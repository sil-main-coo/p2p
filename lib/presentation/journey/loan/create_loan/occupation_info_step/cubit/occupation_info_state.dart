part of 'occupation_info_cubit.dart';

abstract class OccupationInfoStepState extends Equatable {
  const OccupationInfoStepState();
}

class OccupationInfoStepInitial extends OccupationInfoStepState {
  @override
  List<Object> get props => [];
}

class OccupationInfoStepLoaded extends OccupationInfoStepState {
  final OccupationInfoStepResponse occupationDataResponse;
  bool isCurrent;

  OccupationInfoStepLoaded(
      {required this.occupationDataResponse, this.isCurrent = true});

  OccupationInfoStepLoaded copyWith({OccupationInfoStepResponse? occupationDataResponse}) {
    return OccupationInfoStepLoaded(
        isCurrent: !isCurrent,
        occupationDataResponse: occupationDataResponse ?? this.occupationDataResponse);
  }

  @override
  List<Object> get props => [occupationDataResponse, isCurrent];
}
