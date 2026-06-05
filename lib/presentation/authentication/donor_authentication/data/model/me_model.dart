class MeModel {
  MeModel({
    this.success,
    this.message,
    this.data,
  });

  MeModel.fromJson(dynamic json) {
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

class Data {
  Data({
    this.healthHistory,
    this.settings,
    this.location,
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
    this.t,
    this.phoneNumber,
    this.bloodType,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.hemoglobinLevel,
    this.temporaryDeferralUntil,
    this.lastDeferralReason,
    this.isAvailable,
    this.travelHistory,
    this.createdAt,
    this.updatedAt,
    this.fullNameNormalized,
    this.v,
    this.isOptedIn,
    this.isBanned,
    this.isVerified,
  });

  Data.fromJson(dynamic json) {
    healthHistory = json['healthHistory'] != null
        ? HealthHistory.fromJson(json['healthHistory'])
        : null;

    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;

    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;

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

    fcmTokens =
    json['fcmTokens'] != null ? List<String>.from(json['fcmTokens']) : [];

    phone = json['phone'];
    address = json['address'];

    t = json['__t'];

    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];

    weight = json['weight'];

    hemoglobinLevel = json['hemoglobinLevel']?.toDouble();

    temporaryDeferralUntil = json['temporaryDeferralUntil'];

    lastDeferralReason = json['lastDeferralReason'];

    isAvailable = json['isAvailable'];

    travelHistory = json['travelHistory'] != null
        ? List<dynamic>.from(json['travelHistory'])
        : [];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    fullNameNormalized = json['fullNameNormalized'];

    v = json['__v'];

    isOptedIn = json['isOptedIn'];
    isBanned = json['isBanned'];
    isVerified = json['isVerified'];
  }

  HealthHistory? healthHistory;
  Settings? settings;
  Location? location;

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

  dynamic phone;
  dynamic address;

  String? t;

  String? phoneNumber;
  String? bloodType;
  String? dateOfBirth;
  String? gender;

  int? weight;
  double? hemoglobinLevel;

  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;

  bool? isAvailable;

  List<dynamic>? travelHistory;

  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;

  int? v;

  bool? isOptedIn;
  bool? isBanned;
  bool? isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (healthHistory != null) {
      map['healthHistory'] = healthHistory?.toJson();
    }

    if (settings != null) {
      map['settings'] = settings?.toJson();
    }

    if (location != null) {
      map['location'] = location?.toJson();
    }

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
    map['fcmTokens'] = fcmTokens;
    map['phone'] = phone;
    map['address'] = address;
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    map['isAvailable'] = isAvailable;
    map['travelHistory'] = travelHistory;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['isOptedIn'] = isOptedIn;
    map['isBanned'] = isBanned;
    map['isVerified'] = isVerified;

    return map;
  }
}

class Location {
  Location({
    this.coordinates,
    this.city,
    this.governorate,
  });

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;

    city = json['city'];
    governorate = json['governorate'];
  }

  Coordinates? coordinates;
  String? city;
  String? governorate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }

    map['city'] = city;
    map['governorate'] = governorate;

    return map;
  }
}

class Coordinates {
  Coordinates({
    this.lat,
    this.lng,
  });

  Coordinates.fromJson(dynamic json) {
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
  }

  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['lat'] = lat;
    map['lng'] = lng;

    return map;
  }
}

class Settings {
  Settings({
    this.pushNotifications,
    this.emergencyAlerts,
    this.privacyMode,
    this.language,
  });

  Settings.fromJson(dynamic json) {
    pushNotifications = json['pushNotifications'];
    emergencyAlerts = json['emergencyAlerts'];
    privacyMode = json['privacyMode'];
    language = json['language'];
  }

  bool? pushNotifications;
  bool? emergencyAlerts;
  bool? privacyMode;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['pushNotifications'] = pushNotifications;
    map['emergencyAlerts'] = emergencyAlerts;
    map['privacyMode'] = privacyMode;
    map['language'] = language;

    return map;
  }
}

class HealthHistory {
  HealthHistory({
    this.chronicConditions,
    this.medications,
    this.allergies,
    this.recentIllness,
    this.notes,
    this.lastCheckupDate,
    this.updatedAt,
  });

  HealthHistory.fromJson(dynamic json) {
    chronicConditions = json['chronicConditions'] != null
        ? List<dynamic>.from(json['chronicConditions'])
        : [];

    medications = json['medications'] != null
        ? List<dynamic>.from(json['medications'])
        : [];

    allergies = json['allergies'] != null
        ? List<dynamic>.from(json['allergies'])
        : [];

    recentIllness = json['recentIllness'];
    notes = json['notes'];
    lastCheckupDate = json['lastCheckupDate'];
    updatedAt = json['updatedAt'];
  }

  List<dynamic>? chronicConditions;
  List<dynamic>? medications;
  List<dynamic>? allergies;

  String? recentIllness;
  String? notes;
  String? lastCheckupDate;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['chronicConditions'] = chronicConditions;
    map['medications'] = medications;
    map['allergies'] = allergies;
    map['recentIllness'] = recentIllness;
    map['notes'] = notes;
    map['lastCheckupDate'] = lastCheckupDate;
    map['updatedAt'] = updatedAt;

    return map;
  }
}