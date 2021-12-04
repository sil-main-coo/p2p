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

abstract class AccountRepository {
  Future<PhoneVerifyResponse?>? checkAccountExist(PhoneVerifyRequest request);

  Future<SignUpResponse?>? signUp(SignUpRequest request);

  Future<SignInResponse?>? signIn(SignInRequest request);

  Future<ForgotPwdResponse?>? forgotPassword(ForgotPwdRequest request);

  Future? signOut();

  Future<ReferencePhoneResponse?>? addReferencePhone(
      ReferencePhoneRequest request);

  Future<FacebookInfoResponse?>? loginFacebook(String token);
}
