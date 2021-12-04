part of 'input_phone_cubit.dart';

abstract class InputPhoneState extends Equatable {
  final bool isOTPLock;
  final DateTime? lockExpired;
  final String? phone;

  const InputPhoneState({this.phone, this.isOTPLock = false, this.lockExpired});
}

class InputPhoneInitial extends InputPhoneState {
  @override
  List<Object> get props => [];
}

class InputPhoneLoading extends InputPhoneState {
  @override
  List<Object> get props => [];
}

class InputPhoneIsExist extends InputPhoneState {
  final PhoneVerifyResponse phoneVerifyResponse;

  const InputPhoneIsExist(
      {required this.phoneVerifyResponse,
      bool isOTPLock = false,
      required String phone,
      DateTime? lockExpired})
      : super(isOTPLock: isOTPLock, lockExpired: lockExpired, phone: phone);

  @override
  List<Object> get props => [phoneVerifyResponse, isOTPLock];
}

class InputPhoneNotExist extends InputPhoneState {
  final String phone;

  const InputPhoneNotExist(
      {required this.phone, bool isOTPLock = false, DateTime? lockExpired})
      : super(isOTPLock: isOTPLock, lockExpired: lockExpired);

  @override
  List<Object> get props => [phone, isOTPLock];
}

class InputPhoneFailure extends InputPhoneState {
  final String msg;

  const InputPhoneFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
