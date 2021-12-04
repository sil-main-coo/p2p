class VerifyOtpResponse {
  String? phone;
  String? deviceId;
  String? otp;
  DateTime? otpExpiredDate;
  int? retryTimes;
  String? verifyToken;
  DateTime? verificationExpired;
  bool? isSuccess;
  String? message;
  String? messageCode;
  String? verifiedCode;
  DateTime? lockExpired;

  VerifyOtpResponse(
      {this.phone,
      this.deviceId,
      this.otp,
      this.otpExpiredDate,
      this.retryTimes,
      this.verifyToken,
      this.verificationExpired,
      this.isSuccess,
      this.message,
      this.messageCode});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    deviceId = json['deviceId'];
    otp = json['otp'];
    if (json['otpExpiredDate'] != null)
      otpExpiredDate =
          DateTime.fromMillisecondsSinceEpoch(json['otpExpiredDate'] * 1000);
    retryTimes = json['retryTimes'];
    verifyToken = json['verifyToken'];
    if (json['verificationExpired'] != null)
      verificationExpired = DateTime.fromMillisecondsSinceEpoch(
          json['verificationExpired'] * 1000);
    print(verificationExpired.toString());
    isSuccess = json['isSuccess'];
    message = json['message'];
    messageCode = json['messageCode'];
    verifiedCode = json['verifiedCode'];
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
    data['verificationExpired'] =
        this.verificationExpired!.millisecondsSinceEpoch;
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['messageCode'] = this.messageCode;
    data['verifiedCode'] = this.verifiedCode;
    data['lockExpired'] = this.lockExpired!.millisecondsSinceEpoch;
    return data;
  }
}
