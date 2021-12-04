class ReferencePhoneRequest {
  String? refererPhone;

  ReferencePhoneRequest({this.refererPhone});

  ReferencePhoneRequest.fromJson(Map<String, dynamic> json) {
    refererPhone = json['refererPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refererPhone'] = this.refererPhone;
    return data;
  }
}
