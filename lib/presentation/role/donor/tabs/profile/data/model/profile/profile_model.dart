/// success : true
/// data : {"healthHistory":{"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"Nearby emergency responder for Cairo Care Hospital.","lastCheckupDate":"2026-05-03T07:00:00.000Z","updatedAt":"2026-05-15T19:32:56.422Z"},"settings":{"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"},"location":{"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo"},"_id":"6a06ea9888988a725cb260f0","fullName":"Ziyad Sobhy","email":"cairo.responder@lifelink.demo","isEmailVerified":true,"emailVerifiedAt":"2026-05-15T19:32:56.422Z","role":"donor","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":["f2d2tGOHRaWsSFK79-3hAt:APA91bFhFb8UfCr6YDjHABQtYGG0Sv8QIrYZdDEVucTuzpPTtPTvC39_7tdH_yPd3znslEmVIzpoyJ6XRvAiwDlSIU_WFMPhsjZqukU_KZAO0i7iHBNSVp0"],"phone":null,"address":null,"__t":"donor","phoneNumber":"01141935341","bloodType":"O+","dateOfBirth":"1995-05-15T00:00:00.000Z","gender":"male","weight":60,"hemoglobinLevel":14.2,"temporaryDeferralUntil":null,"lastDeferralReason":null,"isAvailable":true,"travelHistory":[],"createdAt":"2026-05-15T09:42:48.347Z","updatedAt":"2026-05-23T22:22:13.001Z","fullNameNormalized":"yasmine farouk","__v":1,"isBanned":false,"availableToDonate":true,"isVerified":true,"id":"6a06ea9888988a725cb260f0","verificationStatus":"verified","age":31,"stats":{"totalDonations":5,"points":0,"livesSaved":15},"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0,"badgeProgress":{"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0}}

class ProfileModel {
  ProfileModel({
      this.success, 
      this.data,});

  ProfileModel.fromJson(dynamic json) {
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

/// healthHistory : {"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"Nearby emergency responder for Cairo Care Hospital.","lastCheckupDate":"2026-05-03T07:00:00.000Z","updatedAt":"2026-05-15T19:32:56.422Z"}
/// settings : {"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"}
/// location : {"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo"}
/// _id : "6a06ea9888988a725cb260f0"
/// fullName : "Ziyad Sobhy"
/// email : "cairo.responder@lifelink.demo"
/// isEmailVerified : true
/// emailVerifiedAt : "2026-05-15T19:32:56.422Z"
/// role : "donor"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : ["f2d2tGOHRaWsSFK79-3hAt:APA91bFhFb8UfCr6YDjHABQtYGG0Sv8QIrYZdDEVucTuzpPTtPTvC39_7tdH_yPd3znslEmVIzpoyJ6XRvAiwDlSIU_WFMPhsjZqukU_KZAO0i7iHBNSVp0"]
/// phone : null
/// address : null
/// __t : "donor"
/// phoneNumber : "01141935341"
/// bloodType : "O+"
/// dateOfBirth : "1995-05-15T00:00:00.000Z"
/// gender : "male"
/// weight : 60
/// hemoglobinLevel : 14.2
/// temporaryDeferralUntil : null
/// lastDeferralReason : null
/// isAvailable : true
/// travelHistory : []
/// createdAt : "2026-05-15T09:42:48.347Z"
/// updatedAt : "2026-05-23T22:22:13.001Z"
/// fullNameNormalized : "yasmine farouk"
/// __v : 1
/// isBanned : false
/// availableToDonate : true
/// isVerified : true
/// id : "6a06ea9888988a725cb260f0"
/// verificationStatus : "verified"
/// age : 31
/// stats : {"totalDonations":5,"points":0,"livesSaved":15}
/// currentBadge : null
/// nextBadge : "First Timer"
/// progressPercentage : 0
/// badgeProgress : {"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0}

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
      this.badgeProgress,});

  Data.fromJson(dynamic json) {
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
    fcmTokens = json['fcmTokens'] != null ? json['fcmTokens'].cast<String>() : [];
    phone = json['phone'];
    address = json['address'];
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    isAvailable = json['isAvailable'];
    if (json['travelHistory'] != null) {
       travelHistory = [];
       json['travelHistory'].forEach((v) {
         travelHistory?.add(v);
       });
     }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    v = json['__v'];
    isBanned = json['isBanned'];
    availableToDonate = json['availableToDonate'];
    isVerified = json['isVerified'];
    id = json['id'];
    verificationStatus = json['verificationStatus'];
    age = json['age'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    currentBadge = json['currentBadge'];
    nextBadge = json['nextBadge'];
    progressPercentage = json['progressPercentage'];
    badgeProgress = json['badgeProgress'] != null ? BadgeProgress.fromJson(json['badgeProgress']) : null;
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
    if (travelHistory != null) {
      map['travelHistory'] = travelHistory?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['isBanned'] = isBanned;
    map['availableToDonate'] = availableToDonate;
    map['isVerified'] = isVerified;
    map['id'] = id;
    map['verificationStatus'] = verificationStatus;
    map['age'] = age;
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    map['currentBadge'] = currentBadge;
    map['nextBadge'] = nextBadge;
    map['progressPercentage'] = progressPercentage;
    if (badgeProgress != null) {
      map['badgeProgress'] = badgeProgress?.toJson();
    }
    return map;
  }

}

/// currentBadge : null
/// nextBadge : "First Timer"
/// progressPercentage : 0

class BadgeProgress {
  BadgeProgress({
      this.currentBadge, 
      this.nextBadge, 
      this.progressPercentage,});

  BadgeProgress.fromJson(dynamic json) {
    currentBadge = json['currentBadge'];
    nextBadge = json['nextBadge'];
    progressPercentage = json['progressPercentage'];
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

/// totalDonations : 5
/// points : 0
/// livesSaved : 15

class Stats {
  Stats({
      this.totalDonations, 
      this.points, 
      this.livesSaved,});

  Stats.fromJson(dynamic json) {
    totalDonations = json['totalDonations'];
    points = json['points'];
    livesSaved = json['livesSaved'];
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

/// coordinates : {"lat":30.0444,"lng":31.2357}
/// city : "Cairo"
/// governorate : "Cairo"

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

}

/// pushNotifications : true
/// emergencyAlerts : true
/// privacyMode : false
/// language : "en"

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

/// chronicConditions : []
/// medications : []
/// allergies : []
/// recentIllness : ""
/// notes : "Nearby emergency responder for Cairo Care Hospital."
/// lastCheckupDate : "2026-05-03T07:00:00.000Z"
/// updatedAt : "2026-05-15T19:32:56.422Z"

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
       chronicConditions = [];
       json['chronicConditions'].forEach((v) {
         chronicConditions?.add(v);
       });
     }
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
  List<dynamic>? chronicConditions;
  List<dynamic>? medications;
  List<dynamic>? allergies;
  String? recentIllness;
  String? notes;
  String? lastCheckupDate;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chronicConditions != null) {
      map['chronicConditions'] = chronicConditions?.map((v) => v.toJson()).toList();
    }
    if (medications != null) {
      map['medications'] = medications?.map((v) => v.toJson()).toList();
    }
    if (allergies != null) {
      map['allergies'] = allergies?.map((v) => v.toJson()).toList();
    }
    map['recentIllness'] = recentIllness;
    map['notes'] = notes;
    map['lastCheckupDate'] = lastCheckupDate;
    map['updatedAt'] = updatedAt;
    return map;
  }

}