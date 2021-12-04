class VerifyOTPRequest {
  String? phone;
  String? deviceId;
  String? value;
  String? verificationType;

  VerifyOTPRequest(
      {this.phone, this.deviceId, this.value, this.verificationType});

  VerifyOTPRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    value = json['value'];
    verificationType = json['verificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['deviceId'] = this.deviceId;
    data['value'] = this.value;
    data['verificationType'] = this.verificationType;
    return data;
  }
}
