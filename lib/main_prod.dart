import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/hive/hive.dart';

import 'package:p2p_borrower/presentation/app/app.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:flutter_configuration_module/environment/env.dart';
import 'package:p2p_borrower/di/injection/injection.dart';

/// EndPoint default
void main() {
  Main();
}

class Main extends Env {
  @override
  FutureOr<StatefulWidget> onCreate() async{
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };

    await Style.styleDefault();

    return Application(
      // isDev: true,
      title: 'P2P Borrower Prod',
      locale: 'vi',
    );
  }

  @override
  Future? onInjection() async {
    await Injection.inject();
  }

  @override
  Future? onInitHive() async {
    await HiveSetup.init();
  }

  @override
  Future? onInitFirebase() async {
    await Firebase.initializeApp();
  }
}
