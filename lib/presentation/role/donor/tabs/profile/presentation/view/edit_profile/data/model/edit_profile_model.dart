class EditProfileModel {
  EditProfileModel({
    this.success,
    this.data,
  });

  EditProfileModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
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
    this.temporaryDeferralUntil,
    this.lastDeferralReason,
    this.phone,
    this.address,
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
    this.t,
    this.phoneNumber,
    this.bloodType,
    this.gender,
    this.isAvailable,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.travelHistory,
    this.hemoglobinLevel,
    this.weight,
    this.isBanned,
    this.availableToDonate,
    this.isVerified,
  });

  Data.fromJson(dynamic json) {
    healthHistory = json['healthHistory'] != null
        ? HealthHistory.fromJson(json['healthHistory'])
        : null;
    settings =
    json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    phone = json['phone'];
    address = json['address'];
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
    json['fcmTokens'] != null ? json['fcmTokens'].cast<String>() : [];
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    gender = json['gender'];
    isAvailable = json['isAvailable'];
    dateOfBirth = json['dateOfBirth'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    travelHistory = json['travelHistory'] != null
        ? List<dynamic>.from(json['travelHistory'])
        : [];
    hemoglobinLevel = json['hemoglobinLevel'];
    weight = json['weight'];
    isBanned = json['isBanned'];
    availableToDonate = json['availableToDonate'];
    isVerified = json['isVerified'];
    id = json['id'];
  }

  HealthHistory? healthHistory;
  Settings? settings;
  Location? location;
  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;
  dynamic phone;
  dynamic address;
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
  String? t;
  String? phoneNumber;
  String? bloodType;
  String? gender;
  bool? isAvailable;
  String? dateOfBirth;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<dynamic>? travelHistory;
  double? hemoglobinLevel;
  int? weight;
  bool? isBanned;
  bool? availableToDonate;
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
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    map['phone'] = phone;
    map['address'] = address;
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
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['gender'] = gender;
    map['isAvailable'] = isAvailable;
    map['dateOfBirth'] = dateOfBirth;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['travelHistory'] = travelHistory;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['weight'] = weight;
    map['isBanned'] = isBanned;
    map['availableToDonate'] = availableToDonate;
    map['isVerified'] = isVerified;
    map['id'] = id;
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
    allergies =
    json['allergies'] != null ? json['allergies'].cast<String>() : [];
    recentIllness = json['recentIllness'];
    notes = json['notes'];
    lastCheckupDate = json['lastCheckupDate'];
    updatedAt = json['updatedAt'];
  }

  List<dynamic>? chronicConditions;
  List<dynamic>? medications;
  List<String>? allergies;
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