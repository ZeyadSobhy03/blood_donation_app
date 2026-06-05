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
      map['data'] = data!.toJson();
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
    this.isBanned,
    this.availableToDonate,
    this.isVerified,
    this.verificationStatus,
    this.age,
    this.stats,
    this.currentBadge,
    this.nextBadge,
    this.progressPercentage,
    this.badgeProgress,
  });

  Data.fromJson(dynamic json) {
    healthHistory = json['healthHistory'] != null
        ? HealthHistory.fromJson(json['healthHistory'])
        : null;

    settings =
    json['settings'] != null ? Settings.fromJson(json['settings']) : null;

    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;

    id = json['_id'] ?? json['id'];

    fullName = json['fullName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedAt = json['emailVerifiedAt'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    suspendedAt = json['suspendedAt'];
    suspendedReason = json['suspendedReason'];
    deletedAt = json['deletedAt'];

    fcmTokens = [];
    if (json['fcmTokens'] != null && json['fcmTokens'] is List) {
      try {
        fcmTokens = List<String>.from(json['fcmTokens']);
      } catch (e) {
        // If casting fails, try to convert each item to string
        try {
          fcmTokens = (json['fcmTokens'] as List)
              .map((item) => item?.toString() ?? '')
              .toList();
        } catch (_) {
          fcmTokens = [];
        }
      }
    }

    phone = json['phone'];
    address = json['address'];

    t = json['__t'];

    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];

    weight = null;
    if (json['weight'] != null) {
      if (json['weight'] is int) {
        weight = json['weight'];
      } else if (json['weight'] is double) {
        weight = (json['weight'] as double).toInt();
      } else if (json['weight'] is String) {
        weight = int.tryParse(json['weight'] as String);
      } else if (json['weight'] is num) {
        weight = (json['weight'] as num).toInt();
      }
    }

    hemoglobinLevel = (json['hemoglobinLevel'] as num?)?.toDouble();

    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];

    isAvailable = json['isAvailable'];

    travelHistory = [];
    if (json['travelHistory'] != null && json['travelHistory'] is List) {
      try {
        travelHistory = List<dynamic>.from(json['travelHistory']);
      } catch (_) {
        travelHistory = [];
      }
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    fullNameNormalized = json['fullNameNormalized'];

    v = json['__v'];

    isBanned = json['isBanned'];
    availableToDonate = json['availableToDonate'];
    isVerified = json['isVerified'];

    verificationStatus = json['verificationStatus'];

    age = json['age'];

    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;

    currentBadge = json['currentBadge'];
    nextBadge = json['nextBadge'];

    progressPercentage = null;
    if (json['progressPercentage'] != null) {
      if (json['progressPercentage'] is int) {
        progressPercentage = json['progressPercentage'];
      } else if (json['progressPercentage'] is double) {
        progressPercentage = (json['progressPercentage'] as double).toInt();
      } else if (json['progressPercentage'] is String) {
        progressPercentage = int.tryParse(json['progressPercentage'] as String);
      } else if (json['progressPercentage'] is num) {
        progressPercentage = (json['progressPercentage'] as num).toInt();
      }
    }

    badgeProgress = json['badgeProgress'] != null
        ? BadgeProgress.fromJson(json['badgeProgress'])
        : null;
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

  bool? isBanned;
  bool? availableToDonate;
  bool? isVerified;

  String? verificationStatus;

  int? age;

  Stats? stats;

  dynamic currentBadge;

  String? nextBadge;

  int? progressPercentage;

  BadgeProgress? badgeProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (healthHistory != null) {
      map['healthHistory'] = healthHistory!.toJson();
    }

    if (settings != null) {
      map['settings'] = settings!.toJson();
    }

    if (location != null) {
      map['location'] = location!.toJson();
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

    /// FIXED
    map['travelHistory'] = travelHistory;

    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;

    map['fullNameNormalized'] = fullNameNormalized;

    map['__v'] = v;

    map['isBanned'] = isBanned;
    map['availableToDonate'] = availableToDonate;
    map['isVerified'] = isVerified;

    map['verificationStatus'] = verificationStatus;

    map['age'] = age;

    if (stats != null) {
      map['stats'] = stats!.toJson();
    }

    map['currentBadge'] = currentBadge;
    map['nextBadge'] = nextBadge;

    map['progressPercentage'] = progressPercentage;

    if (badgeProgress != null) {
      map['badgeProgress'] = badgeProgress!.toJson();
    }

    return map;
  }
}

class BadgeProgress {
  BadgeProgress({
    this.currentBadge,
    this.nextBadge,
    this.progressPercentage,
  });

  BadgeProgress.fromJson(dynamic json) {
    currentBadge = json['currentBadge'];
    nextBadge = json['nextBadge'];
    progressPercentage = null;
    if (json['progressPercentage'] != null) {
      if (json['progressPercentage'] is int) {
        progressPercentage = json['progressPercentage'];
      } else if (json['progressPercentage'] is double) {
        progressPercentage = (json['progressPercentage'] as double).toInt();
      } else if (json['progressPercentage'] is String) {
        progressPercentage = int.tryParse(json['progressPercentage'] as String);
      } else if (json['progressPercentage'] is num) {
        progressPercentage = (json['progressPercentage'] as num).toInt();
      }
    }
  }

  dynamic currentBadge;
  String? nextBadge;
  int? progressPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['currentBadge'] = currentBadge;
    map['nextBadge'] = nextBadge;
    map['progressPercentage'] = progressPercentage;

    return map;
  }
}

class Stats {
  Stats({
    this.totalDonations,
    this.points,
    this.livesSaved,
  });

  Stats.fromJson(dynamic json) {
    totalDonations = null;
    if (json['totalDonations'] != null) {
      if (json['totalDonations'] is int) {
        totalDonations = json['totalDonations'];
      } else if (json['totalDonations'] is double) {
        totalDonations = (json['totalDonations'] as double).toInt();
      } else if (json['totalDonations'] is String) {
        totalDonations = int.tryParse(json['totalDonations'] as String);
      } else if (json['totalDonations'] is num) {
        totalDonations = (json['totalDonations'] as num).toInt();
      }
    }

    points = null;
    if (json['points'] != null) {
      if (json['points'] is int) {
        points = json['points'];
      } else if (json['points'] is double) {
        points = (json['points'] as double).toInt();
      } else if (json['points'] is String) {
        points = int.tryParse(json['points'] as String);
      } else if (json['points'] is num) {
        points = (json['points'] as num).toInt();
      }
    }

    livesSaved = null;
    if (json['livesSaved'] != null) {
      if (json['livesSaved'] is int) {
        livesSaved = json['livesSaved'];
      } else if (json['livesSaved'] is double) {
        livesSaved = (json['livesSaved'] as double).toInt();
      } else if (json['livesSaved'] is String) {
        livesSaved = int.tryParse(json['livesSaved'] as String);
      } else if (json['livesSaved'] is num) {
        livesSaved = (json['livesSaved'] as num).toInt();
      }
    }
  }

  int? totalDonations;
  int? points;
  int? livesSaved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['totalDonations'] = totalDonations;
    map['points'] = points;
    map['livesSaved'] = livesSaved;

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
      map['coordinates'] = coordinates!.toJson();
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
    lat = (json['lat'] as num?)?.toDouble();
    lng = (json['lng'] as num?)?.toDouble();
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
    chronicConditions = [];
    if (json['chronicConditions'] != null && json['chronicConditions'] is List) {
      try {
        chronicConditions = List<dynamic>.from(json['chronicConditions']);
      } catch (_) {
        chronicConditions = [];
      }
    }

    medications = [];
    if (json['medications'] != null && json['medications'] is List) {
      try {
        medications = List<dynamic>.from(json['medications']);
      } catch (_) {
        medications = [];
      }
    }

    allergies = [];
    if (json['allergies'] != null && json['allergies'] is List) {
      try {
        allergies = List<dynamic>.from(json['allergies']);
      } catch (_) {
        allergies = [];
      }
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
  String? lastCheckupDate;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    /// FIXED
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