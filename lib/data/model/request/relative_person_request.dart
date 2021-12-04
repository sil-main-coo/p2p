import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';

part 'relative_person_request.g.dart';

@HiveType(typeId: HiveLoanDetailConstants.relativeLoanDetailResponse)
class RelativePersonRequest extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? typeId;

  @HiveField(2)
  String? phone;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? type;

  RelativePersonRequest(
      {this.typeId, this.phone, this.name, this.id, this.type});


  @override
  String toString() {
    return type!;
  }

  RelativePersonRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['typeId'] ?? json['id'];
    phone = json['phone'];

    name = json['name'];
    type = json['type'];

    if (json['type_name'] != null) {
      name = json['type_name'];
      type = json['type_name'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeId'] = this.typeId;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
