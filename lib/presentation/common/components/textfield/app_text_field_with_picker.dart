import 'package:flutter/material.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'app_text_field_suffix_dropdown.dart';
import 'app_textfield.dart';

class AppTextFieldWithPicker extends StatelessWidget {
  const AppTextFieldWithPicker(
      {Key? key,
      this.errorTextField,
      this.errorTextPicker,
      this.onChanged,
      this.personTypeInit,
      this.phoneInit,
      this.validatorField,
      this.validatorPicker,
      this.labelText,
      this.isRequire = false,
      required this.valuePicker,
      required this.hintTextField,
      this.validatorText,
      required this.ctrlTextField,
      required this.ctrlPicker,
      required this.onTapFieldCallback})
      : super(key: key);

  final String valuePicker, hintTextField;
  final bool isRequire;
  final String? labelText;
  final Function onTapFieldCallback;
  final TextEditingController ctrlTextField;
  final TextEditingController ctrlPicker;
  final String? validatorText;
  final String? Function(String?)? validatorField, validatorPicker;
  final String? personTypeInit, phoneInit;
  final Function(String?)? onChanged;
  final String? errorTextPicker, errorTextField;

  @override
  Widget build(BuildContext context) {
    final errorStyle = Theme.of(context).textTheme.textErrorTextField;
    final labelStyle = Theme.of(context).textTheme.textLabelTextField;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                labelText!,
                style: labelStyle,
              ),
              if (isRequire)
                Text(
                  ' *',
                  style: errorStyle,
                ),
            ],
          ),
        Row(
          children: [
            IntrinsicWidth(
              child: AppTextFieldSuffixDropDown(
                initialValue: personTypeInit,
                validator: validatorPicker,
                errorText: errorTextPicker != null ? '' : null,
                controller: ctrlPicker,
                onTapFieldCallback: () {
                  onTapFieldCallback();
                },
                hintText: valuePicker,
              ),
            ),
            Expanded(
              flex: 1,
              child: AppTextField.phone(
                initialValue: phoneInit,
                controller: ctrlTextField,
                onChanged: onChanged,
                hintText: hintTextField,
                errorText: errorTextField,
                validator: validatorField != null
                    ? validatorField
                    : validatorText == null
                        ? null
                        : (value) {
                            if (value == null ||
                                value.isEmpty ||
                                ctrlPicker.text.isEmpty) {
                              return validatorText;
                            }
                            return null;
                          },
              ),
            )
          ],
        ),
      ],
    );
  }
}
