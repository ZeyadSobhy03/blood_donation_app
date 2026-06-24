class UsersModel {
  UsersModel({
    this.success,
    this.message,
    this.data,});

  UsersModel.fromJson(dynamic json) {
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
    this.users,
    this.pagination,
    this.stats,});

  Data.fromJson(dynamic json) {
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }
  List<Users>? users;
  Pagination? pagination;
  Stats? stats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    return map;
  }

}

class Stats {
  Stats({
    this.totalUsers,
    this.totalDonors,
    this.totalHospitals,
    this.totalAdmins,
    this.verifiedUsers,
    this.unverifiedUsers,
    this.suspendedUsers,
    this.totalUsersGrowth,
    this.totalDonorsGrowth,
    this.totalHospitalsGrowth,
    this.verifiedUsersGrowth,
    this.suspendedUsersGrowth,
    this.aiInsights,});

  Stats.fromJson(dynamic json) {
    totalUsers = json['totalUsers'];
    totalDonors = json['totalDonors'];
    totalHospitals = json['totalHospitals'];
    totalAdmins = json['totalAdmins'];
    verifiedUsers = json['verifiedUsers'];
    unverifiedUsers = json['unverifiedUsers'];
    suspendedUsers = json['suspendedUsers'];
    totalUsersGrowth = json['totalUsersGrowth'];
    totalDonorsGrowth = json['totalDonorsGrowth'];
    totalHospitalsGrowth = json['totalHospitalsGrowth'];
    verifiedUsersGrowth = json['verifiedUsersGrowth'];
    suspendedUsersGrowth = json['suspendedUsersGrowth'];
    if (json['aiInsights'] != null) {
      aiInsights = [];
      json['aiInsights'].forEach((v) {
        aiInsights?.add(AiInsights.fromJson(v));
      });
    }
  }
  int? totalUsers;
  int? totalDonors;
  int? totalHospitals;
  int? totalAdmins;
  int? verifiedUsers;
  int? unverifiedUsers;
  int? suspendedUsers;
  String? totalUsersGrowth;
  String? totalDonorsGrowth;
  String? totalHospitalsGrowth;
  String? verifiedUsersGrowth;
  String? suspendedUsersGrowth;
  List<AiInsights>? aiInsights;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalUsers'] = totalUsers;
    map['totalDonors'] = totalDonors;
    map['totalHospitals'] = totalHospitals;
    map['totalAdmins'] = totalAdmins;
    map['verifiedUsers'] = verifiedUsers;
    map['unverifiedUsers'] = unverifiedUsers;
    map['suspendedUsers'] = suspendedUsers;
    map['totalUsersGrowth'] = totalUsersGrowth;
    map['totalDonorsGrowth'] = totalDonorsGrowth;
    map['totalHospitalsGrowth'] = totalHospitalsGrowth;
    map['verifiedUsersGrowth'] = verifiedUsersGrowth;
    map['suspendedUsersGrowth'] = suspendedUsersGrowth;
    if (aiInsights != null) {
      map['aiInsights'] = aiInsights?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AiInsights {
  AiInsights({
    this.title,
    this.description,
    this.confidence,});

  AiInsights.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    confidence = json['confidence'];
  }
  String? title;
  String? description;
  double? confidence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['confidence'] = confidence;
    return map;
  }

}

class Pagination {
  Pagination({
    this.total,
    this.page,
    this.currentPage,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
  int? total;
  int? page;
  int? currentPage;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['currentPage'] = currentPage;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }

}

class Users {
  Users({
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
    this.position,
    this.department,
    this.t,
    this.phoneNumber,
    this.bloodType,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.hemoglobinLevel,
    this.temporaryDeferralUntil,
    this.lastDeferralReason,
    this.isOptedIn,
    this.travelHistory,
    this.createdAt,
    this.updatedAt,
    this.fullNameNormalized,
    this.v,
    this.isBanned,
    this.isVerified,
    this.totalDonations,
    this.completedDonations,
    this.pointsBalance,
    this.lifetimePointsEarned,
    this.tier,
    this.eligibilitySummary,
    this.name,
    this.isActive,
    this.joinedAt,});

  Users.fromJson(dynamic json) {
    healthHistory = json['healthHistory'] != null ? HealthHistory.fromJson(json['healthHistory']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
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
      fcmTokens = List<dynamic>.from(json['fcmTokens']);
    }
    phone = json['phone'];
    address = json['address'];
    position = json['position'];
    department = json['department'];
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    isOptedIn = json['isOptedIn'];
    if (json['travelHistory'] != null) {
      travelHistory = List<dynamic>.from(json['travelHistory']);
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    v = json['__v'];
    isBanned = json['isBanned'];
    isVerified = json['isVerified'];
    id = json['id'];
    totalDonations = json['totalDonations'];
    completedDonations = json['completedDonations'];
    pointsBalance = json['pointsBalance'];
    lifetimePointsEarned = json['lifetimePointsEarned'];
    tier = json['tier'];
    eligibilitySummary = json['eligibilitySummary'] != null ? EligibilitySummary.fromJson(json['eligibilitySummary']) : null;
    name = json['name'];
    isActive = json['isActive'];
    joinedAt = json['joinedAt'];
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
  List<dynamic>? fcmTokens;
  String? phone;
  dynamic address;
  dynamic position;
  dynamic department;
  String? t;
  String? phoneNumber;
  String? bloodType;
  String? dateOfBirth;
  String? gender;
  dynamic weight;
  dynamic hemoglobinLevel;
  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;
  bool? isOptedIn;
  List<dynamic>? travelHistory;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  int? v;
  bool? isBanned;
  bool? isVerified;
  int? totalDonations;
  int? completedDonations;
  int? pointsBalance;
  int? lifetimePointsEarned;
  String? tier;
  EligibilitySummary? eligibilitySummary;
  String? name;
  bool? isActive;
  String? joinedAt;

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
    if (fcmTokens != null) {
      map['fcmTokens'] = fcmTokens;
    }
    map['phone'] = phone;
    map['address'] = address;
    map['position'] = position;
    map['department'] = department;
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    map['isOptedIn'] = isOptedIn;
    if (travelHistory != null) {
      map['travelHistory'] = travelHistory;
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['isBanned'] = isBanned;
    map['isVerified'] = isVerified;
    map['id'] = id;
    map['totalDonations'] = totalDonations;
    map['completedDonations'] = completedDonations;
    map['pointsBalance'] = pointsBalance;
    map['lifetimePointsEarned'] = lifetimePointsEarned;
    map['tier'] = tier;
    if (eligibilitySummary != null) {
      map['eligibilitySummary'] = eligibilitySummary?.toJson();
    }
    map['name'] = name;
    map['isActive'] = isActive;
    map['joinedAt'] = joinedAt;
    return map;
  }

}

class EligibilitySummary {
  EligibilitySummary({
    this.eligible,
    this.reason,
    this.nextEligibleDate,});

  EligibilitySummary.fromJson(dynamic json) {
    eligible = json['eligible'];
    reason = json['reason'];
    nextEligibleDate = json['nextEligibleDate'];
  }
  bool? eligible;
  String? reason;
  dynamic nextEligibleDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eligible'] = eligible;
    map['reason'] = reason;
    map['nextEligibleDate'] = nextEligibleDate;
    return map;
  }

}

class Location {
  Location({
    this.coordinates,
    this.city,
    this.governorate,});

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
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

}

class Settings {
  Settings({
    this.pushNotifications,
    this.emergencyAlerts,
    this.privacyMode,
    this.language,});

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
    this.updatedAt,});

  HealthHistory.fromJson(dynamic json) {
    if (json['chronicConditions'] != null) {
      chronicConditions = List<dynamic>.from(json['chronicConditions']);
    }
    if (json['medications'] != null) {
      medications = List<dynamic>.from(json['medications']);
    }
    if (json['allergies'] != null) {
      allergies = List<dynamic>.from(json['allergies']);
    }
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
  dynamic lastCheckupDate;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chronicConditions != null) {
      map['chronicConditions'] = chronicConditions;
    }
    if (medications != null) {
      map['medications'] = medications;
    }
    if (allergies != null) {
      map['allergies'] = allergies;
    }
    map['recentIllness'] = recentIllness;
    map['notes'] = notes;
    map['lastCheckupDate'] = lastCheckupDate;
    map['updatedAt'] = updatedAt;
    return map;
  }

}