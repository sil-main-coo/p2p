import 'package:device_info/device_info.dart';
import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_borrower/common/helpers/firebase/fcm_helper.dart';
import 'package:p2p_borrower/common/helpers/image_picker/image_picker_helper.dart';
import 'package:p2p_borrower/common/helpers/local_notify/local_notify_helper.dart';
import 'package:p2p_borrower/common/helpers/social_auth/facebook_helper.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';

class ComponentsModule extends DIModule {
  @override
  provides() async {
    getIt.registerSingleton(AppLoadingDialog());
    getIt.registerSingleton(SharedPreferencesManager());
    await getIt.get<SharedPreferencesManager>().init();
    getIt.registerSingleton(DeviceInfoPlugin());
    getIt.registerSingleton<LocalNotifyHelper>(
        LocalNotifyHelperImpl(FlutterLocalNotificationsPlugin()));
    getIt.registerSingleton<FirebaseMessageHelper>(FirebaseMessageHelperImpl(
        localNotifyHelper: getIt.get<LocalNotifyHelper>()));
    getIt.registerSingleton(ImagePickerHelper(picker: ImagePicker()));
    getIt.registerSingleton<FacebookHelper>(FacebookHelperImpl());
  }
}
