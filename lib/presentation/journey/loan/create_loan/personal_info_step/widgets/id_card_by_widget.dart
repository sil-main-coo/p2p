import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';

class IDCardByWidget extends StatelessWidget {
  const IDCardByWidget({Key? key, required this.controller, this.initialValue})
      : super(key: key);

  final TextEditingController controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      initialValue: initialValue,
      validator: (value) {
        if (AppValidators.isEmptyStringData(value)) {
          return '${S.current.validatorEmptyField} '
              '${S.current.IDCardIssueBy.toLowerCase()} '
              '${S.current.yourself.toLowerCase()} '
              '${S.current.validatorToNextMsg.toLowerCase()}';
        }
        return null;
      },
      labelText: S.current.issueBy,
      isRequired: true,
      hintText:
          '${S.current.IDCardIssueBy} ${S.current.yourself.toLowerCase()}',
    );
  }
}
