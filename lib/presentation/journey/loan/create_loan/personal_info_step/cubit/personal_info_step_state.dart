part of 'personal_info_step_cubit.dart';

abstract class PersonalInfoStepState extends Equatable {
  const PersonalInfoStepState();
}

class PersonalInfoStepInitial extends PersonalInfoStepState {
  @override
  List<Object> get props => [];
}

class PersonalInfoStepLoaded extends PersonalInfoStepState {
  final PersonalInfoStepModel infoDataResponse;
  bool isCurrent;

  PersonalInfoStepLoaded({
    required this.infoDataResponse,
    this.isCurrent = true,
  });

  PersonalInfoStepLoaded copyWith({PersonalInfoStepModel? infoDataResponse}) {
    return PersonalInfoStepLoaded(
        isCurrent: !isCurrent,
        infoDataResponse: infoDataResponse ?? this.infoDataResponse);
  }

  @override
  List<Object> get props => [
        infoDataResponse,
        isCurrent,
      ];
}
