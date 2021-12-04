part of 'addition_info_step_cubit.dart';

abstract class AdditionInfoStepState extends Equatable {
  const AdditionInfoStepState();
}

class AdditionInfoStepInitial extends AdditionInfoStepState {
  @override
  List<Object> get props => [];
}

class AdditionInfoStepLoaded extends AdditionInfoStepState {
  final Map<int, List<Uint8List?>> mapPictureValues;
  final Map<int, String?> mapTextValues;
  final bool isValid;
  final List<ValidateAttribute>? additionalValidAttribute;

  bool isCurrent;

  AdditionInfoStepLoaded(
      {required this.mapPictureValues,
      required this.isValid,
      required this.mapTextValues,
      this.additionalValidAttribute,
      this.isCurrent = true});

  AdditionInfoStepLoaded copyWith(
      {List<ValidateAttribute>? additionalValidAttribute,
      bool? isValid,
      Map<int, List<Uint8List?>>? mapPictureValues,
      Map<int, String?>? mapTextValues}) {
    return AdditionInfoStepLoaded(
        isCurrent: !isCurrent,
        isValid: isValid ?? this.isValid,
        additionalValidAttribute:
            additionalValidAttribute ?? this.additionalValidAttribute,
        mapPictureValues: mapPictureValues ?? this.mapPictureValues,
        mapTextValues: mapTextValues ?? this.mapTextValues);
  }

  @override
  List<Object> get props => [
        isCurrent,
        isValid,
        if (additionalValidAttribute != null) additionalValidAttribute!,
        mapPictureValues,
        mapTextValues
      ];
}
