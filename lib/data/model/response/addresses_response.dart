class Addresses {
  List<DataAddress>? data;

  Addresses({this.data});

  Addresses.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DataAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAddress {
  String? level1Id;
  String? name;
  String? type;
  List<Level2s>? level2s;

  DataAddress({this.level1Id, this.name, this.type, this.level2s});


  @override
  String toString() {
    return this.name!;
  }

  DataAddress.fromJson(Map<String, dynamic> json) {
    level1Id = json['level1_id'];
    name = json['name'];
    type = json['type'];
    if (json['level2s'] != null) {
      level2s = [];
      json['level2s'].forEach((v) {
        level2s!.add(new Level2s.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level1_id'] = this.level1Id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.level2s != null) {
      data['level2s'] = this.level2s!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Level2s {
  String? level2Id;
  String? name;
  String? type;
  String? level1Id;
  String? addressLevel1;
  List<Level3s>? level3s;

  Level2s(
      {this.level2Id,
        this.name,
        this.type,
        this.level1Id,
        this.addressLevel1,
        this.level3s});

  @override
  String toString() {
    return this.name!;
  }

  Level2s.fromJson(Map<String, dynamic> json) {
    level2Id = json['level2_id'];
    name = json['name'];
    type = json['type'];
    level1Id = json['level1_id'];
    addressLevel1 = json['address_level_1'];
    if (json['level3s'] != null) {
      level3s = [];
      json['level3s'].forEach((v) {
        level3s!.add(new Level3s.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level2_id'] = this.level2Id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['level1_id'] = this.level1Id;
    data['address_level_1'] = this.addressLevel1;
    if (this.level3s != null) {
      data['level3s'] = this.level3s!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Level3s {
  String? level3Id;
  String? name;
  String? type;
  String? level2Id;
  String? addressLevel2;

  Level3s(
      {this.level3Id, this.name, this.type, this.level2Id, this.addressLevel2});

  @override
  String toString() {
    return this.name!;
  }

  Level3s.fromJson(Map<String, dynamic> json) {
    level3Id = json['level3_id'];
    name = json['name'];
    type = json['type'];
    level2Id = json['level2_id'];
    addressLevel2 = json['address_level_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level3_id'] = this.level3Id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['level2_id'] = this.level2Id;
    data['address_level_2'] = this.addressLevel2;
    return data;
  }
}
