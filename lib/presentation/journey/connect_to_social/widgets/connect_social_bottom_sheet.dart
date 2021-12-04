import 'package:flutter/material.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/bottom_sheets/bottom_sheet_default/content_bottom_sheet_default.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class ConnectSocialBottomSheet {
  static void show(
      {required BuildContext context,
      required Function changeFacebookAccount}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ConnectSocialBottomSheetWidget(
          changeFacebookAccount: changeFacebookAccount),
    );
  }
}

class ConnectSocialBottomSheetWidget extends StatelessWidget {
  ConnectSocialBottomSheetWidget(
      {Key? key, required this.changeFacebookAccount})
      : super(key: key);

  final Function changeFacebookAccount;

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ButtonBottomSheetModel(
          label: '${S.current.changeFacebookFacebookConnection}',
          color: mPrimaryColor,
          onPressed: () {
            changeFacebookAccount();
            Navigator.pop(context);
          }),
    ];

    return ContentBottomSheetDefault(
      title: S.current.option,
      buttons: buttons,
    );
  }
}
