class SignUpRequest {
  String? phone;
  String? deviceId;
  String? password;
  String? verifiedCode;

  SignUpRequest({this.phone, this.deviceId, this.password, this.verifiedCode});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    password = json['password'];
    verifiedCode = json['verifiedCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['deviceId'] = this.deviceId;
    data['password'] = this.password;
    data['verifiedCode'] = this.verifiedCode;
    return data;
  }
}
