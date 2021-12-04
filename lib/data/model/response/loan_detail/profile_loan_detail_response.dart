import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:p2p_borrower/common/constants/sex_enums.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

part 'profile_loan_detail_response.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.profileLoanDetailResponse)
class ProfileLoanDetailResponse extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? phone;

  @HiveField(2)
  String? facebook;

  @HiveField(3)
  String? fullName;

  @HiveField(4)
  String? gender;

  @HiveField(5)
  var dateOfBirth;

  @HiveField(6)
  String? idCardNumber;

  @HiveField(7)
  String? idCardIssuedBy;

  @HiveField(8)
  var idCardIssuedDate;

  ProfileLoanDetailResponse(
      {this.idCardIssuedBy,
      this.id,
      this.phone,
      this.fullName,
      this.idCardNumber,
      this.dateOfBirth,
      this.idCardIssuedDate,
      this.gender,
      this.facebook});

  DateTime? get dateOfBirthDateTime {
    if (dateOfBirth != null) {
      if (dateOfBirth is String)
        return DateFormat(DateTimeFormatConstants.iso8601WithMillisecondsOnly)
            .parse(dateOfBirth!);
      if (dateOfBirth is int)
        return DateTime.fromMillisecondsSinceEpoch(dateOfBirth * 1000);
    }
    return null;
  }

  DateTime? get idCardIssuedDateTime {
    if (idCardIssuedDate != null) {
      if (idCardIssuedDate is String)
        return DateFormat(DateTimeFormatConstants.iso8601WithMillisecondsOnly)
            .parse(idCardIssuedDate!);
      if (idCardIssuedDate is int)
        return DateTime.fromMillisecondsSinceEpoch(idCardIssuedDate * 1000);
    }
    return null;
  }

  ProfileLoanDetailResponse.initial() {
    gender = SexEnum.F.toString().enumToName;
  }

  CreateLoanProfileRequest toRequestProfile() {
    return CreateLoanProfileRequest(
        idCardIssuedBy: this.idCardIssuedBy,
        idCardIssuedDate: idCardIssuedDateTime != null
            ? idCardIssuedDateTime!.millisecondsSinceEpoch ~/ 1000
            : null,
        idCardNumber: this.idCardNumber,
        dateOfBirth: dateOfBirthDateTime != null
            ? dateOfBirthDateTime!.millisecondsSinceEpoch ~/ 1000
            : null,
        gender: this.gender,
        fullName: this.fullName);
  }

  ProfileLoanDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    facebook = json['facebook'];
    fullName = json['fullName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    idCardNumber = json['idCardNumber'];
    idCardIssuedBy = json['idCardIssuedBy'];
    idCardIssuedDate = json['idCardIssuedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['facebook'] = this.facebook;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['idCardNumber'] = this.idCardNumber;
    data['idCardIssuedBy'] = this.idCardIssuedBy;
    data['idCardIssuedDate'] = this.idCardIssuedDate;
    return data;
  }
}
