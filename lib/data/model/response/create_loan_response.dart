import 'package:p2p_borrower/data/model/response/base_response.dart';

import 'loan_application_response.dart';

class CreateLoanResponse extends BaseResponse {
  LoanApplicationResponse? data;

  CreateLoanResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    if (json['data'] != null) {
      data = LoanApplicationResponse.fromJson(json['data']);
    }
  }
}
