import 'package:flutter_configuration_module/data/common/pref_key.dart';
import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/di/di_module.dart';

class LocalSettingsPref {
  static bool isFirstTime() {
    var isFirstTime = getIt.get<SharedPreferencesManager>().get(keyFirstRun);
    if (isFirstTime != null && !isFirstTime) {
      getIt.get<SharedPreferencesManager>().set(keyFirstRun, false);
      return false;
    } else {
      getIt.get<SharedPreferencesManager>().set(keyFirstRun, false);
      return true;
    }
  }

  static bool isFirstNotifySetting() {
    var isFirstTime =
        getIt.get<SharedPreferencesManager>().get(keyFirstSetupNotify);
    if (isFirstTime != null && !isFirstTime) {
      getIt.get<SharedPreferencesManager>().set(keyFirstSetupNotify, false);
      return false;
    } else {
      getIt.get<SharedPreferencesManager>().set(keyFirstSetupNotify, false);
      return true;
    }
  }

  static void resetFirstNotifySetting() {
    getIt.get<SharedPreferencesManager>().set(keyFirstSetupNotify, true);
  }
}
