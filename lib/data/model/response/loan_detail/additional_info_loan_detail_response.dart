import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/constants/type_format_field_enum.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/request/addition_info_step_request.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

part 'additional_info_loan_detail_response.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.additionalInfoLoanDetailResponse)
class AdditionalInfoLoanDetailResponse {
  @HiveField(0)
  int? loanProductAdditionalInfoId;

  @HiveField(1)
  String? infoName;

  @HiveField(2)
  String? infoFormat;

  @HiveField(3)
  String? value;

  @HiveField(4)
  String? binaryValue;

  AdditionalInfoLoanDetailResponse(
      {this.loanProductAdditionalInfoId,
      this.infoName,
      this.infoFormat,
      this.value,
      this.binaryValue});

  TypeFormatFieldEnum? get infoFormatEnum {
    if (infoFormat == TypeFormatFieldEnum.Text.toString().enumToName) {
      return TypeFormatFieldEnum.Text;
    }
    if (infoFormat == TypeFormatFieldEnum.Media.toString().enumToName) {
      return TypeFormatFieldEnum.Media;
    }
    return null;
  }

  AdditionInfoStepRequest toRequestData() {
    return AdditionInfoStepRequest(
        value: value, loanProductAdditionalInfoId: loanProductAdditionalInfoId);
  }

  AdditionalInfoLoanDetailResponse.fromJson(Map<String, dynamic> json) {
    loanProductAdditionalInfoId = json['loanProductAdditionalInfoId'];
    infoName = json['infoName'];
    infoFormat = json['infoFormat'];
    value = json['value'];
    binaryValue = json['binaryValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanProductAdditionalInfoId'] = this.loanProductAdditionalInfoId;
    data['infoName'] = this.infoName;
    data['infoFormat'] = this.infoFormat;
    data['value'] = this.value;
    data['binaryValue'] = this.binaryValue;
    return data;
  }
}
