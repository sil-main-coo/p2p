part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpFailure extends SignUpState {
  final String msg;

  const SignUpFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SignUpSuccess extends SignUpState {
  final String phone;
  final String password;

  const SignUpSuccess({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}
