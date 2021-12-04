class MultiSignInMessageResponse {
  DateTime? loginTime;
  String? previousDeviceId;
  String? loginDeviceId;

  MultiSignInMessageResponse(
      {this.loginTime, this.previousDeviceId, this.loginDeviceId});

  MultiSignInMessageResponse.fromJson(Map<String, dynamic> json) {
    if (json['LoginTime'] != null)
      loginTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['LoginTime']) * 1000);
    previousDeviceId = json['PreviousDeviceId'];
    loginDeviceId = json['LoginDeviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginTime'] =
        (this.loginTime!.millisecondsSinceEpoch ~/ 1000).toString();
    data['PreviousDeviceId'] = this.previousDeviceId;
    data['LoginDeviceId'] = this.loginDeviceId;
    return data;
  }
}
