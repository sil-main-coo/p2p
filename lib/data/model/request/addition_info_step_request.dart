class AdditionInfoStepRequest {
  int? loanProductAdditionalInfoId;
  String? value;

  AdditionInfoStepRequest({this.loanProductAdditionalInfoId, this.value});

  AdditionInfoStepRequest.fromJson(Map<String, dynamic> json) {
    loanProductAdditionalInfoId = json['loanProductAdditionalInfoId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanProductAdditionalInfoId'] = this.loanProductAdditionalInfoId;
    data['value'] = this.value;
    return data;
  }
}