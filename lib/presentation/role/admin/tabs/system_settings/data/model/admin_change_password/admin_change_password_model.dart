/// success : true
/// message : "Password updated successfully"
/// data : {"tokens":{"accessToken":"eyJhbGciOiJIUzI1NiIs...","refreshToken":"eyJhbGciOiJIUzI1NiIs..."},"user":{"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"admin@lifelink.demo","role":"admin"}}

class AdminChangePasswordModel {
  AdminChangePasswordModel({
      this.success, 
      this.message, 
      this.data,});

  AdminChangePasswordModel.fromJson(dynamic json) {
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

/// tokens : {"accessToken":"eyJhbGciOiJIUzI1NiIs...","refreshToken":"eyJhbGciOiJIUzI1NiIs..."}
/// user : {"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"admin@lifelink.demo","role":"admin"}

class Data {
  Data({
      this.tokens, 
      this.user,});

  Data.fromJson(dynamic json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  Tokens? tokens;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
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

class User {
  User({
      this.id, 
      this.fullName, 
      this.email, 
      this.role,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    return map;
  }

}

/// accessToken : "eyJhbGciOiJIUzI1NiIs..."
/// refreshToken : "eyJhbGciOiJIUzI1NiIs..."

class Tokens {
  Tokens({
      this.accessToken, 
      this.refreshToken,});

  Tokens.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }

}