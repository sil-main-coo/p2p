import 'package:p2p_borrower/common/constants/occupation_enums.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import '__mocks__/occupation_position_mock.dart';
import '__mocks__/owner_ship_type_mock.dart';

import 'addresses_response.dart';
import 'user_credit_rank_response.dart';

class LoanMasterDataResponse {
  Addresses? addresses;
  List<MaritalStatusResponse>? maritalStatuses;
  List<RelativePersonRequest>? relativePersonTypes;
  List<OccupationResponse>? occupations;
  List<OccupationPositionResponse>? occupationPositions;
  CreditRanks? userCreditRank;
  List<CreditRanks>? creditRanks;
  List<OwnerShipTypeResponse>? ownerShipTypes;

  LoanMasterDataResponse(
      {this.addresses,
      this.occupationPositions,
      this.maritalStatuses,
      this.relativePersonTypes,
      this.occupations,
      this.userCreditRank,
      this.creditRanks,
      this.ownerShipTypes});

  LoanMasterDataResponse.fromJson(Map<String, dynamic> json) {
    addresses = json['addresses'] != null
        ? new Addresses.fromJson(json['addresses'])
        : null;
    if (json['maritalStatuses'] != null) {
      maritalStatuses = [];
      json['maritalStatuses'].forEach((v) {
        maritalStatuses!.add(new MaritalStatusResponse.fromJson(v));
      });
    }
    if (json['relativePersonTypes'] != null) {
      relativePersonTypes = [];
      json['relativePersonTypes'].forEach((v) {
        relativePersonTypes!.add(new RelativePersonRequest.fromJson(v));
      });
    }
    if (json['occupations'] != null) {
      occupations = [];
      json['occupations'].forEach((v) {
        occupations!.add(new OccupationResponse.fromJson(v));
      });

      /// add other element to last occupations array
      occupations!.add(OccupationResponse.other());
    }
    userCreditRank = json['userCreditRank'] != null
        ? new CreditRanks.fromJson(json['userCreditRank'])
        : null;
    if (json['creditRanks'] != null) {
      creditRanks = [];
      json['creditRanks'].forEach((v) {
        creditRanks!.add(new CreditRanks.fromJson(v));
      });
    }

    /// MOCK OWNER SHIP DATA
    ownerShipTypes = [];
    jsonOwnerShipTypeMock.forEach((v) {
      ownerShipTypes!.add(new OwnerShipTypeResponse.fromJson(v));
    });

    /// MOCK OCCUPATION POSITION DATA
    occupationPositions = [];
    jsonOccupationPositionMock.forEach((v) {
      occupationPositions!.add(new OccupationPositionResponse.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.toJson();
    }
    if (this.maritalStatuses != null) {
      data['maritalStatuses'] =
          this.maritalStatuses!.map((v) => v.toJson()).toList();
    }
    if (this.relativePersonTypes != null) {
      data['relativePersonTypes'] =
          this.relativePersonTypes!.map((v) => v.toJson()).toList();
    }
    if (this.occupations != null) {
      data['occupations'] = this.occupations!.map((v) => v.toJson()).toList();
    }
    if (this.userCreditRank != null) {
      data['userCreditRank'] = this.userCreditRank!.toJson();
    }
    if (this.creditRanks != null) {
      data['creditRanks'] = this.creditRanks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RelativePersonTypeResponse {
  String? typeName;
  int? id;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;
  String? phone;

  RelativePersonTypeResponse(
      {this.typeName,
      this.id,
      this.createBy,
      this.createDate,
      this.phone,
      this.updateBy,
      this.updateDate});

  @override
  String toString() {
    return typeName!;
  }

  RelativePersonRequest toRelativePersonRequest() {
    return RelativePersonRequest(
        phone: phone, typeId: this.id, name: this.typeName);
  }

  RelativePersonTypeResponse.fromJson(Map<String, dynamic> json) {
    typeName = json['type_name'];
    id = json['id'];
    phone = json['phone'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_name'] = this.typeName;
    data['id'] = this.id;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    data['phone'] = this.phone;
    return data;
  }
}

class OccupationResponse {
  String? code;
  String? name;
  int? id;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;
  String? detail;

  OccupationResponse(
      {this.code,
      this.name,
      this.id,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate,
      this.detail});

  OccupationResponse.other(
      {this.id,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate}) {
    this.code = OccupationEnums.Other.toString();
    this.name = S.current.other;
  }

  OccupationResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    id = json['id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['id'] = this.id;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    data['detail'] = this.detail;
    return data;
  }
}

class OccupationPositionResponse {
  String? name;
  int? id;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;

  OccupationPositionResponse(
      {this.name,
      this.id,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate});

  @override
  String toString() {
    return name!;
  }

  OccupationPositionResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class MaritalStatusResponse {
  String? status;
  int? id;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;

  MaritalStatusResponse(
      {this.status,
      this.id,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate});

  @override
  String toString() {
    return status!;
  }

  MaritalStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class OwnerShipTypeResponse {
  String? name;
  int? id;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;

  OwnerShipTypeResponse(
      {this.name,
      this.id,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate});

  @override
  String toString() {
    return name!;
  }

  OwnerShipTypeResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    return data;
  }
}
