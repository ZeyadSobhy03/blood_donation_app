
class AdminModel {
  AdminModel({
      this.success, 
      this.message, 
      this.data,});

  AdminModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// admin : {"_id":"66f200000000000000000003","fullName":"Salma Mostafa","email":"salma.mostafa@lifelink.demo","role":"admin","isEmailVerified":true,"phone":"+201234567890","adminKey":"ADMa1b2c3d4e5f67890"}

class Data {
  Data({
      this.admin,});

  Data.fromJson(dynamic json) {
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
  }
  Admin? admin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (admin != null) {
      map['admin'] = admin?.toJson();
    }
    return map;
  }

}

/// _id : "66f200000000000000000003"
/// fullName : "Salma Mostafa"
/// email : "salma.mostafa@lifelink.demo"
/// role : "admin"
/// isEmailVerified : true
/// phone : "+201234567890"
/// adminKey : "ADMa1b2c3d4e5f67890"

class Admin {
  Admin({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.isEmailVerified, 
      this.phone, 
      this.adminKey,});

  Admin.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
    phone = json['phone'];
    adminKey = json['adminKey'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  bool? isEmailVerified;
  String? phone;
  String? adminKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['isEmailVerified'] = isEmailVerified;
    map['phone'] = phone;
    map['adminKey'] = adminKey;
    return map;
  }

}