import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';

part 'linked_payment_loan_detail_response.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.linkedPaymentLoanDetailResponse)
class LinkedPaymentLoanDetailResponse extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? serviceName;

  @HiveField(2)
  String? accountId;

  @HiveField(3)
  String? accountName;

  LinkedPaymentLoanDetailResponse(
      {this.id, this.serviceName, this.accountId, this.accountName});

  LinkedPaymentLoanDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    accountId = json['accountId'];
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['accountId'] = this.accountId;
    data['accountName'] = this.accountName;
    return data;
  }
}
