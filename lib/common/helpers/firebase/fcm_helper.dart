import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:p2p_borrower/common/helpers/local_notify/local_notify_helper.dart';
import 'package:p2p_borrower/manifest.dart';

abstract class FirebaseMessageHelper {
  Future<AuthorizationStatus?> permissionIOS();

  Future<String?> getFCMToken();

  Future<void> subscribeTopic(String topic);

  Future<void> unsubscribeTopic(String topic);

  Future setForegroundNotifications();

  Future<void> setupInteractedMessage(
      {required Future Function(RemoteMessage) onInitial,
      required Future Function(RemoteMessage) onOpenedApp,
      required Future Function(RemoteMessage) onMessage});

  Future createAndroidChannels(
      {required List<AndroidNotificationChannel> channels});
}

class FirebaseMessageHelperImpl implements FirebaseMessageHelper {
  FirebaseMessageHelperImpl({required this.localNotifyHelper});

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final LocalNotifyHelper localNotifyHelper;

  /// This method should called when first run
  @override
  Future<AuthorizationStatus?> permissionIOS() async {
    NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    /// authorized: The user granted permission.
    /// denied: The user denied permission.
    /// notDetermined: The user has not yet chosen whether to grant permission.
    /// provisional: The user granted provisional permission
    debugPrint('IOS User granted permission: ${settings.authorizationStatus}');

    return settings.authorizationStatus;
  }

  @override
  Future createAndroidChannels(
      {required List<AndroidNotificationChannel> channels}) async {
    for (var channel in channels) {
      await localNotifyHelper.createNotificationChannel(channel);
    }
  }

  @override
  Future<String?> getFCMToken() async => await _fcm.getToken();

  Future setForegroundNotifications() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      return;
    }

    if (Platform.isAndroid) {}
  }

  Future<void> setupInteractedMessage(
      {required Future Function(RemoteMessage) onInitial,
      required Future Function(RemoteMessage) onOpenedApp,
      required Future Function(RemoteMessage) onMessage}) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      await onInitial(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await onOpenedApp(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await onMessage(message);
    });

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Future<void> subscribeTopic(String topic) async {
    await _fcm
        .subscribeToTopic(topic)
        .then((_) => log('>>> Subscribed topic: $topic'));
  }

  @override
  Future<void> unsubscribeTopic(String topic) async {
    await _fcm
        .unsubscribeFromTopic(topic)
        .then((_) => log('>>> Unsubscribed topic: $topic'));
  }
}
