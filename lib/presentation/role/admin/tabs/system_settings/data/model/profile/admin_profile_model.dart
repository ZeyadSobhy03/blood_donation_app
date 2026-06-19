
class AdminProfileModel {
  AdminProfileModel({
      this.success, 
      this.message, 
      this.data,});

  AdminProfileModel.fromJson(dynamic json) {
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

/// admin : {"_id":"6a2ee06bbb03d3c6680fc478","fullName":"LifeLink Demo Admin","email":"admin@lifelink.demo","isEmailVerified":true,"role":"admin","isSuspended":false,"phone":null,"address":null,"createdAt":"2026-06-14T17:10:03.879Z","updatedAt":"2026-06-14T17:27:04.738Z"}

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

/// _id : "6a2ee06bbb03d3c6680fc478"
/// fullName : "LifeLink Demo Admin"
/// email : "admin@lifelink.demo"
/// isEmailVerified : true
/// role : "admin"
/// isSuspended : false
/// phone : null
/// address : null
/// createdAt : "2026-06-14T17:10:03.879Z"
/// updatedAt : "2026-06-14T17:27:04.738Z"

class Admin {
  Admin({
      this.id, 
      this.fullName, 
      this.email, 
      this.isEmailVerified, 
      this.role, 
      this.isSuspended, 
      this.phone, 
      this.address, 
      this.createdAt, 
      this.updatedAt,});

  Admin.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    phone = json['phone'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? email;
  bool? isEmailVerified;
  String? role;
  bool? isSuspended;
  dynamic phone;
  dynamic address;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['isEmailVerified'] = isEmailVerified;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['phone'] = phone;
    map['address'] = address;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}