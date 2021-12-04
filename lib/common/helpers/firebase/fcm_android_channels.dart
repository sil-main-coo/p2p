import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMAndroidChannelConstants {
  /// high channel
  static const String highAndroidChannelID = "p2p-borrower-high-channel";
  static const String highAndroidChannelName = "P2P Borrower high channel";
  static const String highAndroidChannelDescription =
      "P2P Borrower high channel notification";
}

class FCMAndroidChannels {
  static final _highAndroidChannel = AndroidNotificationChannel(
      FCMAndroidChannelConstants.highAndroidChannelID,
      FCMAndroidChannelConstants.highAndroidChannelName,
      FCMAndroidChannelConstants.highAndroidChannelDescription,
      importance: Importance.max,
      showBadge: true,
      enableLights: true);

  static final channels = [_highAndroidChannel];
}
