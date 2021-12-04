class SendOtpRequest {
  String? phone;
  String? deviceId;
  String? deviceName;
  String? verificationType;

  SendOtpRequest(
      {this.phone, this.deviceId, this.deviceName, this.verificationType});

  SendOtpRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    verificationType = json['verificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['verificationType'] = this.verificationType;
    return data;
  }
}
