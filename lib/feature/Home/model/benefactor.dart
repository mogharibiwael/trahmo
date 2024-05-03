class Benefactor {
  String? name;
  String? amount;
  String? phone;
  String? aotherBenefactor;
  String? aotherPhone;

  Benefactor(
      {
        this.name,
        this.amount,
        this.phone,
        this.aotherBenefactor,
        this.aotherPhone});

  Benefactor.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    name = json['name'];
    phone = json['phone'];
    aotherBenefactor = json['aother_benefactor'];
    aotherPhone = json['aother_phone'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['phone'] = phone;
    data['aother_benefactor'] = aotherBenefactor;
    data['aother_phone'] = aotherPhone;
    return data;
  }

}
