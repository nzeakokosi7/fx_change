class BankList {
  BankList({
      bool? status, 
      String? message, 
      List<BankData>? data,
      Meta? meta,}){
    _status = status;
    _message = message;
    _data = data;
    _meta = meta;
}

  BankList.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BankData.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  bool? _status;
  String? _message;
  List<BankData>? _data;
  Meta? _meta;

  bool? get status => _status;
  String? get message => _message;
  List<BankData>? get data => _data;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

class Meta {
  Meta({
      String? next, 
      dynamic previous, 
      int? perPage,}){
    _next = next;
    _previous = previous;
    _perPage = perPage;
}

  Meta.fromJson(dynamic json) {
    _next = json['next'];
    _previous = json['previous'];
    _perPage = json['perPage'];
  }
  String? _next;
  dynamic _previous;
  int? _perPage;

  String? get next => _next;
  dynamic get previous => _previous;
  int? get perPage => _perPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['next'] = _next;
    map['previous'] = _previous;
    map['perPage'] = _perPage;
    return map;
  }

}

class BankData {
  BankData({
      String? name, 
      String? slug, 
      String? code, 
      String? longcode, 
      dynamic gateway, 
      bool? payWithBank, 
      bool? active, 
      bool? isDeleted, 
      String? country, 
      String? currency, 
      String? type, 
      int? id, 
      String? createdAt, 
      String? updatedAt,}){
    _name = name;
    _slug = slug;
    _code = code;
    _longcode = longcode;
    _gateway = gateway;
    _payWithBank = payWithBank;
    _active = active;
    _isDeleted = isDeleted;
    _country = country;
    _currency = currency;
    _type = type;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  BankData.fromJson(dynamic json) {
    _name = json['name'];
    _slug = json['slug'];
    _code = json['code'];
    _longcode = json['longcode'];
    _gateway = json['gateway'];
    _payWithBank = json['pay_with_bank'];
    _active = json['active'];
    _isDeleted = json['is_deleted'];
    _country = json['country'];
    _currency = json['currency'];
    _type = json['type'];
    _id = json['id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _name;
  String? _slug;
  String? _code;
  String? _longcode;
  dynamic _gateway;
  bool? _payWithBank;
  bool? _active;
  bool? _isDeleted;
  String? _country;
  String? _currency;
  String? _type;
  int? _id;
  String? _createdAt;
  String? _updatedAt;

  String? get name => _name;
  String? get slug => _slug;
  String? get code => _code;
  String? get longcode => _longcode;
  dynamic get gateway => _gateway;
  bool? get payWithBank => _payWithBank;
  bool? get active => _active;
  bool? get isDeleted => _isDeleted;
  String? get country => _country;
  String? get currency => _currency;
  String? get type => _type;
  int? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['slug'] = _slug;
    map['code'] = _code;
    map['longcode'] = _longcode;
    map['gateway'] = _gateway;
    map['pay_with_bank'] = _payWithBank;
    map['active'] = _active;
    map['is_deleted'] = _isDeleted;
    map['country'] = _country;
    map['currency'] = _currency;
    map['type'] = _type;
    map['id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}