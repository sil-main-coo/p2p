class SignInRequest {
  String? phone;
  String? password;
  String? deviceId;
  String? deviceName;
  String? fcmToken;

  SignInRequest(
      {this.phone,
      this.password,
      this.deviceId,
      this.deviceName,
      this.fcmToken});

  SignInRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}
