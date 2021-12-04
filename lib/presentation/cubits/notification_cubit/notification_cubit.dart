import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:p2p_borrower/data/model/response/multi_signin_message_response.dart';
import 'package:p2p_borrower/data/sources/local/settings_session_prefer.dart';
import 'package:p2p_borrower/domain/usecases/notification_usecase.dart';
import 'package:flutter_configuration_module/data/source/local/local_setting_pref.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationUseCase})
      : super(NotificationInitial());

  final NotificationUseCase notificationUseCase;

  Future initialApp() async {
    /// First notify setup
    if (LocalSettingsPref.isFirstNotifySetting()) {
      await notificationUseCase.initialLocalNotification(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
          selectNotification: _selectNotification,
          onLaunchAppByNotification: onLaunchAppByNotification);
      if (Platform.isIOS) {
        final authStatus = await notificationUseCase.initialFCMForIOS();

        switch (authStatus) {
          case AuthorizationStatus.denied:
            break;
          case AuthorizationStatus.notDetermined:
            break;
          default:
            break;
        }
      } else if (Platform.isAndroid) {
        notificationUseCase.createAndroidChannels();
      }
    }

    /// Setup finally
    await notificationUseCase.setupInteractedFCMMessage(
        onInitial: _onInitialFCM,
        onOpenedApp: _onOpenedAppFCM,
        onMessage: _onMessageFCM);

    /// subscribe user topic by device id
    notificationUseCase.subscribeByDeviceTopic();

    emit(NotificationDone());
  }

  ///  =========================
  ///  || FCM NOTIFY CALLBACK ||
  /// ==========================

  Future _onOpenedAppFCM(RemoteMessage remoteMessage) async {
    print('>>> _onOpenedAppFCMMessage: ${remoteMessage.data}');
    // _handlingMultiSignInMessage(remoteMessage);
  }

  Future _onInitialFCM(RemoteMessage remoteMessage) async {
    print('>>> _onInitialFCMMessage: ${remoteMessage.notification!.body}');
    // _handlingMultiSignInMessage(remoteMessage);
  }

  Future _onMessageFCM(RemoteMessage remoteMessage) async {
    print('>>> _onMessageFCM: ${remoteMessage.data}');
    _handlingMultiSignInMessage(remoteMessage);
  }

  void _handlingMultiSignInMessage(RemoteMessage remoteMessage) async {
    final response = MultiSignInMessageResponse.fromJson(remoteMessage.data);
    if (response.loginTime != null && response.loginDeviceId != null) {
      // handling logout on device
      // and save alert data
      await SessionPref.removeTokenUserData();
      SettingsSessionPref.saveMultiSignInMessage(message: response);

      emit(NotificationInitial());
      emit(NotificationAlert(listDataMessage: [response]));
    }
  }

  ///  =========================
  /// || LOCAL NOTIFY CALLBACK ||
  /// ==========================

  Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    debugPrint('_onDidReceiveLocalNotification payload: ' + payload!);
  }

  Future _selectNotification(String? payload) async {
    debugPrint('selectNotification payload: ' + payload!);
  }

  Future onLaunchAppByNotification(String payload) async {
    debugPrint('onLaunchAppByNotification payload: ' + payload);
  }
}
