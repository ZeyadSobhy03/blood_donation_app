/// success : true
/// message : "Hospital updated successfully"
/// data : {"user":{"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Hospital","hospitalName":"Cairo Care Hospital","email":"ops@cairocare.demo","role":"hospital","phone":"1044444444","updatedAt":"2026-05-18T09:05:00.000Z"}}

class AdminUpdateHospitalModel {
  AdminUpdateHospitalModel({
      this.success, 
      this.message, 
      this.data,});

  AdminUpdateHospitalModel.fromJson(dynamic json) {
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

/// user : {"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Hospital","hospitalName":"Cairo Care Hospital","email":"ops@cairocare.demo","role":"hospital","phone":"1044444444","updatedAt":"2026-05-18T09:05:00.000Z"}

class Data {
  Data({
      this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "69f3df915f42685cbbbcbb1b"
/// fullName : "Cairo Care Hospital"
/// hospitalName : "Cairo Care Hospital"
/// email : "ops@cairocare.demo"
/// role : "hospital"
/// phone : "1044444444"
/// updatedAt : "2026-05-18T09:05:00.000Z"

class User {
  User({
      this.id, 
      this.fullName, 
      this.hospitalName, 
      this.email, 
      this.role, 
      this.phone, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    hospitalName = json['hospitalName'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? hospitalName;
  String? email;
  String? role;
  String? phone;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['hospitalName'] = hospitalName;
    map['email'] = email;
    map['role'] = role;
    map['phone'] = phone;
    map['updatedAt'] = updatedAt;
    return map;
  }

}