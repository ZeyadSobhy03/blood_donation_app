/// success : true
/// message : "Admin key rotated successfully. The new key is shown only once — store it securely."
/// data : {"admin":{"_id":"69fe540565ff7785a031314f","fullName":"Salma Mostafa","email":"salma.mostafa@lifelink.demo","role":"admin","adminKey":"ADMX9Z"}}

class RoteAdminKeyModel {
  RoteAdminKeyModel({
      this.success, 
      this.message, 
      this.data,});

  RoteAdminKeyModel.fromJson(dynamic json) {
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

/// admin : {"_id":"69fe540565ff7785a031314f","fullName":"Salma Mostafa","email":"salma.mostafa@lifelink.demo","role":"admin","adminKey":"ADMX9Z"}

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

/// _id : "69fe540565ff7785a031314f"
/// fullName : "Salma Mostafa"
/// email : "salma.mostafa@lifelink.demo"
/// role : "admin"
/// adminKey : "ADMX9Z"

class Admin {
  Admin({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.adminKey,});

  Admin.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    adminKey = json['adminKey'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? adminKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['adminKey'] = adminKey;
    return map;
  }

}