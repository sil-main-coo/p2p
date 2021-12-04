import 'package:flutter/material.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/radio_dialog_widget.dart';

class SelectPositionOccupationDialog {
  static void show(
      {required BuildContext context,
      required String title,
      required List<OccupationPositionResponse> data,
      OccupationPositionResponse? dataSelected,
      required Function(OccupationPositionResponse) callbackSelect}) {
    showDialog<OccupationPositionResponse>(
      context: context,
      builder: (ct) => RadioDialogWidget(
        title: title,
        callbackSelect: callbackSelect,
        data: data,
        dataSelected: dataSelected,
      ),
    );
  }
}
