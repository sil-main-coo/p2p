class PhoneVerifyResponse {
  bool? isBorrowerExist;
  bool? isInvestorExist;
  bool? isOTPLock;
  bool? isCorrectPhoneNumberFormat;
  DateTime? lockExpired;

  PhoneVerifyResponse(
      {this.isBorrowerExist, this.isInvestorExist, this.isOTPLock});

  PhoneVerifyResponse.fromJson(Map<String, dynamic> json) {
    isBorrowerExist = json['isBorrowerExist'];
    isInvestorExist = json['isInvestorExist'];
    isCorrectPhoneNumberFormat = json['isCorrectPhoneNumberFormat'];
    isOTPLock = json['isOTPLock'];
    if (json['lockExpired'] != null && json['lockExpired'] != 0)
      lockExpired =
          DateTime.fromMillisecondsSinceEpoch(json['lockExpired'] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isBorrowerExist'] = this.isBorrowerExist;
    data['isInvestorExist'] = this.isInvestorExist;
    data['isCorrectPhoneNumberFormat'] = this.isCorrectPhoneNumberFormat;
    data['isOTPLock'] = this.isOTPLock;
    data['lockExpired'] = this.lockExpired;
    return data;
  }
}
