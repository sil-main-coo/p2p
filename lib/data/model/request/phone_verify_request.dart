import 'package:p2p_borrower/common/constants/verify_constants.dart';

class PhoneVerifyRequest {
  String? phone;
  String? deviceId;
  String? deviceName;
  String? verificationType;

  PhoneVerifyRequest(
      {this.phone, this.deviceId, this.deviceName, this.verificationType});

  PhoneVerifyRequest.signIn(
      {this.phone, this.deviceId, this.deviceName}){
    this.verificationType = VerifyConstants.SignIn;
  }

  PhoneVerifyRequest.registration(
      {this.phone, this.deviceId, this.deviceName}){
    this.verificationType = VerifyConstants.Registration;
  }

  PhoneVerifyRequest.createLoan(
      {this.phone, this.deviceId, this.deviceName}){
    this.verificationType = VerifyConstants.CreateLoan;
  }

  PhoneVerifyRequest.fromJson(Map<String, dynamic> json) {
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
