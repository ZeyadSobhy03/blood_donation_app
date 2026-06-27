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
    this.suspendedUsersGrowth,});

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
    this.createdAt,
    this.updatedAt,
    this.fullNameNormalized,
    this.v,
    this.name,
    this.phoneNumber,
    this.bloodType,
    this.isActive,
    this.isVerified,
    this.joinedAt,
    this.totalDonations,
    this.t,
    this.type,
    this.hospitalType,
    this.workingHours,
    this.city,
    this.state,
    this.zipCode,
    this.hospitalId,
    this.licenseNumber,
    this.adminContactName,
    this.adminContactPhone,
    this.emergencyContact,
    this.bloodBanksAvailable,
    this.contactNumber,
    this.capacity,
    this.lat,
    this.long,
    this.hospitalName,
    this.slotsPerHour,
    this.workingHoursStart,
    this.workingHoursEnd,
    this.hospitalNameNormalized,
    this.lastDonationDate,
    this.isBanned,
    this.completedDonations,
    this.pointsBalance,
    this.lifetimePointsEarned,
    this.tier,
    this.eligibilitySummary,
    this.healthHistory,
    this.settings,
    this.location,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.hemoglobinLevel,
    this.temporaryDeferralUntil,
    this.lastDeferralReason,
    this.isOptedIn,
    this.missedDonationCount,
    this.missedDonationDates,
    this.travelHistory,});

  Users.fromJson(dynamic json) {
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
        fcmTokens?.add(v);
      });
    }
    phone = json['phone'];
    address = json['address'];
    position = json['position'];
    department = json['department'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    v = json['__v'];
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    joinedAt = json['joinedAt'];
    totalDonations = json['totalDonations'];
    t = json['__t'];
    type = json['type'];
    hospitalType = json['hospitalType'];
    workingHours = json['workingHours'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    hospitalId = json['hospitalId'];
    licenseNumber = json['licenseNumber'];
    adminContactName = json['adminContactName'];
    adminContactPhone = json['adminContactPhone'];
    emergencyContact = json['emergencyContact'];
    if (json['bloodBanksAvailable'] != null) {
      bloodBanksAvailable = [];
      json['bloodBanksAvailable'].forEach((v) {
        bloodBanksAvailable?.add(v);
      });
    }
    contactNumber = json['contactNumber'];
    capacity = json['capacity'];
    lat = json['lat'];
    long = json['long'];
    hospitalName = json['hospitalName'];
    slotsPerHour = json['slotsPerHour'];
    workingHoursStart = json['workingHoursStart'];
    workingHoursEnd = json['workingHoursEnd'];
    hospitalNameNormalized = json['hospitalNameNormalized'];
    lastDonationDate = json['lastDonationDate'];
    isBanned = json['isBanned'];
    completedDonations = json['completedDonations'];
    pointsBalance = json['pointsBalance'];
    lifetimePointsEarned = json['lifetimePointsEarned'];
    tier = json['tier'];
    eligibilitySummary = json['eligibilitySummary'] != null ? EligibilitySummary.fromJson(json['eligibilitySummary']) : null;
    healthHistory = json['healthHistory'] != null ? HealthHistory.fromJson(json['healthHistory']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    isOptedIn = json['isOptedIn'];
    missedDonationCount = json['missedDonationCount'];
    if (json['missedDonationDates'] != null) {
      missedDonationDates = [];
      json['missedDonationDates'].forEach((v) {
        missedDonationDates?.add(v);
      });
    }
    if (json['travelHistory'] != null) {
      travelHistory = [];
      json['travelHistory'].forEach((v) {
        travelHistory?.add(v);
      });
    }
  }
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
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  int? v;
  String? name;
  String? phoneNumber;
  dynamic bloodType;
  bool? isActive;
  bool? isVerified;
  String? joinedAt;
  int? totalDonations;
  String? t;
  String? type;
  String? hospitalType;
  String? workingHours;
  String? city;
  String? state;
  String? zipCode;
  String? hospitalId;
  String? licenseNumber;
  String? adminContactName;
  String? adminContactPhone;
  String? emergencyContact;
  List<dynamic>? bloodBanksAvailable;
  String? contactNumber;
  int? capacity;
  double? lat;
  double? long;
  String? hospitalName;
  int? slotsPerHour;
  int? workingHoursStart;
  int? workingHoursEnd;
  String? hospitalNameNormalized;
  String? lastDonationDate;
  bool? isBanned;
  int? completedDonations;
  int? pointsBalance;
  int? lifetimePointsEarned;
  String? tier;
  EligibilitySummary? eligibilitySummary;
  HealthHistory? healthHistory;
  Settings? settings;
  Location? location;
  String? dateOfBirth;
  String? gender;
  int? weight;
  double? hemoglobinLevel;
  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;
  bool? isOptedIn;
  int? missedDonationCount;
  List<dynamic>? missedDonationDates;
  List<dynamic>? travelHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['id'] = id;
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['isActive'] = isActive;
    map['isVerified'] = isVerified;
    map['joinedAt'] = joinedAt;
    map['totalDonations'] = totalDonations;
    map['__t'] = t;
    map['type'] = type;
    map['hospitalType'] = hospitalType;
    map['workingHours'] = workingHours;
    map['city'] = city;
    map['state'] = state;
    map['zipCode'] = zipCode;
    map['hospitalId'] = hospitalId;
    map['licenseNumber'] = licenseNumber;
    map['adminContactName'] = adminContactName;
    map['adminContactPhone'] = adminContactPhone;
    map['emergencyContact'] = emergencyContact;
    if (bloodBanksAvailable != null) {
      map['bloodBanksAvailable'] = bloodBanksAvailable;
    }
    map['contactNumber'] = contactNumber;
    map['capacity'] = capacity;
    map['lat'] = lat;
    map['long'] = long;
    map['hospitalName'] = hospitalName;
    map['slotsPerHour'] = slotsPerHour;
    map['workingHoursStart'] = workingHoursStart;
    map['workingHoursEnd'] = workingHoursEnd;
    map['hospitalNameNormalized'] = hospitalNameNormalized;
    map['lastDonationDate'] = lastDonationDate;
    map['isBanned'] = isBanned;
    map['completedDonations'] = completedDonations;
    map['pointsBalance'] = pointsBalance;
    map['lifetimePointsEarned'] = lifetimePointsEarned;
    map['tier'] = tier;
    if (eligibilitySummary != null) {
      map['eligibilitySummary'] = eligibilitySummary?.toJson();
    }
    if (healthHistory != null) {
      map['healthHistory'] = healthHistory?.toJson();
    }
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    map['isOptedIn'] = isOptedIn;
    map['missedDonationCount'] = missedDonationCount;
    if (missedDonationDates != null) {
      map['missedDonationDates'] = missedDonationDates;
    }
    if (travelHistory != null) {
      map['travelHistory'] = travelHistory;
    }
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
    chronicConditions = json['chronicConditions'] != null ? json['chronicConditions'].cast<String>() : [];
    if (json['medications'] != null) {
      medications = [];
      json['medications'].forEach((v) {
        medications?.add(v);
      });
    }
    if (json['allergies'] != null) {
      allergies = [];
      json['allergies'].forEach((v) {
        allergies?.add(v);
      });
    }
    recentIllness = json['recentIllness'];
    notes = json['notes'];
    lastCheckupDate = json['lastCheckupDate'];
    updatedAt = json['updatedAt'];
  }
  List<String>? chronicConditions;
  List<dynamic>? medications;
  List<dynamic>? allergies;
  String? recentIllness;
  String? notes;
  String? lastCheckupDate;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chronicConditions'] = chronicConditions;
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