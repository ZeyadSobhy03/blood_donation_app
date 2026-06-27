/// success : true
/// message : "Admin profile updated successfully"
/// data : {"admin":{"location":{"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-25T22:30:49.147Z"},"position":null,"department":null,"_id":"6a2ee06cbb03d3c6680fc479","fullName":"Ziyad Sobhy","email":"root@lifelink.demo","isEmailVerified":true,"emailVerifiedAt":"2026-06-25T22:30:49.147Z","role":"superadmin","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":"01141935341","address":null,"createdAt":"2026-06-14T17:10:04.154Z","updatedAt":"2026-06-27T00:00:29.418Z","fullNameNormalized":"ziyad sobhy","__v":0}}

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

  AdminProfileUpdateModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return AdminProfileUpdateModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

/// admin : {"location":{"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-25T22:30:49.147Z"},"position":null,"department":null,"_id":"6a2ee06cbb03d3c6680fc479","fullName":"Ziyad Sobhy","email":"root@lifelink.demo","isEmailVerified":true,"emailVerifiedAt":"2026-06-25T22:30:49.147Z","role":"superadmin","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":"01141935341","address":null,"createdAt":"2026-06-14T17:10:04.154Z","updatedAt":"2026-06-27T00:00:29.418Z","fullNameNormalized":"ziyad sobhy","__v":0}

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

/// location : {"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-25T22:30:49.147Z"}
/// position : null
/// department : null
/// _id : "6a2ee06cbb03d3c6680fc479"
/// fullName : "Ziyad Sobhy"
/// email : "root@lifelink.demo"
/// isEmailVerified : true
/// emailVerifiedAt : "2026-06-25T22:30:49.147Z"
/// role : "superadmin"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : []
/// phone : "01141935341"
/// address : null
/// createdAt : "2026-06-14T17:10:04.154Z"
/// updatedAt : "2026-06-27T00:00:29.418Z"
/// fullNameNormalized : "ziyad sobhy"
/// __v : 0

class Admin {
  Admin({
    this.location,
    this.position,
    this.department,
    this.id,
    this.fullName,
    this.email,
    this.isEmailVerified,
    this.emailVerifiedAt,
    this.role,
    this.isSuspended,
    this.suspendedAt,
    this.suspendedReason,
    this.deletedAt,
    this.fcmTokens,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.fullNameNormalized,
    this.v,});

  Admin.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    position = json['position'];
    department = json['department'];
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedAt = json['emailVerifiedAt'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    suspendedAt = json['suspendedAt'];
    suspendedReason = json['suspendedReason'];
    deletedAt = json['deletedAt'];
    if (json['fcmTokens'] != null) {
      fcmTokens = [];
      json['fcmTokens'].forEach((v) {
        fcmTokens?.add(v as String);
      });
    }
    phone = json['phone'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    v = json['__v'];
  }
  Location? location;
  dynamic position;
  dynamic department;
  String? id;
  String? fullName;
  String? email;
  bool? isEmailVerified;
  String? emailVerifiedAt;
  String? role;
  bool? isSuspended;
  dynamic suspendedAt;
  dynamic suspendedReason;
  dynamic deletedAt;
  List<String>? fcmTokens;
  String? phone;
  dynamic address;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['position'] = position;
    map['department'] = department;
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['isEmailVerified'] = isEmailVerified;
    map['emailVerifiedAt'] = emailVerifiedAt;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['suspendedAt'] = suspendedAt;
    map['suspendedReason'] = suspendedReason;
    map['deletedAt'] = deletedAt;
    if (fcmTokens != null) {
      map['fcmTokens'] = fcmTokens;
    }
    map['phone'] = phone;
    map['address'] = address;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    return map;
  }

  Admin copyWith({
    Location? location,
    dynamic position,
    dynamic department,
    String? id,
    String? fullName,
    String? email,
    bool? isEmailVerified,
    String? emailVerifiedAt,
    String? role,
    bool? isSuspended,
    dynamic suspendedAt,
    dynamic suspendedReason,
    dynamic deletedAt,
    List<String>? fcmTokens,
    String? phone,
    dynamic address,
    String? createdAt,
    String? updatedAt,
    String? fullNameNormalized,
    int? v,
  }) {
    return Admin(
      location: location ?? this.location,
      position: position ?? this.position,
      department: department ?? this.department,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      role: role ?? this.role,
      isSuspended: isSuspended ?? this.isSuspended,
      suspendedAt: suspendedAt ?? this.suspendedAt,
      suspendedReason: suspendedReason ?? this.suspendedReason,
      deletedAt: deletedAt ?? this.deletedAt,
      fcmTokens: fcmTokens ?? this.fcmTokens,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fullNameNormalized: fullNameNormalized ?? this.fullNameNormalized,
      v: v ?? this.v,
    );
  }
}

/// coordinates : {"lat":30.0444,"lng":31.2357}
/// city : "Cairo"
/// governorate : "Cairo"
/// lastUpdated : "2026-06-25T22:30:49.147Z"

class Location {
  Location({
    this.coordinates,
    this.city,
    this.governorate,
    this.lastUpdated,});

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    city = json['city'];
    governorate = json['governorate'];
    lastUpdated = json['lastUpdated'];
  }
  Coordinates? coordinates;
  String? city;
  String? governorate;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }
    map['city'] = city;
    map['governorate'] = governorate;
    map['lastUpdated'] = lastUpdated;
    return map;
  }

  Location copyWith({
    Coordinates? coordinates,
    String? city,
    String? governorate,
    String? lastUpdated,
  }) {
    return Location(
      coordinates: coordinates ?? this.coordinates,
      city: city ?? this.city,
      governorate: governorate ?? this.governorate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// lat : 30.0444
/// lng : 31.2357

class Coordinates {
  Coordinates({
    this.lat,
    this.lng,});

  Coordinates.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

  Coordinates copyWith({
    double? lat,
    double? lng,
  }) {
    return Coordinates(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}