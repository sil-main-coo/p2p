import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'app_textfield.dart';

class AppTextFieldSuffixNavigator extends StatelessWidget {
  const AppTextFieldSuffixNavigator(
      {Key? key,
        this.errorText,
      this.initialValue,
      required this.controller,
      this.validatorText,
      this.validator,
      required this.onTapFieldCallback,
      this.labelText,
      this.isRequired = false,
      required this.hintText})
      : super(key: key);

  final Function onTapFieldCallback;
  final String? labelText;
  final bool isRequired;
  final String hintText;
  final String? validatorText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? initialValue;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return AppTextField.withAction(
      controller: controller,
      initialValue: initialValue,
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
      suffixIcon: Icon(
        Icons.arrow_forward_ios,
        size: 16.w,
        color: mColorPlaceholder,
      ),
      hintText: hintText,
    );
  }
}
