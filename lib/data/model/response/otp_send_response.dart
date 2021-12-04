class SendOtpResponse {
  String? phone;
  String? deviceId;
  String? otp;
  DateTime? otpExpiredDate;
  int? retryTimes;
  String? verifyToken;
  String? verificationExpired;
  bool? isSuccess;
  bool? isLock;
  String? message;
  String? messageCode;
  DateTime? lockExpired;

  SendOtpResponse(
      {this.phone,
      this.deviceId,
      this.otp,
      this.otpExpiredDate,
      this.retryTimes,
      this.isLock,
      this.verifyToken,
      this.verificationExpired,
      this.isSuccess,
      this.message,
      this.messageCode});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    otp = json['otp'];
    if (json['otpExpiredDate'] != null)
      otpExpiredDate =
          DateTime.fromMillisecondsSinceEpoch(json['otpExpiredDate'] * 1000);
    retryTimes = json['retryTimes'];
    verifyToken = json['verifyToken'];
    verificationExpired = json['verificationExpired'];
    isSuccess = json['isSuccess'];
    isLock = json['isLock'];
    message = json['message'];
    messageCode = json['messageCode'];
    if (json['lockExpired'] != null)
      lockExpired =
          DateTime.fromMillisecondsSinceEpoch(json['lockExpired'] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['deviceId'] = this.deviceId;
    data['otp'] = this.otp;
    data['otpExpiredDate'] = this.otpExpiredDate!.millisecondsSinceEpoch;
    data['retryTimes'] = this.retryTimes;
    data['verifyToken'] = this.verifyToken;
    data['verificationExpired'] = this.verificationExpired;
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['isLock'] = this.isLock;
    data['messageCode'] = this.messageCode;
    data['lockExpired'] = this.lockExpired!.millisecondsSinceEpoch;
    return data;
  }
}
