class ForgotPwdRequest {
  String? phone;
  String? deviceId;
  String? verifiedCode;
  String? newPassword;

  ForgotPwdRequest(
      {this.phone, this.deviceId, this.verifiedCode, this.newPassword});

  ForgotPwdRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    verifiedCode = json['verifiedCode'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['deviceId'] = this.deviceId;
    data['verifiedCode'] = this.verifiedCode;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
