class CreditRanks {
  int? id;
  String? rank;
  double? interestRate;
  String? unit;

  CreditRanks({this.id, this.rank, this.interestRate, this.unit});

  CreditRanks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    interestRate = double.parse(json['interestRate'].toString());
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id!;
    data['rank'] = this.rank!;
    data['interestRate'] = this.interestRate!;
    data['unit'] = this.unit!;
    return data;
  }
}
