import 'package:intl/intl.dart';
import 'package:p2p_borrower/common/constants/loan_unit_constants.dart';

extension AppNumExtension on num {
  /// [unitAmount]: see in [loan_unit_constants.dart]
  String toFormatNumberStringWithUnit(String unitAmount) {
    switch (unitAmount) {
      case LoanAmountUnitConstants.thousand:
        // convert to thousand unit
        var actual = this * 1000;

        final formatter = new NumberFormat("###,###");
        return formatter.format(actual);
      case LoanAmountUnitConstants.million:
        // convert to million unit
        var actual = this * 1000000;

        final formatter = new NumberFormat("###,###,###");
        return formatter.format(actual);
      case LoanAmountUnitConstants.billion:
        // convert to million unit
        var actual = this * 1000000000;

        final formatter = new NumberFormat("###,###,###,###");
        return formatter.format(actual);
      default:
        return this.toString();
    }
  }

  String get toDefaultFormatNumberString{
    final formatter = new NumberFormat("#,###");
    return formatter.format(this);
  }

  /// [unitAmount]: see in [loan_unit_constants.dart]
  int toEmulatorNumberWithinUnit(String? unitAmount) {
    num value;

    switch (unitAmount) {
      case LoanAmountUnitConstants.thousand:
      // convert to thousand unit
        value = this / 1000;
        break;
      case LoanAmountUnitConstants.million:
      // convert to million unit
        value = this / 1000000;
        break;
      case LoanAmountUnitConstants.billion:
      // convert to million unit
        value = this / 1000000000;
        break;
      default:
        value = this / 1000000;
    }

    if (value is double) {
      return (value as double).toInt();
    }
    return (value as int);
  }

  /// [unitAmount]: see in [loan_unit_constants.dart]
  int toActualNumberWithinUnit(String unitAmount) {
    num value;

    switch (unitAmount) {
      case LoanAmountUnitConstants.thousand:
        // convert to thousand unit
        value = this * 1000;
        break;
      case LoanAmountUnitConstants.million:
        // convert to million unit
        value = this * 1000000;
        break;
      case LoanAmountUnitConstants.billion:
        // convert to million unit
        value = this * 1000000000;
        break;
      default:
        value =  (this as int);
    }

    if (value is double) {
      return (value as double).toInt();
    }
    return (value as int);
  }

  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
