/// success : true
/// data : {"accessToken":"...","refreshToken":"...","user":{"_id":"...","fullName":"Cairo Care Hospital","email":"ops@cairocare.demo","role":"hospital"},"access_token":"...","refresh_token":"...","user_id":"...","user_role":"hospital","user_name":"Cairo Care Hospital"}

class HospitalLoginModel {
  HospitalLoginModel({
    this.success,
    this.data,
  });

  HospitalLoginModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? HospitalData.fromJson(json['data']) : null;
  }

  bool? success;
  HospitalData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class HospitalData {
  HospitalData({
    this.accessToken,
    this.refreshToken,
    this.user,
    this.userId,
    this.userRole,
    this.userName,
  });

  HospitalData.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? HospitalUser.fromJson(json['user']) : null;
    accessToken = json['access_token'] ?? accessToken;
    refreshToken = json['refresh_token'] ?? refreshToken;
    userId = json['user_id'];
    userRole = json['user_role'];
    userName = json['user_name'];
  }

  String? accessToken;
  String? refreshToken;
  HospitalUser? user;
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

class HospitalUser {
  HospitalUser({
    this.id,
    this.fullName,
    this.email,
    this.role,
  });

  HospitalUser.fromJson(dynamic json) {
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