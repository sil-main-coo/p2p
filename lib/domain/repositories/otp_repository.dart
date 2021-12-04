import 'package:p2p_borrower/data/model/request/send_otp_request.dart';
import 'package:p2p_borrower/data/model/request/verify_otp_request.dart';
import 'package:p2p_borrower/data/model/response/otp_send_response.dart';
import 'package:p2p_borrower/data/model/response/otp_verify_response.dart';

abstract class OTPRepository{
  Future<SendOtpResponse?>? sendOTP(SendOtpRequest request);

  Future<VerifyOtpResponse?>? verifyOTP(VerifyOTPRequest request);
}