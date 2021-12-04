part of 'reference_phone_cubit.dart';

abstract class ReferencePhoneState extends Equatable {
  const ReferencePhoneState();
}

class ReferencePhoneInitial extends ReferencePhoneState {
  @override
  List<Object> get props => [];
}

class ReferencePhoneLoading extends ReferencePhoneState {
  @override
  List<Object?> get props => [];
}

class ReferencePhoneFailure extends ReferencePhoneState {
  final String msg;

  const ReferencePhoneFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class ReferencePhoneSuccess extends ReferencePhoneState {
  final ReferencePhoneResponse response;

  const ReferencePhoneSuccess({required this.response});

  @override
  List<Object?> get props => [ReferencePhoneResponse];
}
