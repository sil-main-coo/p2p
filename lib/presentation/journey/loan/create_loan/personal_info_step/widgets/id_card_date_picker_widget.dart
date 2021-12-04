import 'package:flutter/material.dart';

import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';

import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/app_picker/app_date_picker.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_dropdown.dart';

class IDCardDatePickerWidget extends StatelessWidget {
  const IDCardDatePickerWidget(
      {Key? key,
      this.errorText,
      required this.controller,
      this.initialDateTime,
      required this.onPressedDone})
      : super(key: key);

  final TextEditingController controller;
  final DateTime? initialDateTime;
  final Function(DateTime) onPressedDone;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldSuffixDropDown(
      controller: controller,
      errorText: errorText,
      initialValue:
          initialDateTime != null ? initialDateTime!.toStringDefault : null,
      validator: (time) {
        if (AppValidators.isEmptyStringData(time)) {
          return '${S.current.validatorEmptyField} '
              '${S.current.IDCardIssueDate.toLowerCase()} '
              '${S.current.yourself.toLowerCase()} '
              '${S.current.validatorToNextMsg.toLowerCase()}';
        }

        if (AppValidators.isInValidIssueDate(time!)) {
          return S.current.invalidDate;
        }
        return null;
      },
      onTapFieldCallback: () {
        AppDatePicker.show(
            context: context,
            initialDateTime: initialDateTime ?? AppDatePickerConstants.now,
            minimumDate: AppDatePickerConstants.minimumDate,
            maximumDate: AppDatePickerConstants.now,
            maximumYear: AppDatePickerConstants.now.year,
            minimumYear: AppDatePickerConstants.minimumYear,
            onPressedDone: (value) {
              controller.text = value.toStringDefault;
              onPressedDone(value);
            });
      },
      labelText: S.current.IDCardIssueDate,
      isRequired: true,
      hintText: '${S.current.IDCardIssueDate}',
    );
  }
}
