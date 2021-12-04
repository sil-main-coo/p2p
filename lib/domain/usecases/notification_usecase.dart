import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p2p_borrower/common/helpers/firebase/fcm_android_channels.dart';
import 'package:p2p_borrower/common/helpers/firebase/fcm_helper.dart';
import 'package:p2p_borrower/common/helpers/local_notify/local_notify_helper.dart';
import 'package:p2p_borrower/data/sources/local/device_local_source.dart';

class NotificationUseCase {
  NotificationUseCase(
      {required this.localNotifyHelper,
      required this.fcmHelper,
      required this.deviceLocalSource});

  final LocalNotifyHelper localNotifyHelper;
  final FirebaseMessageHelper fcmHelper;
  final DeviceLocalSource deviceLocalSource;

  Future initialLocalNotification(
      {required Future onDidReceiveLocalNotification(
          int id, String? title, String? body, String? payload),
      required Future selectNotification(String? payload),
      required Future onLaunchAppByNotification(String payload)}) async {
    await localNotifyHelper.initLocalNotification(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        selectNotification: selectNotification,
        onLaunchAppByNotification: onLaunchAppByNotification);
  }

  /// Permission for ios
  Future<AuthorizationStatus?> initialFCMForIOS() => fcmHelper.permissionIOS();

  /// Create channels for Android
  Future createAndroidChannels() =>
      fcmHelper.createAndroidChannels(channels: FCMAndroidChannels.channels);

  /// Catch FCM detail
  Future setupInteractedFCMMessage(
          {required Future Function(RemoteMessage) onInitial,
          required Future Function(RemoteMessage) onOpenedApp,
          required Future Function(RemoteMessage) onMessage}) =>
      fcmHelper.setupInteractedMessage(
          onInitial: onInitial, onOpenedApp: onOpenedApp, onMessage: onMessage);

  /// Call this method in case that want to receive alert multi sign in notification
  Future subscribeByDeviceTopic() async {
    final device = await deviceLocalSource.getDeviceDetails();
    await fcmHelper.subscribeTopic(device.deviceId);
  }

  Future unSubscribeByDeviceTopic() async {
    final device = await deviceLocalSource.getDeviceDetails();
    fcmHelper.unsubscribeTopic(device.deviceId);
  }
}
