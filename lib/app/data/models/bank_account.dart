class BankAccount {
  String? id;
  String? financialInstitution;
  String? accountNumber;
  String? accountName;
  String? currencySymbol;
  String? currency;

  BankAccount();

  BankAccount.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        financialInstitution = json['financialInstitution'],
        accountNumber = json['accountNumber'],
        accountName = json['accountName'],
        currencySymbol = json['currencySymbol'],
        currency = json["currency"];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['financialInstitution'] = financialInstitution;
    map['accountNumber'] = accountNumber;
    map['accountName'] = accountName;
    map['currencySymbol'] = currencySymbol;
    map["currency"] = currency;
    return map;
  }

}