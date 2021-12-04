import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';
import 'package:intl/intl.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/constants/regex_constants.dart';

class AppValidators {
  static bool isEmptyStringData(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isNotFullName(String fullName) {
    return fullName.length <= AppDefaultConstants.MIN_FULL_NAME ||
        fullName.length >= AppDefaultConstants.MAX_FULL_NAME ||
        AppRegexConstants.regVietnamLowerCaseChar
            .hasMatch(fullName.toLowerCase());
  }

  static bool isNotIDCard(String id) {
    return id.length != AppDefaultConstants.CARD_ID_LEN ||
        AppRegexConstants.allDigitRegex.hasMatch(id.toLowerCase());
  }

  static bool isInValidIssueDate(String time) {
    DateTime tempDate =
        new DateFormat(DateTimeFormatConstants.defaultDateTimeFormat)
            .parse(time);
    return tempDate.isToday;
  }

  static bool isOldVietnamNumberPhone(String phone) {
    return phone.isOldVietnamNumberPhone;
  }

  static bool isNewVietnamPhoneNumber(String phone) {
    return phone.isNewVietnamPhoneNumber;
  }

  static bool isNotPhoneNumber(String phone) {
    return phone.length <= 9 || !phone.isAllNumeric;
  }

  static bool isPhoneDuplicateWithYourself(String phone) {
    String? yourselfPhone = SessionPref.getUserName();
    if (yourselfPhone == null) return false;
    yourselfPhone = yourselfPhone.replaceAll('+84', '');
    return phone.replaceAll('+84', '') == yourselfPhone;
  }
}
