import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/radio_dialog_widget.dart';

class SelectAddressDialog {
  static void show<T>(
      {required BuildContext context,
      required List<T> data,
      required T dataSelected,
      required Function(T) callbackSelect}) {
    showDialog(
      context: context,
      builder: (ct) => RadioDialogWidget<T>(
        title: S.current.provinceOrCity,
        callbackSelect: callbackSelect,
        data: data,
        dataSelected: dataSelected,
      ),
    );
  }
}
