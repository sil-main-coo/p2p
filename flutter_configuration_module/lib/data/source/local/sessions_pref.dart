import 'package:flutter_configuration_module/data/common/pref_key.dart';
import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/di/di_module.dart';

class SessionPref {
  static void saveSession(
      {required String accessToken,
      required String refreshToken,
      required String userName}) {
    var preferencesManager = getIt.get<SharedPreferencesManager>();
    preferencesManager.set(keyAccessToken, accessToken);
    preferencesManager.set(keyRefreshToken, refreshToken);
    preferencesManager.set(keyUserName, userName);
  }

  static String? getUserName() =>
      getIt.get<SharedPreferencesManager>().get(keyUserName);

  static String? getAccessToken() =>
      getIt.get<SharedPreferencesManager>().get(keyAccessToken);

  static String? getRefreshToken() =>
      getIt.get<SharedPreferencesManager>().get(keyRefreshToken);

  static bool isSessionValid() {
    try {
      return getIt
              .get<SharedPreferencesManager>()
              .get(keyAccessToken)
              ?.isNotEmpty ==
          true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> removeUserName() async {
    // await getIt.get<SharedPreferencesManager>().clear();
    await getIt.get<SharedPreferencesManager>().remove(keyUserName);
    await getIt.get<SharedPreferencesManager>().remove(keyAccessToken);
    await getIt.get<SharedPreferencesManager>().remove(keyRefreshToken);
  }

  static Future<void> removeTokenUserData() async {
    await getIt.get<SharedPreferencesManager>().remove(keyAccessToken);
    await getIt.get<SharedPreferencesManager>().remove(keyRefreshToken);
  }

  static Future<void> clearSessionData() async {
    // await getIt.get<SharedPreferencesManager>().clear();
    await removeTokenUserData();
    await removeUserName();
  }
}
