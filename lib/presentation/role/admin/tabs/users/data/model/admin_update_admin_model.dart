/// success : true
/// message : "Admin updated successfully"
/// data : {"user":{"_id":"66f200000000000000000003","fullName":"Salma Mostafa","email":"salma.mostafa@lifelink.demo","role":"admin","isSuspended":false,"updatedAt":"2026-05-18T09:08:00.000Z"}}

class AdminUpdateAdminModel {
  AdminUpdateAdminModel({
      this.success, 
      this.message, 
      this.data,});

  AdminUpdateAdminModel.fromJson(dynamic json) {
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

/// user : {"_id":"66f200000000000000000003","fullName":"Salma Mostafa","email":"salma.mostafa@lifelink.demo","role":"admin","isSuspended":false,"updatedAt":"2026-05-18T09:08:00.000Z"}

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

/// _id : "66f200000000000000000003"
/// fullName : "Salma Mostafa"
/// email : "salma.mostafa@lifelink.demo"
/// role : "admin"
/// isSuspended : false
/// updatedAt : "2026-05-18T09:08:00.000Z"

class User {
  User({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.isSuspended, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  bool? isSuspended;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['updatedAt'] = updatedAt;
    return map;
  }

}