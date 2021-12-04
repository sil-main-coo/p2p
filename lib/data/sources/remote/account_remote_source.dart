import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'package:p2p_borrower/data/model/request/forgot_pwd_request.dart';
import 'package:p2p_borrower/data/model/request/phone_verify_request.dart';
import 'package:p2p_borrower/data/model/request/reference_phone_request.dart';
import 'package:p2p_borrower/data/model/request/sign_in_request.dart';
import 'package:p2p_borrower/data/model/request/sign_up_request.dart';
import 'package:p2p_borrower/data/model/response/forgot_pwd_response.dart';
import 'package:p2p_borrower/data/model/response/phone_verify_response.dart';
import 'package:p2p_borrower/data/model/response/reference_phone_response.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/data/model/response/sign_up_response.dart';

part 'account_remote_source.g.dart';

@RestApi()
abstract class AccountRemoteSource {
  factory AccountRemoteSource(Dio dio, {String baseUrl}) = _AccountRemoteSource;

  @POST('/borrower/Account/check-phone_number')
  Future<PhoneVerifyResponse?>? checkAccountExist(
      @Body() PhoneVerifyRequest request);

  @POST('/borrower/Account/registing')
  Future<SignUpResponse?>? signUp(@Body() SignUpRequest request);

  @POST('/borrower/Account/signin')
  Future<SignInResponse?>? signIn(@Body() SignInRequest request);

  @POST('/borrower/Account/reset-password')
  Future<ForgotPwdResponse?>? forgotPassword(@Body() ForgotPwdRequest request);

  @GET('/borrower/Account/signout')
  Future<void>? signOut();

  @POST('/borrower/Account/add-referer')
  Future<ReferencePhoneResponse>? addReferencePhone(
      @Body() ReferencePhoneRequest request);

  @POST('/borrower/Account/login-facebook')
  Future<FacebookInfoResponse>? loginFacebook(@Field() String token);
}
