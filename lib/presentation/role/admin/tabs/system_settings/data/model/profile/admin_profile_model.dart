class AdminProfileModel {
  AdminProfileModel({
    this.success,
    this.message,
    this.data,
  });

  AdminProfileModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

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

class Data {
  Data({
    this.admin,
  });

  Data.fromJson(dynamic json) {
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
  }

  Admin? admin;

  Data copyWith({
    Admin? admin,
  }) {
    return Data(
      admin: admin ?? this.admin,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (admin != null) {
      map['admin'] = admin?.toJson();
    }
    return map;
  }
}

class Admin {
  Admin({
    this.id,
    this.fullName,
    this.email,
    this.isEmailVerified,
    this.isVerified,
    this.role,
    this.isSuspended,
    this.phone,
    this.address,
    this.adminKey,
    this.createdAt,
    this.updatedAt,
  });

  Admin.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    isVerified = json['isVerified']; // Added
    role = json['role'];
    isSuspended = json['isSuspended'];
    phone = json['phone'];
    address = json['address'];
    adminKey = json['adminKey'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? id;
  String? fullName;
  String? email;
  bool? isEmailVerified;
  bool? isVerified;
  String? role;
  bool? isSuspended;
  String? phone;
  String? address;
  String? adminKey;
  String? createdAt;
  String? updatedAt;

  Admin copyWith({
    String? id,
    String? fullName,
    String? email,
    bool? isEmailVerified,
    bool? isVerified,
    String? role,
    bool? isSuspended,
    String? phone,
    String? address,
    String? adminKey,
    String? createdAt,
    String? updatedAt,
  }) {
    return Admin(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
      isSuspended: isSuspended ?? this.isSuspended,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      adminKey: adminKey ?? this.adminKey, // Added
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['isEmailVerified'] = isEmailVerified;
    map['isVerified'] = isVerified;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['phone'] = phone;
    map['address'] = address;
    map['adminKey'] = adminKey;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}