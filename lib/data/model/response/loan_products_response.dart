import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/constants/type_format_field_enum.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/common/extensions/app_string_extension.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:p2p_borrower/common/extensions/app_num_extension.dart';

part 'loan_products_response.g.dart';

@HiveType(typeId: HiveMasterLoanDataConstants.loanProductsResponseType)
class LoanProductsResponse extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? typeCode;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? description;

  @HiveField(4)
  int? minimumAmount;

  @HiveField(5)
  int? maximumAmount;

  @HiveField(6)
  String? amountUnit;

  @HiveField(7)
  int? minimumDuration;

  @HiveField(8)
  int? maximumDuration;

  @HiveField(9)
  String? durationUnit;

  @HiveField(10)
  List<AdditionalInfos>? additionalInfos;

  @HiveField(11)
  String? icon;

  @HiveField(12)
  String? iconPath;

  @HiveField(13)
  DateTime? iconLastModifiedDate;

  String get durationUnitTranslated => durationUnit!.translate;

  String get amountUnitTranslated => amountUnit!.translate;

  double get getStepOfAmountSlider =>
      durationUnit!.getStepOfSliderWithDurationUnit();

  LoanProductsResponse(
      {this.id,
      this.typeCode,
      this.name,
      this.description,
      this.minimumAmount,
      this.maximumAmount,
      this.amountUnit,
      this.minimumDuration,
      this.maximumDuration,
      this.icon,
      this.iconPath,
      this.iconLastModifiedDate,
      this.durationUnit,
      this.additionalInfos});

  String getRangeAmountMoneyString() {
    return '${this.minimumAmount}-${this.maximumAmount} ${this.amountUnit!.translate}';
  }

  int getMinimumAmountActual() {
    return minimumAmount!.toActualNumberWithinUnit(amountUnit!);
  }

  int getMaximumAmountActual() {
    return maximumAmount!.toActualNumberWithinUnit(amountUnit!);
  }

  LoanProductsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeCode = json['typeCode'];
    name = json['name'];
    description = json['description'];
    minimumAmount = json['minimumAmount'];
    maximumAmount = json['maximumAmount'];
    amountUnit = json['amountUnit'];
    minimumDuration = json['minimumDuration'];
    maximumDuration = json['maximumDuration'];
    durationUnit = json['durationUnit'];
    if (json['additionalInfos'] != null) {
      additionalInfos = <AdditionalInfos>[];
      json['additionalInfos'].forEach((v) {
        additionalInfos!.add(AdditionalInfos.fromJson(v));
      });
    }
    icon = json['icon'];
    iconPath = json['iconPath'].toString().replaceAll('.png', '.svg');
    if (json['iconLastModifiedDate'] != null) {
      iconLastModifiedDate = DateTime.fromMillisecondsSinceEpoch(
          json['iconLastModifiedDate'] * 1000);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeCode'] = this.typeCode;
    data['name'] = this.name;
    data['description'] = this.description;
    data['minimumAmount'] = this.minimumAmount;
    data['maximumAmount'] = this.maximumAmount;
    data['amountUnit'] = this.amountUnit;
    data['minimumDuration'] = this.minimumDuration;
    data['maximumDuration'] = this.maximumDuration;
    data['durationUnit'] = this.durationUnit;
    if (this.additionalInfos != null) {
      data['additionalInfos'] =
          this.additionalInfos!.map((v) => v.toJson()).toList();
    }
    data['icon'] = this.icon;
    data['iconPath'] = this.iconPath;
    data['iconLastModifiedDate'] =
        (this.iconLastModifiedDate!.millisecondsSinceEpoch / 1000);
    return data;
  }
}

@HiveType(typeId: HiveMasterLoanDataConstants.additionalInfosType)
class AdditionalInfos extends HiveObject {
  @HiveField(1)
  int? id;

  @HiveField(2)
  int? loanTypeId;

  @HiveField(3)
  String? infoName;

  @HiveField(4)
  String? infoFormat;

  AdditionalInfos({this.id, this.loanTypeId, this.infoName, this.infoFormat});

  TypeFormatFieldEnum? get infoFormatEnum {
    if (infoFormat == TypeFormatFieldEnum.Text.toString().enumToName) {
      return TypeFormatFieldEnum.Text;
    }
    if (infoFormat == TypeFormatFieldEnum.Media.toString().enumToName) {
      return TypeFormatFieldEnum.Media;
    }
    return null;
  }

  AdditionalInfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanTypeId = json['loanTypeId'];
    infoName = json['infoName'];
    infoFormat = json['infoFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loanTypeId'] = this.loanTypeId;
    data['infoName'] = this.infoName;
    data['infoFormat'] = this.infoFormat;
    return data;
  }
}
