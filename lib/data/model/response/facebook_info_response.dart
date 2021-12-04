import 'dart:convert';
import 'dart:typed_data';

import 'package:p2p_borrower/data/model/response/base_response.dart';

class FacebookInfoResponse extends BaseResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  String? picture;
  String? link;
  String? token;

  Uint8List? get pictureUInt8List =>
      (picture == null) ? null : base64Decode(picture!);

  FacebookInfoResponse(
      {this.id,
      this.token,
      this.firstName,
      this.lastName,
      this.name,
      this.email,
      this.picture,
      this.link});

  FacebookInfoResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    email = json['email'];
    picture = json['picture'];
    link = json['link'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['link'] = this.link;
    data['token'] = this.token;
    return data;
  }
}
