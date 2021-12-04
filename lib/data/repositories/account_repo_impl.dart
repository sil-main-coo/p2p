import 'package:flutter/foundation.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/forgot_pwd_request.dart';
import 'package:p2p_borrower/data/model/request/phone_verify_request.dart';
import 'package:p2p_borrower/data/model/request/reference_phone_request.dart';
import 'package:p2p_borrower/data/model/request/sign_in_request.dart';
import 'package:p2p_borrower/data/model/request/sign_up_request.dart';
import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:p2p_borrower/data/model/response/forgot_pwd_response.dart';
import 'package:p2p_borrower/data/model/response/phone_verify_response.dart';
import 'package:p2p_borrower/data/model/response/reference_phone_response.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/data/model/response/sign_up_response.dart';
import 'package:p2p_borrower/data/sources/local/profile_session_pref.dart';
import 'package:p2p_borrower/data/sources/remote/account_remote_source.dart';
import 'package:p2p_borrower/domain/repositories/account_repository.dart';

import 'package:dio/dio.dart';

class AccountRepoImplement implements AccountRepository {
  final AccountRemoteSource remoteSource;

  AccountRepoImplement({required this.remoteSource});

  @override
  Future<PhoneVerifyResponse?>? checkAccountExist(
      PhoneVerifyRequest request) async {
    try {
      return await remoteSource.checkAccountExist(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<SignUpResponse?>? signUp(SignUpRequest request) async {
    try {
      return await remoteSource.signUp(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<SignInResponse?>? signIn(SignInRequest request) async {
    try {
      return await remoteSource.signIn(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future? signOut() async {
    try {
      return await remoteSource.signOut();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<ForgotPwdResponse?>? forgotPassword(ForgotPwdRequest request) async {
    try {
      return await remoteSource.forgotPassword(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<ReferencePhoneResponse?>? addReferencePhone(
      ReferencePhoneRequest request) async {
    try {
      return await remoteSource.addReferencePhone(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<FacebookInfoResponse?>? loginFacebook(String token) async {
    try {
      final fbInfo = await remoteSource.loginFacebook(token);

      if (fbInfo == null ||
          (fbInfo.isSuccess != null && !(fbInfo.isSuccess!))) {
        return null;
      }

      if (fbInfo.name == null && fbInfo.email == null) {
        return null;
      }

      await ProfileSessionPref.saveFacebookProfile(info: fbInfo);
      return fbInfo;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }
}
