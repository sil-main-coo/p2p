class ValidateAttribute {
  int? id;
  int? loanApplicationId;
  String? attributeName;
  String? tableName;
  String? columnName;
  int? referenceId;
  bool? isValidate;
  String? reason;

  String? get errorText => (isValidate != null && !isValidate!) ? reason : null;

  void setValidValue() {
    isValidate = true;
    reason = null;
  }

  ValidateAttribute(
      {this.id,
      this.loanApplicationId,
      this.attributeName,
      this.tableName,
      this.columnName,
      this.referenceId,
      this.isValidate,
      this.reason});

  ValidateAttribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanApplicationId = json['loanApplicationId'];
    attributeName = json['attributeName'];
    tableName = json['tableName'];
    columnName = json['columnName'];
    referenceId = json['referenceId'];
    isValidate = json['isValidate'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loanApplicationId'] = this.loanApplicationId;
    data['attributeName'] = this.attributeName;
    data['tableName'] = this.tableName;
    data['columnName'] = this.columnName;
    data['referenceId'] = this.referenceId;
    data['isValidate'] = this.isValidate;
    data['reason'] = this.reason;
    return data;
  }
}
