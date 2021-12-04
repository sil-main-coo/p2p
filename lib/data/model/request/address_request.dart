import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/response/addresses_response.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';

part 'address_request.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.addressInfoLoanDetail)
class AddressRequest extends HiveObject {
  @HiveField(0)
  String? level1_Id;

  @HiveField(1)
  String? level2_Id;

  @HiveField(2)
  String? level3_Id;

  @HiveField(3)
  String? detail;

  AddressRequest({this.level1_Id, this.level2_Id, this.level3_Id, this.detail});

  AddressRequest.fromJson(Map<String, dynamic> json) {
    level1_Id = json['level1Id'] ?? json['level1_Id'];
    level2_Id = json['level2Id'] ?? json['level2_Id'];
    level3_Id = json['level3Id']?? json['level3_Id'];
    detail = json['detail'];
  }

  AddressSelected toAddressSelected(Addresses addresses) {
    final province =
        addresses.data!.firstWhere((element) => element.level1Id == level1_Id);

    final district = province.level2s!
        .firstWhere((element) => element.level2Id == level2_Id);
    final ward = district.level3s!
        .firstWhere((element) => element.level3Id == level3_Id);
    detail = detail;

    return AddressSelected(province, district, ward, detail);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level1_Id'] = this.level1_Id;
    data['level2_Id'] = this.level2_Id;
    data['level3_Id'] = this.level3_Id;
    data['detail'] = this.detail;
    return data;
  }
}
