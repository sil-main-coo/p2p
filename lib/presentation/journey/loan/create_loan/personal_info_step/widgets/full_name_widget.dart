import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';

class FullNameFieldWidget extends StatelessWidget {
  const FullNameFieldWidget(
      {Key? key,
      this.onChanged,
      required this.controller,
      this.initialValue,
      this.errorText})
      : super(key: key);
  final TextEditingController controller;
  final String? initialValue;
  final String? errorText;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      initialValue: initialValue,
      labelText: S.current.fullName,
      errorText: errorText,
      onChanged: onChanged,
      maxLen: AppDefaultConstants.MAX_FULL_NAME,
      validator: (value) {
        if (AppValidators.isEmptyStringData(value)) {
          return S.current.MSG24;
        }

        if (AppValidators.isNotFullName(value!)) {
          return S.current.MSG25;
        }
        return null;
      },
      isRequired: true,
      hintText: '${S.current.fullName} ${S.current.yourself.toLowerCase()}',
    );
  }
}
