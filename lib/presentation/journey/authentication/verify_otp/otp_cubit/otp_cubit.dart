import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/otp_send_response.dart';
import 'package:p2p_borrower/data/model/response/otp_verify_response.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_constants.dart';
import 'package:p2p_borrower/presentation/cubits/timer_cubit/timer_cubit.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.timerCubit, required this.authenticationUseCase})
      : super(OtpInitial());

  final TimerCubit timerCubit;
  final AuthenticationUseCase authenticationUseCase;

  String _phone = '';
  String _verificationType = '';
  int _countSendOTP = OTPConstants.MAX_RESEND;

  SendOtpResponse? _sendOtpResponse;
  VerifyOtpResponse? _verifyOtpResponse;

  SendOtpResponse get sendOtpResponse => _sendOtpResponse!;

  VerifyOtpResponse get verifyOtpResponse => _verifyOtpResponse!;

  String get getPhone => _phone;

  String get getVerificationType => _verificationType;

  int get getCountVerifyOTP => _verifyOtpResponse != null
      ? _verifyOtpResponse!.retryTimes ?? OTPConstants.MIN_COUNT
      : OTPConstants.MIN_COUNT;

  int get getCountSendOTP => _countSendOTP;

  Future sendOtp(
      {required String phone, required String verificationType}) async {
    emit(OtpLoading());

    _phone = phone;
    _verificationType = verificationType;

    try {
      timerCubit.startTimer();
      _sendOtpResponse = (await authenticationUseCase.sendOTP(
          phone: phone, verificationType: _verificationType))!;

      if (_sendOtpResponse!.isSuccess!) {
        _countSendOTP--;
        emit(OtpIsSent(phone: _phone, otp: _sendOtpResponse!.otp));
        return;
      }

      final isSignedIn = SessionPref.getUserName() != null;
      final now = DateTime.now();

      if (_sendOtpResponse!.isLock! &&
          _sendOtpResponse!.lockExpired!.compareTo(now) >= 0) {
        // phone was blocked
        emit(OtpSendFailure(
            msg: _sendOtpResponse!.message ?? SConfig.current.unKnowError,
            countResend: _countSendOTP,
            phone: _phone,
            isSignedIn: isSignedIn,
            isLocked: true));
        return;
      }

      emit(OtpSendFailure(
          msg: _sendOtpResponse!.message ?? SConfig.current.unKnowError,
          isSignedIn: isSignedIn,
          phone: _phone,
          countResend: _countSendOTP));
    } on ApiException catch (apiError) {
      emit(OtpSendFailure(
          msg: apiError.errorMessage, countResend: _countSendOTP));
    } on LocalException catch (localError) {
      emit(OtpSendFailure(
          msg: localError.message ?? SConfig.current.deviceError,
          countResend: _countSendOTP));
    } catch (e) {
      emit(OtpSendFailure(
          msg: SConfig.current.unKnowError, countResend: _countSendOTP));
    }
  }

  Future resendOtp() async {
    emit(OtpLoading());

    timerCubit.timerReset();

    try {
      _sendOtpResponse = (await authenticationUseCase.sendOTP(
          phone: _phone, verificationType: _verificationType))!;
      if (_sendOtpResponse!.isSuccess!) {
        _countSendOTP--;
        emit(OtpIsReSent(
            phone: _phone,
            countResend: _countSendOTP,
            otp: _sendOtpResponse!.otp));
        return;
      }

      final isSignedIn = SessionPref.getUserName() != null;
      final now = DateTime.now();

      if (_sendOtpResponse!.isLock! &&
          _sendOtpResponse!.lockExpired!.compareTo(now) >= 0) {
        // phone was blocked
        emit(OtpSendFailure(
            msg: _sendOtpResponse!.message ?? SConfig.current.unKnowError,
            countResend: _countSendOTP,
            phone: _phone,
            isSignedIn: isSignedIn,
            isLocked: true));
        return;
      }

      emit(OtpSendFailure(
          msg: _sendOtpResponse!.message ?? SConfig.current.unKnowError,
          phone: _phone,
          countResend: _countSendOTP));
    } on ApiException catch (apiError) {
      emit(OtpSendFailure(
          msg: apiError.errorMessage, countResend: _countSendOTP));
    } on LocalException catch (localError) {
      emit(OtpSendFailure(
          msg: localError.message ?? SConfig.current.deviceError,
          countResend: _countSendOTP));
    } catch (e) {
      emit(OtpSendFailure(
          msg: SConfig.current.unKnowError, countResend: _countSendOTP));
    }
  }

  // Verify OTP method
  Future verifyOtp(String otp) async {
    emit(VerifyOtpLoading());

    try {
      _verifyOtpResponse = (await authenticationUseCase.verifyOTP(
          phone: _phone, otp: otp, verificationType: _verificationType))!;

      if (_verifyOtpResponse!.isSuccess!) {
        emit(VerifyOTPSuccess(
            phone: _phone, verifyCode: _verifyOtpResponse!.verifiedCode!));
        return;
      }

      final isSignedIn = SessionPref.getUserName() != null;
      final now = DateTime.now();

      if (_verifyOtpResponse!.retryTimes! >= OTPConstants.MAX_TRY_AGAIN &&
          _verifyOtpResponse!.lockExpired!.compareTo(now) >= 0) {
        emit(VerifyOTPFailed(
            msg: S.current.MSG06,
            timeTryAgain: getCountVerifyOTP,
            isLocked: true,
            phone: _phone,
            isSignedIn: isSignedIn));
        return;
      }

      emit(VerifyOTPFailed(
          msg: _verifyOtpResponse!.message!.isEmpty
              ? S.current.MSG05
              : _verifyOtpResponse!.message!,
          timeTryAgain: getCountVerifyOTP,
          phone: _phone,
          isSignedIn: isSignedIn));
    } on ApiException catch (apiError) {
      emit(VerifyOTPFailed(
          msg: apiError.errorMessage, timeTryAgain: getCountVerifyOTP));
    } on LocalException catch (localError) {
      emit(VerifyOTPFailed(
          msg: localError.message ?? SConfig.current.deviceError,
          timeTryAgain: getCountVerifyOTP));
    } catch (e) {
      emit(VerifyOTPFailed(
          msg: SConfig.current.unKnowError, timeTryAgain: getCountVerifyOTP));
    }
  }
}
