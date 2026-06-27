/// success : true
/// message : "Password changed successfully"
/// data : {"tokens":{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzgzMTI3MDc0fQ.TzOEo4TQGX4vqAGA56mTco1bDGFU5wwn3Q6HwcJ97LM","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzg1MTE0Mjc0fQ.2gJ0kH68Zo8WMlMTC8h0mSZ8frVK9jCbWIGBRoAZ_a8"},"user":{"_id":"6a2ee06cbb03d3c6680fc479","fullName":"ppp","email":"ziyadsobhyadmin@gmail.com","role":"superadmin"}}

class ChangePasswordModel {
  ChangePasswordModel({
      this.success, 
      this.message, 
      this.data,});

  ChangePasswordModel.fromJson(dynamic json) {
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

/// tokens : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzgzMTI3MDc0fQ.TzOEo4TQGX4vqAGA56mTco1bDGFU5wwn3Q6HwcJ97LM","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzg1MTE0Mjc0fQ.2gJ0kH68Zo8WMlMTC8h0mSZ8frVK9jCbWIGBRoAZ_a8"}
/// user : {"_id":"6a2ee06cbb03d3c6680fc479","fullName":"ppp","email":"ziyadsobhyadmin@gmail.com","role":"superadmin"}

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

/// _id : "6a2ee06cbb03d3c6680fc479"
/// fullName : "ppp"
/// email : "ziyadsobhyadmin@gmail.com"
/// role : "superadmin"

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

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzgzMTI3MDc0fQ.TzOEo4TQGX4vqAGA56mTco1bDGFU5wwn3Q6HwcJ97LM"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTJlZTA2Y2JiMDNkM2M2NjgwZmM0NzkiLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTc4MjUyMjI3NCwiZXhwIjoxNzg1MTE0Mjc0fQ.2gJ0kH68Zo8WMlMTC8h0mSZ8frVK9jCbWIGBRoAZ_a8"

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