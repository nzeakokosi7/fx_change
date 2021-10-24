/// fullName : ""
/// email : ""
/// phone : ""

class User {
  User();

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      fullName = json['fullName'],
      email = json['email'],
      phone = json['phone'];


  String? id;
  String? fullName;
  String? email;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}