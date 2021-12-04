part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String msg;

  const ForgotPasswordFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String phone;
  final String password;

  const ForgotPasswordSuccess({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}
