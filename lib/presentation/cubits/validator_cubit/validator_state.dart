part of 'validator_cubit.dart';

@immutable
abstract class ValidatorState extends Equatable {
  final bool isValid;
  final String? value;
  final List<String?>? errors;

  const ValidatorState({this.isValid = false, this.value, this.errors});

  @override
  List<Object> get props => [
        this.isValid,
        if (this.value != null) this.value!,
        if (this.errors != null) this.errors!
      ];
}

class ValidatorCurrentState extends ValidatorState {
  const ValidatorCurrentState.init()
      : super(
          isValid: false,
        );

  const ValidatorCurrentState.success({
    String? value,
    List<String?>? errors,
  }) : super(isValid: true, value: value, errors: errors);

  const ValidatorCurrentState.failure(
      {String? value, List<String?>? errors, int? offset})
      : super(isValid: false, value: value, errors: errors);
}
