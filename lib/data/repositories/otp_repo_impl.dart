import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/send_otp_request.dart';
import 'package:p2p_borrower/data/model/request/verify_otp_request.dart';
import 'package:p2p_borrower/data/model/response/otp_send_response.dart';
import 'package:p2p_borrower/data/model/response/otp_verify_response.dart';
import 'package:p2p_borrower/data/sources/remote/otp_remote_source.dart';
import 'package:p2p_borrower/domain/repositories/otp_repository.dart';

class OTPRepoImplement implements OTPRepository {
  final OTPRemoteSource otpRemoteSource;

  const OTPRepoImplement({required this.otpRemoteSource});

  @override
  Future<SendOtpResponse?>? sendOTP(SendOtpRequest request) async {
    try {
      return await otpRemoteSource.sendOTP(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<VerifyOtpResponse?>? verifyOTP(VerifyOTPRequest request) async {
    try {
      return await otpRemoteSource.verifyOTP(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }
}
