import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/app_picker/app_item_picker.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_with_picker.dart';

class RelativePersonWidget extends StatelessWidget {
  const RelativePersonWidget(
      {Key? key,
      this.errorTextField,
      this.errorTextPicker,
      this.label,
      this.onFieldChanged,
      required this.onPressedDone,
      required this.ctrlRelativePersonPhone,
      required this.ctrlRelativePersonPicker,
      required this.indexLabel,
      this.relativeSelected,
      required this.relativePersonTypes})
      : super(key: key);

  final int indexLabel;
  final List<RelativePersonRequest> relativePersonTypes;
  final RelativePersonRequest? relativeSelected;
  final TextEditingController ctrlRelativePersonPicker, ctrlRelativePersonPhone;
  final Function(RelativePersonRequest) onPressedDone;
  final Function(String?)? onFieldChanged;
  final String? label;
  final String? errorTextPicker, errorTextField;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWithPicker(
      personTypeInit: relativeSelected != null ? relativeSelected!.type : null,
      phoneInit: relativeSelected != null ? relativeSelected!.phone : null,
      valuePicker: S.current.yourRelative,
      labelText: label,
      errorTextField: errorTextField,
      errorTextPicker: errorTextPicker,
      ctrlTextField: ctrlRelativePersonPhone,
      ctrlPicker: ctrlRelativePersonPicker,
      onChanged: onFieldChanged,
      isRequire: true,
      hintTextField: '${S.current.phoneOfRelativeHintField} $indexLabel',
      validatorField: (value) {
        return _validatorPersonPhone(value, ctrlRelativePersonPicker);
      },
      validatorPicker: (picker) {
        return _validatorPersonPhonePicker(picker, ctrlRelativePersonPhone);
      },
      onTapFieldCallback: () {
        AppItemPicker.show<RelativePersonRequest>(
            context: context,
            onPressedDone: (value) {
              ctrlRelativePersonPicker.text = value.type!;
              onPressedDone(value);
            },
            itemSelected: relativeSelected ?? relativePersonTypes[0],
            dataList: relativePersonTypes);
      },
    );
  }

  String? _validatorPersonPhonePicker(
      String? picker, TextEditingController ctrlField) {
    final phoneValue = ctrlField.text.trim();
    if (errorTextPicker != null) return '';

    if (AppValidators.isNewVietnamPhoneNumber(phoneValue)) {
      if (AppValidators.isPhoneDuplicateWithYourself(phoneValue)) {
        return '';
      }
      return null;
    }

    return '';
  }

  String? _validatorPersonPhone(
      String? value, TextEditingController ctrlPicker) {
    if (AppValidators.isEmptyStringData(value) ||
        AppValidators.isEmptyStringData(ctrlPicker.text.trim())) {
      return S.current.MSG28;
    }

    if (AppValidators.isNewVietnamPhoneNumber(value!)) {
      if (AppValidators.isPhoneDuplicateWithYourself(value)) {
        return S.current.MSG29;
      }
      return null;
    }

    if (AppValidators.isOldVietnamNumberPhone(value)) {
      return S.current.MSG12;
    }

    return S.current.MSG29;
  }
}
