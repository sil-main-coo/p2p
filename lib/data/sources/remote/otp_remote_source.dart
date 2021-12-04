import 'package:p2p_borrower/data/model/request/send_otp_request.dart';
import 'package:p2p_borrower/data/model/request/verify_otp_request.dart';
import 'package:p2p_borrower/data/model/response/otp_send_response.dart';
import 'package:p2p_borrower/data/model/response/otp_verify_response.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'otp_remote_source.g.dart';

@RestApi()
abstract class OTPRemoteSource {
  factory OTPRemoteSource(Dio dio, {String baseUrl}) = _OTPRemoteSource;

  @POST('/OTP/send-otp')
  Future<SendOtpResponse?>? sendOTP(@Body() SendOtpRequest request);

  @POST('/OTP/verify-otp')
  Future<VerifyOtpResponse?>? verifyOTP(@Body() VerifyOTPRequest request);
}
