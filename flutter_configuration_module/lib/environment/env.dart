import 'dart:async';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_configuration_module/environment/build_config.dart';
import 'package:flutter_configuration_module/network/http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Env {
  // Design size screen
  final Size sizeDesign = Size(375, 667);

  Env() {
    _init();
  }

  _init() {
    runZoned(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await const MethodChannel('flavor')
          .invokeMethod<String>('getFlavor')
          .then((String? flavor) async {
        BuildConfig.init(flavor: flavor);
      }).catchError((error) {});

      /// Init firebase
      await onInitFirebase();

      /// Init hive storage
      await onInitHive();

      /// DI
      await onInjection();

      HttpOverrides.global = MyHttpOverrides(); // use in run zone

      final StatefulWidget app = await onCreate(); // return init widget
      final wrapMultiScreen = ScreenUtilInit(
        designSize: sizeDesign,
        builder: () => app,
      );

      runApp(wrapMultiScreen);
      // ignore: deprecated_member_use
    }, onError: (Object obj, StackTrace stack) {
      print(obj);
      print(stack);
    });
  }

  Future? onInjection();

  Future? onInitHive();

  Future? onInitFirebase();

  FutureOr<StatefulWidget> onCreate();
}
