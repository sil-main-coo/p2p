import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/request/address_request.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/data/model/request/occupation_info_request.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/model/personal_info_step_response.dart';

import '../loan_application_response.dart';
import '../loan_products_response.dart';
import 'additional_info_loan_detail_response.dart';
import 'linked_payment_loan_detail_response.dart';
import 'profile_loan_detail_response.dart';

part 'loan_application_detail_response.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.loanDetailResponse)
class LoanApplicationDetailResponse extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? loanProductId;

  @HiveField(2)
  String? loanProduct;

  @HiveField(3)
  int? interestRate;

  @HiveField(4)
  int? fees;

  @HiveField(5)
  LinkedPaymentLoanDetailResponse? linkedPayment;

  @HiveField(6)
  OccupationInfoStepRequest? occupation;

  @HiveField(7)
  RelativePersonRequest? relativePerson1;

  @HiveField(8)
  RelativePersonRequest? relativePerson2;

  @HiveField(9)
  ProfileLoanDetailResponse? profile;

  @HiveField(10)
  AddressRequest? residentAddress;

  @HiveField(11)
  AddressRequest? currentAddress;

  @HiveField(12)
  List<AdditionalInfoLoanDetailResponse>? additionalInfos;

  @HiveField(13)
  String? ownedType;

  @HiveField(14)
  int? maritalStatusId;

  @HiveField(15)
  String? maritalStatus;

  @HiveField(16)
  String? idCardWithUserImage;

  @HiveField(17)
  String? idCardFrontImage;

  @HiveField(18)
  String? idCardBackImage;

  List<ValidateAttribute>? invalidateDatas;

  LoanApplicationDetailResponse.copy(LoanApplicationDetailResponse? model) {
    if (model != null) {
      this.id = model.id;
      this.loanProductId = model.loanProductId;
      this.loanProduct = model.loanProduct;
      this.interestRate = model.interestRate;
      this.fees = model.fees;
      this.linkedPayment = model.linkedPayment;
      this.occupation = model.occupation;
      this.relativePerson1 = model.relativePerson1;
      this.relativePerson2 = model.relativePerson2;
      this.profile = model.profile;
      this.residentAddress = model.residentAddress;
      this.currentAddress = model.currentAddress;
      this.additionalInfos = model.additionalInfos;
      this.ownedType = model.ownedType;
      this.maritalStatusId = model.maritalStatusId;
      this.maritalStatus = model.maritalStatus;
      this.idCardWithUserImage = model.idCardWithUserImage;
      this.idCardFrontImage = model.idCardFrontImage;
      this.idCardBackImage = model.idCardBackImage;
      this.invalidateDatas = model.invalidateDatas;
    }
  }

  void setParams(LoanApplicationDetailResponse? model) {
    if (model != null) {
      this.id = model.id;
      this.loanProductId = model.loanProductId;
      this.loanProduct = model.loanProduct;
      this.interestRate = model.interestRate;
      this.fees = model.fees;
      this.linkedPayment = model.linkedPayment;
      this.occupation = model.occupation;
      this.relativePerson1 = model.relativePerson1;
      this.relativePerson2 = model.relativePerson2;
      this.profile = model.profile;
      this.residentAddress = model.residentAddress;
      this.currentAddress = model.currentAddress;
      this.additionalInfos = model.additionalInfos;
      this.ownedType = model.ownedType;
      this.maritalStatusId = model.maritalStatusId;
      this.maritalStatus = model.maritalStatus;
      this.idCardWithUserImage = model.idCardWithUserImage;
      this.idCardFrontImage = model.idCardFrontImage;
      this.idCardBackImage = model.idCardBackImage;
      this.invalidateDatas = model.invalidateDatas;
    }
  }

  void fromLoanProduct(LoanProductsResponse product) {
    this.loanProductId = product.id;
  }

  void setIDImages(String? idCardFrontImage, String? idCardBackImage,
      String? idCardWithUserImage) {
    this.idCardWithUserImage = idCardWithUserImage;
    this.idCardFrontImage = idCardFrontImage;
    this.idCardBackImage = idCardBackImage;
  }

  void setPersonInfo(PersonalInfoStepModel infoStepModel) {
    this.profile = infoStepModel.profile;
    this.relativePerson1 = infoStepModel.relativePerson1;
    this.relativePerson2 = infoStepModel.relativePerson2;
    this.residentAddress = infoStepModel.residentAddress!.toAddressRequest();
    this.currentAddress = infoStepModel.currentAddress!.toAddressRequest();
    this.ownedType = infoStepModel.ownerShipType!.name;
    this.maritalStatusId = infoStepModel.maritalStatus!.id;
  }

  LoanApplicationDetailResponse(
      {this.id,
      this.loanProductId,
      this.loanProduct,
      this.interestRate,
      this.fees,
      this.linkedPayment,
      this.occupation,
      this.relativePerson1,
      this.relativePerson2,
      this.profile,
      this.residentAddress,
      this.currentAddress,
      this.additionalInfos,
      this.ownedType,
      this.maritalStatusId,
      this.maritalStatus,
      this.idCardWithUserImage,
      this.idCardFrontImage,
      this.idCardBackImage,
      this.invalidateDatas});

  LoanApplicationDetailResponse.fromJson(Map<String, dynamic> json,
      {LoanApplicationResponse? loanApplicationSimple}) {
    id = json['id'];
    loanProductId = json['loanProductId'];
    loanProduct = json['loanProduct'];
    interestRate = json['interestRate'];
    fees = json['fees'];
    linkedPayment = json['linkedPayment'] != null
        ? new LinkedPaymentLoanDetailResponse.fromJson(json['linkedPayment'])
        : null;
    occupation = json['occupation'] != null
        ? new OccupationInfoStepRequest.fromJson(json['occupation'])
        : null;
    relativePerson1 = json['relativePerson1'] != null
        ? new RelativePersonRequest.fromJson(json['relativePerson1'])
        : null;
    relativePerson2 = json['relativePerson2'] != null
        ? new RelativePersonRequest.fromJson(json['relativePerson2'])
        : null;
    profile = json['profile'] != null
        ? new ProfileLoanDetailResponse.fromJson(json['profile'])
        : null;
    if (json['residentAddress'] != null) {
      residentAddress = AddressRequest.fromJson(json['residentAddress']);
    }

    if (json['currentAddress'] != null) {
      currentAddress = AddressRequest.fromJson(json['currentAddress']);
    }

    if (json['additionalInfos'] != null) {
      additionalInfos = [];
      json['additionalInfos'].forEach((v) {
        additionalInfos!.add(new AdditionalInfoLoanDetailResponse.fromJson(v));
      });
    }
    ownedType = json['ownedType'];
    maritalStatusId = json['maritalStatusId'];
    maritalStatus = json['maritalStatus'];
    idCardWithUserImage = json['idCardWithUserImage'];
    idCardFrontImage = json['idCardFrontImage'];
    idCardBackImage = json['idCardBackImage'];

    if (json['invalidateDatas'] != null) {
      invalidateDatas = [];
      json['invalidateDatas'].forEach((v) {
        invalidateDatas!.add(new ValidateAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loanProductId'] = this.loanProductId;
    data['loanProduct'] = this.loanProduct;
    data['interestRate'] = this.interestRate;
    data['fees'] = this.fees;
    if (this.linkedPayment != null) {
      data['linkedPayment'] = this.linkedPayment!.toJson();
    }
    if (this.occupation != null) {
      data['occupation'] = this.occupation!.toJson();
    }
    if (this.relativePerson1 != null) {
      data['relativePerson1'] = this.relativePerson1!.toJson();
    }
    if (this.relativePerson2 != null) {
      data['relativePerson2'] = this.relativePerson2!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['residentAddress'] = this.residentAddress;
    data['currentAddress'] = this.currentAddress;
    if (this.additionalInfos != null) {
      data['additionalInfos'] =
          this.additionalInfos!.map((v) => v.toJson()).toList();
    }
    data['ownedType'] = this.ownedType;
    data['maritalStatusId'] = this.maritalStatusId;
    data['maritalStatus'] = this.maritalStatus;
    data['idCardWithUserImage'] = this.idCardWithUserImage;
    data['idCardFrontImage'] = this.idCardFrontImage;
    data['idCardBackImage'] = this.idCardBackImage;
    data['invalidateDatas'] = this.invalidateDatas;
    return data;
  }
}
