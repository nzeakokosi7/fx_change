class TransactionHistory {
  TransactionHistory({
      String? id, 
      String? date, 
      List<Transactions>? transactions,}){
    _id = id;
    _date = date;
    _transactions = transactions;
}

  TransactionHistory.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  String? _id;
  String? _date;
  List<Transactions>? _transactions;

  String? get id => _id;
  String? get date => _date;
  List<Transactions>? get transactions => _transactions;

  set id(value) => _id = value;
  set date(value) => _date = value;
  set transactions(value) => _transactions = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Transactions {
  Transactions({
      String? accountName, 
      String? accountNumber, 
      String? currencySymbol, 
      String? financialInstitution, 
      String? amount, 
      String? rate, 
      String? time, 
      String? status,}){
    _accountName = accountName;
    _accountNumber = accountNumber;
    _currencySymbol = currencySymbol;
    _financialInstitution = financialInstitution;
    _amount = amount;
    _rate = rate;
    _time = time;
    _status = status;
}

  Transactions.fromJson(dynamic json) {
    _accountName = json['accountName'];
    _accountNumber = json['accountNumber'];
    _currencySymbol = json['currencySymbol'];
    _financialInstitution = json['financialInstitution'];
    _amount = json['amount'];
    _rate = json['rate'];
    _time = json['time'];
    _status = json['status'];
  }
  String? _accountName;
  String? _accountNumber;
  String? _currencySymbol;
  String? _financialInstitution;
  String? _amount;
  String? _rate;
  String? _time;
  String? _status;

  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get currencySymbol => _currencySymbol;
  String? get financialInstitution => _financialInstitution;
  String? get amount => _amount;
  String? get rate => _rate;
  String? get time => _time;
  String? get status => _status;

  set accountName(value) => _accountName = value;
  set accountNumber(value) => _accountNumber = value;
  set currencySymbol(value) => _currencySymbol = value;
  set financialInstitution(value) => _financialInstitution = value;
  set amount(value) => _amount = value;
  set rate(value) => _rate = value;
  set time(value) => _time = value;
  set status(value) => _status = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountName'] = _accountName;
    map['accountNumber'] = _accountNumber;
    map['currencySymbol'] = _currencySymbol;
    map['financialInstitution'] = _financialInstitution;
    map['amount'] = _amount;
    map['rate'] = _rate;
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }

}