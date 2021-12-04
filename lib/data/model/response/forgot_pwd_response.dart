class ForgotPwdResponse {
  bool? isSuccess;
  String? message;
  String? messageCode;

  ForgotPwdResponse({this.isSuccess, this.message, this.messageCode});

  ForgotPwdResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    messageCode = json['messageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['messageCode'] = this.messageCode;
    return data;
  }
}
