import 'package:p2p_borrower/data/model/request/address_request.dart';
import 'package:p2p_borrower/data/model/response/addresses_response.dart';

// todo: impl hive
class AddressSelected {
  DataAddress? province;
  Level2s? district;
  Level3s? ward;
  String? detail;

  AddressSelected(this.province, this.district, this.ward, this.detail);

  AddressSelected.fromAddressRequest(
      Addresses addresses, AddressRequest addressRequest) {
    province = addresses.data!
        .firstWhere((element) => element.level1Id == addressRequest.level1_Id);
    district = province!.level2s!
        .firstWhere((element) => element.level2Id == addressRequest.level2_Id);
    ward = district!.level3s!
        .firstWhere((element) => element.level3Id == addressRequest.level3_Id);
    detail = addressRequest.detail;
  }

  AddressSelected.fromJson(Map<String, dynamic> json) {
    province = DataAddress.fromJson(json['province']);
    district = Level2s.fromJson(json['district']);
    ward = Level3s.fromJson(json['ward']);
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province!.toJson();
    data['district'] = this.district!.toJson();
    data['ward'] = this.ward!.toJson();
    data['detail'] = this.detail!;
    return data;
  }

  @override
  String toString() {
    return '$detail, $ward, $district, $province';
  }

  AddressRequest toAddressRequest() {
    return AddressRequest(
        level1_Id: province!.level1Id,
        level2_Id: district!.level2Id,
        level3_Id: ward!.level3Id,
        detail: detail);
  }
}
