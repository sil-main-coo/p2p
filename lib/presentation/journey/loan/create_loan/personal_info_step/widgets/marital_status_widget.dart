import 'package:flutter/material.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/app_picker/app_item_picker.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_navigator.dart';

class MaritalStatusWidget extends StatelessWidget {
  const MaritalStatusWidget(
      {Key? key,
      required this.maritalStatuses,
      this.selected,
      required this.controller,
      required this.onPressedDone})
      : super(key: key);

  final List<MaritalStatusResponse> maritalStatuses;
  final MaritalStatusResponse? selected;
  final TextEditingController controller;
  final Function(MaritalStatusResponse) onPressedDone;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldSuffixNavigator(
      controller: controller,
      initialValue: selected != null ? selected!.status : null,
      validatorText: '${S.current.validatorEmptyField} '
          '${S.current.maritalStatus.toLowerCase()} '
          '${S.current.yourself.toLowerCase()} '
          '${S.current.validatorToNextMsg.toLowerCase()}',
      onTapFieldCallback: () {
        AppItemPicker.show<MaritalStatusResponse>(
            context: context,
            onPressedDone: (value) {
              controller.text = value.status!;
              onPressedDone(value);
            },
            itemSelected: selected ?? maritalStatuses[0],
            dataList: maritalStatuses);
      },
      labelText: S.current.maritalStatus,
      isRequired: true,
      hintText: S.current.clickToSelect,
    );
  }
}
