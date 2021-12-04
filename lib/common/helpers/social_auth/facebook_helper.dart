import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookException implements Exception {
  late String message;

  FacebookException({String? message}) {
    if (message != null)
      this.message = message;
    else
      this.message = SConfig.current.unKnowError;
  }
}

abstract class FacebookHelper {
  Future<LoginResult> login();

  Future<void> logOut();
}

class FacebookHelperImpl implements FacebookHelper {
  final _fbAuth = FacebookAuth.instance;

  @override
  Future<void> logOut() async {
    try {
      await _fbAuth.logOut();
    } catch (e) {
      throw FacebookException(message: 'Logout Facebook failed');
    }
  }

  @override
  Future<LoginResult> login() async {
    try {
      return await _fbAuth.login();
    } catch (e) {
      throw FacebookException(message: 'Login Facebook failed');
    }
  }
}
