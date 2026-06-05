/// success : true
/// message : "Login successful"
/// data : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MDYwMDI4M30.aEw896N5D-RWG4JDns7-Ofs1XyBGwJosPkmUDh39-RE","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MjU4NzQ4M30.bkA1_4ks0gYhzPXPx7ifuhJ7-e6H6Ut1c8gbuSj-Gio","user":{"_id":"6a130e800b339a45a51addad","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","isEmailVerified":true},"verified":true,"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MDYwMDI4M30.aEw896N5D-RWG4JDns7-Ofs1XyBGwJosPkmUDh39-RE","refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MjU4NzQ4M30.bkA1_4ks0gYhzPXPx7ifuhJ7-e6H6Ut1c8gbuSj-Gio","user_id":"6a130e800b339a45a51addad","user_role":"donor","user_name":"Aya Hassan"}

class LoginModel {
  LoginModel({
      this.success, 
      this.message, 
      this.data,});

  LoginModel.fromJson(dynamic json) {
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

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MDYwMDI4M30.aEw896N5D-RWG4JDns7-Ofs1XyBGwJosPkmUDh39-RE"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MjU4NzQ4M30.bkA1_4ks0gYhzPXPx7ifuhJ7-e6H6Ut1c8gbuSj-Gio"
/// user : {"_id":"6a130e800b339a45a51addad","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","isEmailVerified":true}
/// verified : true
/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MDYwMDI4M30.aEw896N5D-RWG4JDns7-Ofs1XyBGwJosPkmUDh39-RE"
/// refresh_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMGU4MDBiMzM5YTQ1YTUxYWRkYWQiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk5OTU0ODMsImV4cCI6MTc4MjU4NzQ4M30.bkA1_4ks0gYhzPXPx7ifuhJ7-e6H6Ut1c8gbuSj-Gio"
/// user_id : "6a130e800b339a45a51addad"
/// user_role : "donor"
/// user_name : "Aya Hassan"

class Data {
  Data({
      this.accessToken, 
      this.refreshToken, 
      this.user, 
      this.verified, 

      this.userId, 
      this.userRole, 
      this.userName,});

  Data.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    verified = json['verified'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userId = json['user_id'];
    userRole = json['user_role'];
    userName = json['user_name'];
  }
  String? accessToken;
  String? refreshToken;
  User? user;
  bool? verified;

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
    map['verified'] = verified;
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    map['user_id'] = userId;
    map['user_role'] = userRole;
    map['user_name'] = userName;
    return map;
  }

}

/// _id : "6a130e800b339a45a51addad"
/// fullName : "Aya Hassan"
/// email : "aya.hassan@lifelink.demo"
/// role : "donor"
/// isEmailVerified : true

class User {
  User({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.isEmailVerified,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    isEmailVerified = json['isEmailVerified'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  bool? isEmailVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['isEmailVerified'] = isEmailVerified;
    return map;
  }

}