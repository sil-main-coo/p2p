import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/device_info_response.dart';

class DeviceLocalSource {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceLocalSource({required this.deviceInfoPlugin});

  Future<DeviceInfoResponse> getDeviceDetails() async {
    String deviceName = '';
    String identifier = '';

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        identifier = data.identifierForVendor; //UUID for iOS
      }

      return DeviceInfoResponse(identifier, deviceName);
    } catch (e) {
      print('Failed to get platform version');
      throw LocalException();
    }
  }
}
