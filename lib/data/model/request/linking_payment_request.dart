class LinkingPaymentRequest {
  int? linkedPaymentId;
  int? serviceId;
  String? serviceAccountId;
  String? serviceAccountName;
  String? phone;

  LinkingPaymentRequest(
      {this.linkedPaymentId,
        this.serviceId,
        this.serviceAccountId = '',
        this.serviceAccountName,
        this.phone = ''});

  LinkingPaymentRequest.fromJson(Map<String, dynamic> json) {
    linkedPaymentId = json['linkedPaymentId'];
    serviceId = json['serviceId'];
    serviceAccountId = json['serviceAccountId'];
    serviceAccountName = json['serviceAccountName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['linkedPaymentId'] = this.linkedPaymentId;
    data['serviceId'] = this.serviceId;
    data['serviceAccountId'] = this.serviceAccountId;
    data['serviceAccountName'] = this.serviceAccountName;
    data['phone'] = this.phone;
    return data;
  }
}
