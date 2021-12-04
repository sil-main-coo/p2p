import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:p2p_borrower/common/hive/hive.dart';
import 'package:p2p_borrower/data/model/request/forgot_pwd_request.dart';
import 'package:p2p_borrower/data/model/request/phone_verify_request.dart';
import 'package:p2p_borrower/data/model/request/reference_phone_request.dart';
import 'package:p2p_borrower/data/model/request/send_otp_request.dart';
import 'package:p2p_borrower/data/model/request/sign_in_request.dart';
import 'package:p2p_borrower/data/model/request/sign_up_request.dart';
import 'package:p2p_borrower/data/model/request/verify_otp_request.dart';
import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:p2p_borrower/data/model/response/forgot_pwd_response.dart';
import 'package:p2p_borrower/data/model/response/otp_send_response.dart';
import 'package:p2p_borrower/data/model/response/otp_verify_response.dart';
import 'package:p2p_borrower/data/model/response/phone_verify_response.dart';
import 'package:p2p_borrower/data/model/response/reference_phone_response.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/data/model/response/sign_up_response.dart';
import 'package:p2p_borrower/data/sources/local/profile_session_pref.dart';
import 'package:p2p_borrower/data/sources/local/settings_session_prefer.dart';
import 'package:p2p_borrower/domain/repositories/account_repository.dart';
import 'package:p2p_borrower/domain/repositories/device_repository.dart';
import 'package:p2p_borrower/domain/repositories/otp_repository.dart';

class AuthenticationUseCase {
  final DeviceRepository deviceRepository;
  final AccountRepository accountRepository;
  final OTPRepository otpRepository;

  AuthenticationUseCase(
      {required this.otpRepository,
      required this.deviceRepository,
      required this.accountRepository});

  Future<PhoneVerifyResponse?>? checkPhoneExist({required String phone}) async {
    final device = await deviceRepository.getDeviceDetails();

    return await accountRepository.checkAccountExist(PhoneVerifyRequest.signIn(
        phone: phone,
        deviceId: device.deviceId,
        deviceName: device.deviceName));
  }

  Future<SendOtpResponse?>? sendOTP(
      {required String phone, required String verificationType}) async {
    final device = await deviceRepository.getDeviceDetails();

    return await otpRepository.sendOTP(SendOtpRequest(
        phone: phone,
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        verificationType: verificationType));
  }

  Future<VerifyOtpResponse?>? verifyOTP(
      {required String phone,
      required String otp,
      required String verificationType}) async {
    final device = await deviceRepository.getDeviceDetails();

    return await otpRepository.verifyOTP(VerifyOTPRequest(
        phone: phone,
        deviceId: device.deviceId,
        value: otp,
        verificationType: verificationType));
  }

  Future<SignUpResponse?>? signUp(
      {required String phone,
      required String password,
      required String verifiedCode}) async {
    final device = await deviceRepository.getDeviceDetails();
    return await accountRepository.signUp(SignUpRequest(
        phone: phone,
        deviceId: device.deviceId,
        password: password,
        verifiedCode: verifiedCode));
  }

  Future<SignInResponse?>? signIn(
      {required String phone, required String password}) async {
    final device = await deviceRepository.getDeviceDetails();
    return await accountRepository.signIn(SignInRequest(
      password: password,
      phone: phone,
      deviceName: device.deviceName,
      deviceId: device.deviceId,
      fcmToken: "fcm_token",
    ));
  }

  Future<ForgotPwdResponse?>? forgotPassword(
      {required String phone,
      required String newPassword,
      required String verifiedCode}) async {
    final device = await deviceRepository.getDeviceDetails();
    return await accountRepository.forgotPassword(ForgotPwdRequest(
        phone: phone,
        deviceId: device.deviceId,
        verifiedCode: verifiedCode,
        newPassword: newPassword));
  }

  Future signedIn(
      {required String accessToken,
      required String refreshToken,
      required String userName,
      required User user,
      bool autoPush = true}) async {
    /// save session user data
    SessionPref.saveSession(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userName: userName);
    ProfileSessionPref.saveProfile(user: user);

    /// open user hive box
    await HiveSetup.openUserBoxes();
  }

  Future signOut() async {
    try {
      await accountRepository.signOut();
      await SessionPref.clearSessionData(); // clear session data on local
      await SettingsSessionPref.clearSessionSetting(); // clear session settings
      await ProfileSessionPref.clearProfile(); // clear user session data
    } catch (e) {
      throw e;
    }
  }

  Future<ReferencePhoneResponse?>? addReferencePhone(
          ReferencePhoneRequest request) async =>
      await accountRepository.addReferencePhone(request);

  Future<FacebookInfoResponse?>? loginFacebook(String token) async =>
      accountRepository.loginFacebook(token);
}
