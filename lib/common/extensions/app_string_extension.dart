import 'package:p2p_borrower/common/constants/loan_unit_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';

extension AppStringExtension on String {

  String get translate {
    switch (this) {
      case LoanDurationUnitConstants.day:
        return S.current.day;
      case LoanDurationUnitConstants.month:
        return S.current.month;
      case LoanDurationUnitConstants.year:
        return S.current.year;
      case LoanAmountUnitConstants.million:
        return S.current.million;
      default:
        throw '"$this" is not LoanUnitConstants type ';
    }
  }

  double getStepOfSliderWithDurationUnit() {
    switch (this) {
      case LoanDurationUnitConstants.day:
        return 10.0;
      case LoanDurationUnitConstants.month:
        return 1.0;
      case LoanAmountUnitConstants.million:
        return 1.0;
      default:
        throw '"$this" is not LoanUnitConstants type ';
    }
  }
}
