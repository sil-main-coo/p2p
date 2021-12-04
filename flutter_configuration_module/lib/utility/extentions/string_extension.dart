import 'package:flutter_configuration_module/utility/constants/regex_constants.dart';

extension StringExtension on String {
  String get enumToName {
    final List<String> paths = this.split('.');
    return paths[1];
  }

  bool get isNewVietnamPhoneNumber {
    return RegExp(RegexConstants.newVietnamPhoneNumber).hasMatch(this);
  }

  bool get isOldVietnamNumberPhone {
    return RegExp(RegexConstants.oldVietnamPhoneNumber).hasMatch(this);
  }

  String get toAllDigit {
    return this.replaceAll(RegExp(RegexConstants.notHasDigitRegex), '');
  }

  bool get isAllNumeric =>
      this.isNotEmpty &&
      RegExp(RegexConstants.hasOnlyDigitRegex).hasMatch(this);
}
