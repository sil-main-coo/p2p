import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    //
    // print("oldValue: ${oldValue.text}");
    // print("newValue: ${newValue.text}");

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

}
