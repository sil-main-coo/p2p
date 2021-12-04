import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/data/model/response/multi_signin_message_response.dart';

class SettingsSessionPref {
  static const keyMultiSignInMessage = 'key_multi_sign_in_msg';

  static void saveMultiSignInMessage(
      {required MultiSignInMessageResponse message}) {
    var preferencesManager = getIt.get<SharedPreferencesManager>();
    preferencesManager.setStringFromMap(
        keyMultiSignInMessage, message.toJson());
  }

  static MultiSignInMessageResponse? getMultiSignInMessage() {
    final stringJson = getIt
        .get<SharedPreferencesManager>()
        .getMapFromString(keyMultiSignInMessage);
    if (stringJson != null) {
      return MultiSignInMessageResponse.fromJson(
          stringJson as Map<String, dynamic>);
    }
    return null;
  }

  static Future<void> clearSessionSetting() async {
    getIt.get<SharedPreferencesManager>().remove(keyMultiSignInMessage);
  }
}
