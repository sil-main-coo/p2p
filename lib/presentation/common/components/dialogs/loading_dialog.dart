import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingDialog {
  BuildContext? _ct;

  void showDefault(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (cx) {
          if (_ct == null) _ct = cx;
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          );
        });
  }

  bool popDialog({BuildContext? context}) {
    if (context == null) {
      if (_ct != null) {
        try {
          if (Navigator.canPop(_ct!)) {
            Navigator.pop(_ct!);
            _ct = null;
            return true;
          }
        } catch (e) {
          debugPrint(e.toString());
          _ct = null;
          return false;
        }
      }
      return false;
    } else {
      Navigator.pop(context);
      _ct = null;
      return true;
    }
  }
}
