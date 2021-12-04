import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';

class CancelLoanRequestDialog {
  static void show(BuildContext context, String statusText, Function callback) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.cancelLoanRequest,
        message:
            '${S.current.cancelLoanRequestMsg1} ${statusText.toLowerCase()} ${S.current.cancelLoanRequestMsg2}?',
        leftLabel: S.current.no,
        callBackLeft: () => Navigator.pop(context),
        rightLabel: S.current.delete,
        callBackRight: () async {
          Navigator.pop(context); // pop this dialog
          callback();
        });
  }
}
