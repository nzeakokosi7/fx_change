class ResolvedBank {
  ResolvedBank({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ResolvedBank.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? accountNumber, 
      String? accountName,}){
    _accountNumber = accountNumber;
    _accountName = accountName;
}

  Data.fromJson(dynamic json) {
    _accountNumber = json['account_number'];
    _accountName = json['account_name'];
  }
  String? _accountNumber;
  String? _accountName;

  String? get accountNumber => _accountNumber;
  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    return map;
  }

}