part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class VerifyOtpLoading extends OtpState {}

class OtpSendFailure extends OtpState {
  final String msg;
  final String? phone;
  final int countResend;
  final bool isLocked;
  final bool isSignedIn;

  OtpSendFailure(
      {required this.msg,
      required this.countResend,
      this.phone,
      this.isLocked = false,
      this.isSignedIn = false});

  @override
  List<Object> get props => [
        this.msg,
        this.countResend,
        this.isLocked,
        this.isSignedIn,
        if (this.phone != null) this.phone!
      ];
}

class OtpIsSent extends OtpState {
  final String phone;
  final String? otp;

  OtpIsSent({required this.phone, this.otp});

  @override
  List<Object> get props => [this.phone];
}

class OtpIsReSent extends OtpState {
  final String phone;
  final int countResend;
  final String? otp;

  OtpIsReSent({required this.phone, required this.countResend, this.otp});

  @override
  List<Object> get props =>
      [this.phone, this.countResend, if (this.otp != null) this.otp!];
}

class VerifyOTPFailed extends OtpState {
  final String msg;
  final int timeTryAgain;
  final bool isSignedIn;
  final String? phone;
  final bool isLocked;

  VerifyOTPFailed(
      {required this.msg,
      required this.timeTryAgain,
      this.isSignedIn = false,
      this.isLocked = false,
      this.phone});

  @override
  List<Object> get props => [
        this.msg,
        this.timeTryAgain,
        this.isSignedIn,
        this.isLocked,
        if (phone != null) this.phone!
      ];
}

class VerifyOTPSuccess extends OtpState {
  final String phone;
  final String verifyCode;

  VerifyOTPSuccess({required this.phone, required this.verifyCode});

  @override
  List<Object> get props => [this.phone, this.verifyCode];
}
