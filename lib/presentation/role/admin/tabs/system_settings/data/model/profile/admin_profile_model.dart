/// success : true
/// message : "Admin profile"
/// data : {"admin":{"_id":"6a2ee06cbb03d3c6680fc479","fullName":"Ziyad Sobhy","email":"root@lifelink.demo","isEmailVerified":true,"role":"superadmin","isSuspended":false,"phone":"01141935341","adminKey":"ADMN69","createdAt":"2026-06-14T17:10:04.154Z","updatedAt":"2026-06-26T23:55:15.452Z"}}

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

  AdminProfileModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return AdminProfileModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

/// admin : {"_id":"6a2ee06cbb03d3c6680fc479","fullName":"Ziyad Sobhy","email":"root@lifelink.demo","isEmailVerified":true,"role":"superadmin","isSuspended":false,"phone":"01141935341","adminKey":"ADMN69","createdAt":"2026-06-14T17:10:04.154Z","updatedAt":"2026-06-26T23:55:15.452Z"}

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

  Data copyWith({
    Admin? admin,
  }) {
    return Data(
      admin: admin ?? this.admin,
    );
  }
}

/// _id : "6a2ee06cbb03d3c6680fc479"
/// fullName : "Ziyad Sobhy"
/// email : "root@lifelink.demo"
/// isEmailVerified : true
/// role : "superadmin"
/// isSuspended : false
/// phone : "01141935341"
/// adminKey : "ADMN69"
/// createdAt : "2026-06-14T17:10:04.154Z"
/// updatedAt : "2026-06-26T23:55:15.452Z"

class Admin {
  Admin({
    this.id,
    this.fullName,
    this.email,
    this.isEmailVerified,
    this.role,
    this.isSuspended,
    this.phone,
    this.adminKey,
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
    adminKey = json['adminKey'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? email;
  bool? isEmailVerified;
  String? role;
  bool? isSuspended;
  String? phone;
  String? adminKey;
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
    map['adminKey'] = adminKey;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  Admin copyWith({
    String? id,
    String? fullName,
    String? email,
    bool? isEmailVerified,
    String? role,
    bool? isSuspended,
    String? phone,
    String? adminKey,
    String? createdAt,
    String? updatedAt,
  }) {
    return Admin(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      role: role ?? this.role,
      isSuspended: isSuspended ?? this.isSuspended,
      phone: phone ?? this.phone,
      adminKey: adminKey ?? this.adminKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}