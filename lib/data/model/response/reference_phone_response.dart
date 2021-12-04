class ReferencePhoneResponse {
  bool? isSuccess;
  String? message;
  String? messageCode;

  ReferencePhoneResponse({this.isSuccess, this.message, this.messageCode});

  ReferencePhoneResponse.fromJson(Map<String, dynamic> json) {
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
