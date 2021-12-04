import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'app_textfield.dart';

class AppTextFieldSuffixDropDown extends StatelessWidget {
  const AppTextFieldSuffixDropDown(
      {Key? key,
      this.onChanged,
      this.initialValue,
      required this.onTapFieldCallback,
      this.labelText,
      this.validatorText,
      this.controller,
      this.validator,
      this.errorText,
      this.isRequired = false,
      required this.hintText})
      : super(key: key);

  final TextEditingController? controller;
  final Function onTapFieldCallback;
  final String? labelText;
  final bool isRequired;
  final String hintText;
  final String? validatorText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String?)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return AppTextField.withAction(
      key: key,
      initialValue: initialValue,
      controller: controller,
      errorText: errorText,
      onTapFieldCallback: () {
        onTapFieldCallback();
      },
      validator: validator != null
          ? validator
          : validatorText == null
              ? null
              : (value) {
                  if (AppValidators.isEmptyStringData(value)) {
                    return validatorText;
                  }
                  return null;
                },
      labelText: labelText,
      isRequired: isRequired,
      onChanged: onChanged,
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        color: mColorIconGreen,
      ),
      hintText: hintText,
    );
  }
}
