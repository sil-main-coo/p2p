class BaseResponse {
  int? statusCode;
  String? message;
  String? messageCode;
  String? innerException;
  bool? isSuccess;

  BaseResponse(
      {this.statusCode,
      this.message,
      this.messageCode,
      this.innerException,
      this.isSuccess});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'] ??  json['message'];
    messageCode = json['MessageCode'] ?? json['messageCode'];
    innerException = json['InnerException'];
    isSuccess = json['IsSuccess'] ?? json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    data['MessageCode'] = this.messageCode;
    data['InnerException'] = this.innerException;
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}
