import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';

class IDCardNumberWidget extends StatelessWidget {
  const IDCardNumberWidget(
      {Key? key, required this.controller, this.initialValue, this.errorText})
      : super(key: key);

  final TextEditingController controller;
  final String? initialValue;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return AppTextField.number(
      controller: controller,
      initialValue: initialValue,
      errorText: errorText,
      validator: (value) {
        if (AppValidators.isEmptyStringData(value)) {
          return S.current.MSG26;
        }

        if (AppValidators.isNotIDCard(value!)) {
          return S.current.MSG27;
        }
        return null;
      },
      labelText: S.current.IDCardNumber,
      maxLen: AppDefaultConstants.CARD_ID_LEN,
      isRequired: true,
      hintText: '${S.current.IDCardNumber} ${S.current.yourself.toLowerCase()}',
    );
  }
}
