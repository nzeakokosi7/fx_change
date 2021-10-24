class SupportedCurrencies {
  SupportedCurrencies();

  SupportedCurrencies.fromJson(dynamic json) {
    abbr = json['abbr'];
    rate = json['rate'];
    symbol = json['symbol'];
    fullName = json['fullName'];
  }
  String? abbr;
  String? fullName;
  int? rate;
  String? symbol;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['abbr'] = abbr;
    map['rate'] = rate;
    map['symbol'] = symbol;
    map['fullName'] = fullName;
    return map;
  }

}