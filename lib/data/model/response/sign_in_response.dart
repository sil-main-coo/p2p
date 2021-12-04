import 'base_response.dart';

class SignInResponse extends BaseResponse {
  AuthenticationToken? authenticationToken;
  User? user;

  SignInResponse({this.authenticationToken, this.user});

  SignInResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    authenticationToken = json['authenticationToken'] != null
        ? new AuthenticationToken.fromJson(json['authenticationToken'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authenticationToken != null) {
      data['authenticationToken'] = this.authenticationToken!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class AuthenticationToken {
  AccessToken? accessToken;
  AccessToken? refreshToken;
  String? fcmToken;

  AuthenticationToken({this.accessToken, this.refreshToken, this.fcmToken});

  AuthenticationToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'] != null
        ? new AccessToken.fromJson(json['accessToken'])
        : null;
    refreshToken = json['refreshToken'] != null
        ? new AccessToken.fromJson(json['refreshToken'])
        : null;
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accessToken != null) {
      data['accessToken'] = this.accessToken!.toJson();
    }
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
    }
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}

class AccessToken {
  String? token;
  DateTime? expiry;

  AccessToken({this.token, this.expiry});

  AccessToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    if (json['expiry'] != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(json['expiry'] * 1000);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiry'] = this.expiry!.millisecondsSinceEpoch;
    return data;
  }
}

class User {
  int? accountId;
  String? phone;
  String? name;
  String? avatar;
  String? role;

  User({this.accountId, this.phone, this.name, this.avatar, this.role});

  User.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    phone = json['phone'];
    name = json['name'];
    avatar = json['avatar'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    return data;
  }
}
