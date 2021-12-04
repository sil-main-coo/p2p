import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_configuration_module/utility/constants/regex_constants.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter({this.maxDigits = 0});

  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // print("oldValue: ${oldValue.text}");
    // print("newValue: ${newValue.text}");
    String newText;

    if (newValue.text.isNotEmpty) {
      String textReg =
          newValue.text.replaceAll(RegExp(RegexConstants.notHasDigitRegex), '');

      int value = int.parse(textReg);
      final formatter = new NumberFormat("#,###");
      newText = formatter.format(value);
    } else {
      newText = '';
    }
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
