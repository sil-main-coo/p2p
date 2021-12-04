import 'package:p2p_borrower/common/constants/type_payment_enum.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'loan_detail/linked_payment_loan_detail_response.dart';

class LinkedPaymentResponse {
  int? id;
  int? accountId;
  int? serviceId;
  String? serviceName;
  String? serviceAccountName;
  String? serviceAccountId;
  String? phone;
  String? type;
  String? icon;
  String? iconPath;
  int? iconLastModifiedDate;

  LinkedPaymentLoanDetailResponse toLinkedPaymentDetailLoan() {
    return LinkedPaymentLoanDetailResponse(
        id: id,
        accountId: serviceAccountId,
        accountName: serviceAccountName,
        serviceName: serviceName);
  }

  String? get getFourLastNumberAccount {
    int startIndex;

    if (type == TypePaymentEnum.Bank.toString().enumToName &&
        serviceAccountId != null) {
      startIndex = serviceAccountId!.length - 4;
      return serviceAccountId!.substring(startIndex);
    } else if (type == TypePaymentEnum.VirtualWallet.toString().enumToName &&
        phone != null) {
      startIndex = phone!.length - 5;
      return phone!.substring(startIndex);
    }
  }

  LinkedPaymentResponse(
      {this.id,
      this.accountId,
      this.serviceId,
      this.serviceName,
      this.serviceAccountName,
      this.serviceAccountId,
      this.phone,
      this.type,
      this.icon,
      this.iconPath,
      this.iconLastModifiedDate});

  LinkedPaymentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    serviceAccountName = json['serviceAccountName'];
    serviceAccountId = json['serviceAccountId'];
    phone = json['phone'];
    type = json['type'];
    icon = json['icon'];
    iconPath = json['iconPath'];
    iconLastModifiedDate = json['iconLastModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.accountId;
    data['accountId'] = this.accountId;
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['serviceAccountName'] = this.serviceAccountName;
    data['serviceAccountId'] = this.serviceAccountId;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['iconPath'] = this.iconPath;
    data['iconLastModifiedDate'] = this.iconLastModifiedDate;
    return data;
  }
}
