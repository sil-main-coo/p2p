import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';

class ProfileSessionPref {
  static const keyUserLocal = 'key-user-local';
  static const keyFacebookProfileLocal = 'key-facebook-local';

  static Future saveProfile({required User user}) async {
    var pref = getIt.get<SharedPreferencesManager>();
    await pref.setStringFromMap(keyUserLocal, user.toJson());
  }

  static User? getProfile() {
    var pref = getIt.get<SharedPreferencesManager>();

    final stringJson = pref.getMapFromString(keyUserLocal);
    if (stringJson != null) {
      return User.fromJson(stringJson as Map<String, dynamic>);
    }
    return null;
  }

  /// clear all profile
  static Future<bool> clearProfile() async {
    var pref = getIt.get<SharedPreferencesManager>();
    await pref.remove(keyFacebookProfileLocal);
    return await pref.remove(keyUserLocal);
  }

  static Future saveFacebookProfile(
      {required FacebookInfoResponse info}) async {
    var pref = getIt.get<SharedPreferencesManager>();
    await pref.setStringFromMap(keyFacebookProfileLocal, info.toJson());
  }

  static FacebookInfoResponse? getFacebookProfile() {
    var pref = getIt.get<SharedPreferencesManager>();

    final stringJson = pref.getMapFromString(keyFacebookProfileLocal);
    if (stringJson != null) {
      return FacebookInfoResponse.fromJson(stringJson as Map<String, dynamic>);
    }
    return null;
  }

  static Future<bool> clearFacebookProfile() async {
    var pref = getIt.get<SharedPreferencesManager>();
    return await pref.remove(keyFacebookProfileLocal);
  }
}
