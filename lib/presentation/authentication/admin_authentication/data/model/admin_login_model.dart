/// success : true
/// message : "Admin login successful"
/// data : {"accessToken":"eyJ...admin-access","refreshToken":"eyJ...admin-refresh","user":{"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"admin@lifelink.demo","role":"admin","phone":"01099998888"}}

class AdminLoginModel {
  AdminLoginModel({
      this.success, 
      this.message, 
      this.data,});

  AdminLoginModel.fromJson(dynamic json) {
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

/// accessToken : "eyJ...admin-access"
/// refreshToken : "eyJ...admin-refresh"
/// user : {"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"admin@lifelink.demo","role":"admin","phone":"01099998888"}

class Data {
  Data({
      this.accessToken, 
      this.refreshToken, 
      this.user,});

  Data.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? accessToken;
  String? refreshToken;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "66f200000000000000000001"
/// fullName : "Noura Hassan"
/// email : "admin@lifelink.demo"
/// role : "admin"
/// phone : "01099998888"

class User {
  User({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.phone,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['phone'] = phone;
    return map;
  }

}