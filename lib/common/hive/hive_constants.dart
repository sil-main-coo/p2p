import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';

class HiveMasterLoanDataConstants {
  static const boxName = 'loan-box';
  static const loanProductsKey = 'loan-products-key';

  static const loanProductsResponseType = 1;
  static const additionalInfosType = 2;
  static const loanInfoStepRequest = 3;
}

class HiveLoanSimpleConstants {
  static String boxName() {
    final phone = SessionPref.getUserName();
    return 'loan-simple-box-$phone';
  }

  static const loanSimpleResponse = 4;
}

class HiveLoanDetailConstants {
  static String boxName() {
    final phone = SessionPref.getUserName();
    return 'loan-detail-box-$phone';
  }
  static const loanDetailResponse = 5;
  static const relativeLoanDetailResponse = 6;
  static const profileLoanDetailResponse = 7;
  static const linkedPaymentLoanDetailResponse = 8;
  static const additionalInfoLoanDetailResponse = 9;
  static const occupationInfoLoanDetail = 10;
  static const addressInfoLoanDetail = 11;
}
