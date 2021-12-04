import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/request/address_request.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/model/occupation_info_response.dart';

part 'occupation_info_request.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.occupationInfoLoanDetail)
class OccupationInfoStepRequest extends HiveObject {
  @HiveField(0)
  String? occupationCode;

  @HiveField(1)
  String? occupationName;

  @HiveField(2)
  String? occupationPosition = '';

  @HiveField(3)
  AddressRequest? occupationAddress;

  @HiveField(4)
  String? workplaceName = '';

  @HiveField(5)
  int? monthlyIncome = 0;

  @HiveField(6)
  String? workplacePhone = '';

  OccupationInfoStepRequest(
      {this.occupationCode,
      this.occupationName,
      this.occupationPosition,
      this.occupationAddress,
      this.workplaceName,
      this.monthlyIncome,
      this.workplacePhone});

  OccupationInfoStepRequest.fromJson(Map<String, dynamic> json) {
    occupationCode = json['occupationCode'];
    occupationName = json['occupationName'];
    occupationPosition = json['occupationPosition'];
    occupationAddress = json['occupationAddress'] != null
        ? new AddressRequest.fromJson(json['occupationAddress'])
        : null;
    workplaceName = json['workplaceName'];
    monthlyIncome = json['monthlyIncome'];
    workplacePhone = json['workplacePhone'];
  }

  OccupationInfoStepResponse toOccupationResponse(
      LoanMasterDataResponse masterData) {
    final occupation = masterData.occupations!.firstWhere((element) =>
        element.name == occupationName || element.code == occupationCode);
    // if student occupationPosition is empty
    OccupationPositionResponse? occupationPosition;
    if (this.occupationPosition != null && this.occupationPosition!.isNotEmpty)
      occupationPosition = masterData.occupationPositions!
          .firstWhere((element) => element.name == this.occupationPosition!);
    return OccupationInfoStepResponse(
        occupation: occupation,
        monthlyIncome: monthlyIncome,
        workplaceName: workplaceName,
        workplacePhone: workplacePhone,
        occupationAddress:
            occupationAddress!.toAddressSelected(masterData.addresses!),
        occupationPosition: occupationPosition);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupationCode'] = this.occupationCode;
    data['occupationName'] = this.occupationName;
    data['occupationPosition'] = this.occupationPosition;
    if (this.occupationAddress != null) {
      data['occupationAddress'] = this.occupationAddress!.toJson();
    }
    data['workplaceName'] = this.workplaceName;
    data['monthlyIncome'] = this.monthlyIncome;
    data['workplacePhone'] = this.workplacePhone;
    return data;
  }
}
