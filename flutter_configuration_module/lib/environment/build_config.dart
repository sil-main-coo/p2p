import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:flutter_configuration_module/utility/utils/logging.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:package_info/package_info.dart';

enum Flavor { DEVELOPMENT, STAGING, PREPROD, RELEASE }

class BuildConfig {
  const BuildConfig._(
      {required this.baseUrl,
      required this.socketUrl,
      required this.connectTimeout,
      required this.receiveTimeout,
      required this.flavor,
      this.color = Colors.blue});

  const BuildConfig._development()
      : this._(
          baseUrl: 'http://192.168.100.12:5000/api',
          socketUrl: '',
          connectTimeout: 5000,
          receiveTimeout: 5000,
          flavor: Flavor.DEVELOPMENT,
        );

  const BuildConfig._staging()
      : this._(
            baseUrl: 'http://192.168.1.109/p2p-api/api',
            socketUrl: '',
            connectTimeout: 5000,
            receiveTimeout: 5000,
            flavor: Flavor.STAGING);

  const BuildConfig._preprod()
      : this._(
            baseUrl: 'http://192.168.100.12:5000/api',
            socketUrl: '',
            connectTimeout: 5000,
            receiveTimeout: 5000,
            flavor: Flavor.PREPROD);

  const BuildConfig._release()
      : this._(
            baseUrl: 'http://192.168.1.109/p2p-api/api',
            socketUrl: '',
            connectTimeout: 5000,
            receiveTimeout: 5000,
            flavor: Flavor.RELEASE);

  static BuildConfig? _instance;

  static init({flavor}) async {
    if (_instance == null) {
      debugPrint(
          '╔══════════════════════════════════════════════════════════════╗');
      debugPrint(
          '                    Build Flavor: $flavor                       ');
      debugPrint(
          '╚══════════════════════════════════════════════════════════════╝');
      switch (flavor) {
        case 'development':
          _packageInfo();
          _instance = const BuildConfig._development();
          break;
        case 'staging':
          _packageInfo();
          _instance = const BuildConfig._staging();
          break;
        case 'preprod':
          _instance = const BuildConfig._preprod();
          break;
        default:
          _instance = const BuildConfig._release();
          break;
      }
    }
    _iniLog(flavor);
  }

  static _packageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    debugPrint(
        '╔══════════════════════════════════════════════════════════════╗');
    debugPrint(
        '             Package Name: ${packageInfo.packageName}           ');
    debugPrint(
        '             App Name: ${packageInfo.appName}                   ');
    debugPrint(
        '             Version: ${packageInfo.version}                    ');
    debugPrint(
        '             Build Number: ${packageInfo.buildNumber}           ');
    debugPrint(
        '╚══════════════════════════════════════════════════════════════╝');
  }

  static BuildConfig? get() {
    return _instance;
  }

  static _iniLog(flavor) async {
    await Log.init();
    switch (_instance?.flavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.PREPROD:
        Log.setLevel(Level.ALL);
        break;
      case Flavor.RELEASE:
        Log.setLevel(Level.OFF);
        break;
      default:
        break;
    }
  }

  final String baseUrl;
  final String socketUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final Flavor flavor;
  final Color color;

  static String flavorName() => _instance?.flavor.toString().enumToName ?? "";

  static bool isRelease() => _instance?.flavor == Flavor.RELEASE;

  static bool isProduction() => _instance?.flavor == Flavor.PREPROD;

  static bool isStaging() => _instance?.flavor == Flavor.STAGING;

  static bool isDevelopment() => _instance?.flavor == Flavor.DEVELOPMENT;
}
