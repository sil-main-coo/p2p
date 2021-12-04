import 'package:p2p_borrower/data/model/request/occupation_info_request.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';


class OccupationInfoStepResponse {
  OccupationResponse? occupation;
  OccupationPositionResponse? occupationPosition;
  AddressSelected? occupationAddress;
  String? workplaceName;
  int? monthlyIncome;
  String? workplacePhone;
  Map<String, ValidateAttribute>? profileValidAttribute;

  OccupationInfoStepResponse(
      {this.occupation,
      this.occupationPosition,
      this.occupationAddress,
      this.workplaceName,
      this.monthlyIncome,
      this.workplacePhone});

  OccupationInfoStepRequest toOccupationInfoStepRequest(bool isStudent) {
    if (isStudent) {
      return OccupationInfoStepRequest(
          occupationCode: this.occupation?.code,
          occupationName: this.occupation?.name,
          occupationAddress: occupationAddress!.toAddressRequest(),
          monthlyIncome: 0,
          occupationPosition: '',
          workplaceName: this.workplaceName,
          workplacePhone: this.workplacePhone);
    }

    return OccupationInfoStepRequest(
        occupationCode: this.occupation!.code,
        occupationName: this.occupation!.name,
        occupationPosition: this.occupationPosition!.name,
        occupationAddress: occupationAddress!.toAddressRequest(),
        workplaceName: this.workplaceName,
        monthlyIncome: this.monthlyIncome,
        workplacePhone: this.workplacePhone);
  }

  OccupationInfoStepResponse.fromJson(Map<String, dynamic> json) {
    occupation = json['occupation'] != null
        ? new OccupationResponse.fromJson(json['occupation'])
        : null;
    occupationAddress = json['occupationAddress'] != null
        ? new AddressSelected.fromJson(json['occupationAddress'])
        : null;
    workplaceName = json['workplaceName'];
    monthlyIncome = json['monthlyIncome'];
    workplacePhone = json['workplacePhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.occupation != null) {
      data['occupation'] = this.occupation!.toJson();
    }
    if (this.occupationAddress != null) {
      data['occupationAddress'] = this.occupationAddress!.toJson();
    }
    if (this.workplaceName != null) {
      data['workplaceName'] = this.workplaceName!;
    }
    if (this.monthlyIncome != null) {
      data['monthlyIncome'] = this.monthlyIncome!;
    }
    if (this.workplacePhone != null) {
      data['workplacePhone'] = this.workplacePhone!;
    }
    return data;
  }
}
