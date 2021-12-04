// import 'package:hive/hive.dart';
// import 'package:p2p_borrower/common/hive/hive_constants.dart';
// import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
// import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
//
// part 'loan_info_step_response.g.dart';
//
// @HiveType(typeId: HiveLoanApplicationConstants.loanInfoStepResponse)
// class LoanInfoStepResponse extends HiveObject {
//   @HiveField(0)
//   LoanProductsResponse? loanProductSelected;
//
//   @HiveField(1)
//   double? loanAmount;
//
//   num? loanDuration;
//
//   @HiveField(2)
//   double? expectedInterestRate;
//
//   @HiveField(3)
//   double? serviceFees;
//
//   @HiveField(4)
//   double? expectedTotalPayment;
//
//   LoanInfoStepResponse(
//       {this.loanProductSelected,
//       this.loanAmount,
//       this.loanDuration,
//       this.expectedTotalPayment,
//       this.serviceFees,
//       this.expectedInterestRate});
//
//   int get serviceFeesFormatted =>
//       serviceFees!.toActualNumberWithinUnit(loanProductSelected!.amountUnit!);
//
//   int get expectedTotalPaymentFormatted => expectedTotalPayment!
//       .toActualNumberWithinUnit(loanProductSelected!.amountUnit!);
//
//   int get loanAmountFormatted =>
//       loanAmount!.toActualNumberWithinUnit(loanProductSelected!.amountUnit!);
//
//   LoanInfoStepResponse.fromJson(Map<String, dynamic> json) {
//     loanProductSelected =
//         LoanProductsResponse.fromJson(json['loanProductSelected']);
//     loanAmount = json['loanAmount'];
//     loanDuration = json['loanDuration'];
//     expectedInterestRate = json['expectedInterestRate'];
//     serviceFees = json['serviceFees'];
//     expectedTotalPayment = json['expectedTotalPayment'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loanProductSelected'] = this.loanProductSelected!.toJson();
//     data['loanAmount'] = this.loanAmount;
//     data['loanDuration'] = this.loanDuration;
//     data['expectedTotalPayment'] = this.expectedTotalPayment;
//     data['expectedInterestRate'] = this.expectedInterestRate;
//     data['serviceFees'] = this.serviceFees;
//     return data;
//   }
// }
