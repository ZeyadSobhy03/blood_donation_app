/// success : true
/// message : "Admin profile updated successfully"
/// data : {"admin":{"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"noura.new@lifelink.demo","role":"admin","phone":"01122223333","isEmailVerified":false,"isSuspended":false,"createdAt":"2026-01-10T08:30:00.000Z","updatedAt":"2026-06-08T10:00:00.000Z"}}

class AdminProfileUpdateModel {
  AdminProfileUpdateModel({
      this.success, 
      this.message, 
      this.data,});

  AdminProfileUpdateModel.fromJson(dynamic json) {
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

/// admin : {"_id":"66f200000000000000000001","fullName":"Noura Hassan","email":"noura.new@lifelink.demo","role":"admin","phone":"01122223333","isEmailVerified":false,"isSuspended":false,"createdAt":"2026-01-10T08:30:00.000Z","updatedAt":"2026-06-08T10:00:00.000Z"}

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

/// _id : "66f200000000000000000001"
/// fullName : "Noura Hassan"
/// email : "noura.new@lifelink.demo"
/// role : "admin"
/// phone : "01122223333"
/// isEmailVerified : false
/// isSuspended : false
/// createdAt : "2026-01-10T08:30:00.000Z"
/// updatedAt : "2026-06-08T10:00:00.000Z"

class Admin {
  Admin({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.phone, 
      this.isEmailVerified, 
      this.isSuspended, 
      this.createdAt, 
      this.updatedAt,});

  Admin.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
    isSuspended = json['isSuspended'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? phone;
  bool? isEmailVerified;
  bool? isSuspended;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['phone'] = phone;
    map['isEmailVerified'] = isEmailVerified;
    map['isSuspended'] = isSuspended;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}