import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/app_alert_dialog_widget.dart';

class ActionDialogs {
  // ActionDialogs.showAction(
  // context: context,
  // barrierDismissible: false,
  // title: S.current.dialogTypeAccountTitle,
  // message: S.current.dialogTypeAccountMsg,
  // leftLabel: S.current.no,
  // callBackLeft: () => Navigator.pop(context),
  // rightLabel: S.current.switchTypeAcc,
  // callBackRight: () {
  // // some code...
  // });
  static void showAction(
      {required BuildContext context,
      bool barrierDismissible = true,
      String? title,
      required String message,
      String? leftLabel,
      Function? callBackLeft,
      required String rightLabel,
      required Function callBackRight,
      bool isRightSpotLight = true}) {
    final messageStyle = Theme.of(context).textTheme.bodyText1;
    final content = Text(
      message,
      style: messageStyle,
    );

    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AppAlertDialogWidget(
              callBackRight: callBackRight,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.h),
              content: content,
              rightLabel: rightLabel,
              title: title,
              barrierDismissible: barrierDismissible,
              callBackLeft: callBackLeft,
              leftLabel: leftLabel,
              isRightSpotLight: isRightSpotLight,
            ));
  }
}
