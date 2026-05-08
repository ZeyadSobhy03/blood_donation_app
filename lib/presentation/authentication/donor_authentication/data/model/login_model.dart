/// success : true
/// data : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc3ODg2OTE5NX0.OsJ7AaPdWRRWx01uJuafg60-uGyTkQoSCPleLShRDhA","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc4MDg1NjM5NX0.qufdWd7kIhjX9V_gzci1yGVtpLDkk14ChO1FzD1AIew","user":{"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor"},"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc3ODg2OTE5NX0.OsJ7AaPdWRRWx01uJuafg60-uGyTkQoSCPleLShRDhA","refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc4MDg1NjM5NX0.qufdWd7kIhjX9V_gzci1yGVtpLDkk14ChO1FzD1AIew","user_id":"69f3df915f42685cbbbcbb18","user_role":"donor","user_name":"Aya Hassan"}

class LoginModel {
  LoginModel({
      this.success, 
      this.data,});

  LoginModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc3ODg2OTE5NX0.OsJ7AaPdWRRWx01uJuafg60-uGyTkQoSCPleLShRDhA"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc4MDg1NjM5NX0.qufdWd7kIhjX9V_gzci1yGVtpLDkk14ChO1FzD1AIew"
/// user : {"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor"}
/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc3ODg2OTE5NX0.OsJ7AaPdWRRWx01uJuafg60-uGyTkQoSCPleLShRDhA"
/// refresh_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWYzZGY5MTVmNDI2ODVjYmJiY2JiMTgiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNjQzOTUsImV4cCI6MTc4MDg1NjM5NX0.qufdWd7kIhjX9V_gzci1yGVtpLDkk14ChO1FzD1AIew"
/// user_id : "69f3df915f42685cbbbcbb18"
/// user_role : "donor"
/// user_name : "Aya Hassan"

class Data {
  Data({
      this.accessToken, 
      this.refreshToken, 
      this.user, 

      this.userId, 
      this.userRole, 
      this.userName,});

  Data.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userId = json['user_id'];
    userRole = json['user_role'];
    userName = json['user_name'];
  }
  String? accessToken;
  String? refreshToken;
  User? user;

  String? userId;
  String? userRole;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    map['user_id'] = userId;
    map['user_role'] = userRole;
    map['user_name'] = userName;
    return map;
  }

}

/// _id : "69f3df915f42685cbbbcbb18"
/// fullName : "Aya Hassan"
/// email : "aya.hassan@lifelink.demo"
/// role : "donor"

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