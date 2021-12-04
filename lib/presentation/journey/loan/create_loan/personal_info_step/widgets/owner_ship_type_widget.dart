import 'package:flutter/material.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/app_picker/app_item_picker.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_navigator.dart';

class OwnerShipTypeWidget extends StatelessWidget {
  const OwnerShipTypeWidget(
      {Key? key,
      required this.controller,
      required this.list,
      required this.onPressedDone,
      this.selected})
      : super(key: key);

  final TextEditingController controller;
  final List<OwnerShipTypeResponse> list;
  final OwnerShipTypeResponse? selected;
  final Function(OwnerShipTypeResponse) onPressedDone;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldSuffixNavigator(
      controller: controller,
      initialValue: selected != null ? selected!.name : null,
      validatorText: '${S.current.validatorEmptyField} '
          '${S.current.ownerShipType.toLowerCase()} '
          '${S.current.yourself.toLowerCase()} '
          '${S.current.validatorToNextMsg.toLowerCase()}',
      onTapFieldCallback: () {
        AppItemPicker.show<OwnerShipTypeResponse>(
            context: context,
            onPressedDone: (value) {
              controller.text = value.name!;
              onPressedDone(value);
            },
            itemSelected: selected ?? list[0],
            dataList: list);
      },
      labelText: S.current.ownerShipType,
      isRequired: true,
      hintText: S.current.clickToSelect,
    );
  }
}
