class PaymentServiceResponse {
  int? id;
  String? name;
  String? fullName;
  String? type;
  String? icon;
  String? iconPath;
  int? iconLastModifiedDate;

  PaymentServiceResponse(
      {this.id,
      this.name,
      this.fullName,
      this.type,
      this.icon,
      this.iconPath,
      this.iconLastModifiedDate});

  PaymentServiceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['fullName'];
    type = json['type'];
    icon = json['icon'];
    iconPath = json['iconPath'];
    iconLastModifiedDate = json['iconLastModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fullName'] = this.fullName;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['iconPath'] = this.iconPath;
    data['iconLastModifiedDate'] = this.iconLastModifiedDate;
    return data;
  }
}
