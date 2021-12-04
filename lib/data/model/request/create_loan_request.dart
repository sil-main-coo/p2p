import 'package:p2p_borrower/common/constants/sex_enums.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/additional_info_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/data/model/request/addition_info_step_request.dart';
import 'package:p2p_borrower/data/model/request/occupation_info_request.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';
import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
import 'address_request.dart';
import 'relative_person_request.dart';

class CreateLoanRequest {
  int? id;
  String? phone;
  String? purposeLoan;
  String? loanDurationTranslated;
  String? _icon, _iconPath;
  String? status;

  int? loanProductId;
  int? loanAmount;
  int? loanDuration;
  int? linkedPaymentId;
  double? expectedInterestRate;
  int? serviceFees;
  int? expectedTotalPayment;
  CreateLoanProfileRequest? profile;
  RelativePersonRequest? relativePerson1;
  RelativePersonRequest? relativePerson2;
  AddressRequest? residentAddress;
  AddressRequest? currentAddress;
  String? ownedType;
  int? maritalStatusId;
  OccupationInfoStepRequest? occupation;

  String? idCardWithUserImage;
  String? idCardFrontImage;
  String? idCardBackImage;

  List<AdditionInfoStepRequest>? additionalInfos;

  DateTime get dateLoan => DateTime.now();

  String get dateLoanStringFormatted => dateLoan.toStringDefault;

  String get loanAmountStringFormatted =>
      '${loanAmount!.toDefaultFormatNumberString}${S.current.money_currency}';

  String get serviceFeesStringFormatted =>
      '${serviceFees!.toDefaultFormatNumberString}${S.current.money_currency}';

  String get expectedTotalPaymentStringFormatted =>
      '${expectedTotalPayment!.toDefaultFormatNumberString}${S.current.money_currency}';

  String get expectedInterestRateStringFormatted =>
      '$expectedInterestRate%/${S.current.year.toLowerCase()}';

  get icon => _icon;

  get iconPath => _iconPath;

  void setAdditionalInfo(
      List<AdditionalInfoLoanDetailResponse> additionalList) {
    if (additionalInfos == null) {
      additionalInfos = [];
    }
    additionalList.forEach((element) {
      additionalInfos!.add(element.toRequestData());
    });
  }

  void setIDImages(String? idCardFrontImage, String? idCardBackImage,
      String? idCardWithUserImage) {
    this.idCardWithUserImage = idCardWithUserImage;
    this.idCardFrontImage = idCardFrontImage;
    this.idCardBackImage = idCardBackImage;
  }

  void setPersonalInfo(LoanApplicationDetailResponse loanDetail) {
    this.profile = loanDetail.profile!.toRequestProfile();
    this.relativePerson1 = loanDetail.relativePerson1;
    this.relativePerson2 = loanDetail.relativePerson2;
    this.residentAddress = loanDetail.residentAddress;
    this.currentAddress = loanDetail.currentAddress;
    this.ownedType = loanDetail.ownedType;
    this.maritalStatusId = loanDetail.maritalStatusId;
  }

  void setLoanInfo(int productId, LoanApplicationResponse simpleLoan,
      {String? icon, String? iconPath}) {
    this.loanProductId = productId;
    this.loanAmount = simpleLoan.loanAmountActual;
    this.loanDuration = simpleLoan.loanDuration;
    this.serviceFees = simpleLoan.serviceFeesActual;
    this.expectedInterestRate = simpleLoan.interestRate!;
    this.expectedTotalPayment = simpleLoan.expectedTotalPaymentActual;
    this.purposeLoan = simpleLoan.loanProduct;
    this.loanDurationTranslated = simpleLoan.durationUnitTranslated;
    this._icon = icon;
    this._iconPath = iconPath;
  }

  void setIdCardImages(String idCardWithUserImage, String idCardFrontImage,
      String idCardBackImage) {
    this.idCardWithUserImage = idCardWithUserImage;
    this.idCardFrontImage = idCardFrontImage;
    this.idCardBackImage = idCardBackImage;
  }

  CreateLoanRequest(
      {this.phone,
        this.id = 0,
      this.loanProductId,
      this.loanAmount,
      this.loanDuration,
      this.linkedPaymentId,
      this.expectedInterestRate,
      this.serviceFees,
      this.relativePerson1,
      this.relativePerson2,
      this.expectedTotalPayment,
      this.profile,
      this.residentAddress,
      this.currentAddress,
      this.occupation,
      this.ownedType,
      this.maritalStatusId,
      this.idCardWithUserImage,
      this.idCardFrontImage,
      this.idCardBackImage,
      this.additionalInfos});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanProductId'] = this.loanProductId;
    data['loanAmount'] = this.loanAmount;
    data['loanDuration'] = this.loanDuration;
    data['linkedPaymentId'] = this.linkedPaymentId;
    data['expectedInterestRate'] = this.expectedInterestRate;
    data['serviceFees'] = this.serviceFees;
    if (this.relativePerson1 != null) {
      data['relativePerson1'] = this.relativePerson1!.toJson();
    }
    if (this.relativePerson2 != null) {
      data['relativePerson2'] = this.relativePerson2!.toJson();
    }
    data['expectedTotalPayment'] = this.expectedTotalPayment;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.residentAddress != null) {
      data['residentAddress'] = this.residentAddress!.toJson();
    }
    if (this.currentAddress != null) {
      data['currentAddress'] = this.currentAddress!.toJson();
    }
    if (this.occupation != null) {
      data['occupation'] = this.occupation!.toJson();
    }
    data['ownedType'] = this.ownedType;
    data['maritalStatusId'] = this.maritalStatusId;
    data['idCardWithUserImage'] = this.idCardWithUserImage;
    data['idCardFrontImage'] = this.idCardFrontImage;
    data['idCardBackImage'] = this.idCardBackImage;
    if (this.additionalInfos != null) {
      data['additionalInfos'] =
          this.additionalInfos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateLoanProfileRequest {
  String? fullName;
  String? gender;
  int? dateOfBirth;
  String? idCardNumber;
  String? idCardIssuedBy;
  int? idCardIssuedDate;

  DateTime? get dateOfBirthDateTime => dateOfBirth != null
      ? DateTime.fromMillisecondsSinceEpoch(dateOfBirth! * 1000)
      : null;

  DateTime? get idCardIssuedDateTime => idCardIssuedDate != null
      ? DateTime.fromMillisecondsSinceEpoch(idCardIssuedDate! * 1000)
      : null;

  CreateLoanProfileRequest(
      {this.fullName,
      this.gender,
      this.dateOfBirth,
      this.idCardNumber,
      this.idCardIssuedBy,
      this.idCardIssuedDate});

  CreateLoanProfileRequest.initial() {
    gender = SexEnum.values[0].toString().enumToName;
  }

  CreateLoanProfileRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    idCardNumber = json['idCardNumber'];
    idCardIssuedBy = json['idCardIssuedBy'];
    idCardIssuedDate = json['idCardIssuedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['idCardNumber'] = this.idCardNumber;
    data['idCardIssuedBy'] = this.idCardIssuedBy;
    data['idCardIssuedDate'] = this.idCardIssuedDate;
    return data;
  }
}
