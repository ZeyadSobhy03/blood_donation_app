/// success : true
/// data : {"healthHistory":{"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null},"settings":{"privacy":"public","emergencyAlerts":true,"language":"en","privacyMode":false,"pushNotifications":true},"location":{"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T13:40:27.463Z"},"weight":null,"hemoglobinLevel":null,"temporaryDeferralUntil":null,"lastDeferralReason":null,"phone":null,"address":null,"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","isEmailVerified":true,"emailVerifiedAt":"2026-05-08T13:40:27.463Z","role":"donor","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"__t":"donor","phoneNumber":"01011111111","bloodType":"O+","gender":"female","isAvailable":true,"dateOfBirth":"1996-03-12T00:00:00.000Z","createdAt":"2026-04-30T23:02:41.312Z","updatedAt":"2026-05-08T13:40:34.040Z","__v":1,"travelHistory":[],"isBanned":false,"availableToDonate":true,"isVerified":true,"id":"69f3df915f42685cbbbcbb18","verificationStatus":"verified","age":30,"stats":{"totalDonations":1,"points":850,"livesSaved":3},"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0,"badgeProgress":{"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0}}

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

/// healthHistory : {"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null}
/// settings : {"privacy":"public","emergencyAlerts":true,"language":"en","privacyMode":false,"pushNotifications":true}
/// location : {"coordinates":{"lat":30.0444,"lng":31.2357},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T13:40:27.463Z"}
/// weight : null
/// hemoglobinLevel : null
/// temporaryDeferralUntil : null
/// lastDeferralReason : null
/// phone : null
/// address : null
/// _id : "69f3df915f42685cbbbcbb18"
/// fullName : "Aya Hassan"
/// email : "aya.hassan@lifelink.demo"
/// isEmailVerified : true
/// emailVerifiedAt : "2026-05-08T13:40:27.463Z"
/// role : "donor"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : []
/// __t : "donor"
/// phoneNumber : "01011111111"
/// bloodType : "O+"
/// gender : "female"
/// isAvailable : true
/// dateOfBirth : "1996-03-12T00:00:00.000Z"
/// createdAt : "2026-04-30T23:02:41.312Z"
/// updatedAt : "2026-05-08T13:40:34.040Z"
/// __v : 1
/// travelHistory : []
/// isBanned : false
/// availableToDonate : true
/// isVerified : true
/// id : "69f3df915f42685cbbbcbb18"
/// verificationStatus : "verified"
/// age : 30
/// stats : {"totalDonations":1,"points":850,"livesSaved":3}
/// currentBadge : null
/// nextBadge : "First Timer"
/// progressPercentage : 0
/// badgeProgress : {"currentBadge":null,"nextBadge":"First Timer","progressPercentage":0}

class Data {
  Data({
      this.healthHistory, 
      this.settings, 
      this.location, 
      this.weight, 
      this.hemoglobinLevel, 
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
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
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
    if (json['fcmTokens'] != null) {
      fcmTokens = json['fcmTokens'] is List
          ? List<dynamic>.from(json['fcmTokens'])
          : <dynamic>[];
    }
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    gender = json['gender'];
    isAvailable = json['isAvailable'];
    dateOfBirth = json['dateOfBirth'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    if (json['travelHistory'] != null) {
      travelHistory = json['travelHistory'] is List
          ? List<dynamic>.from(json['travelHistory'])
          : <dynamic>[];
    }
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
  dynamic weight;
  dynamic hemoglobinLevel;
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
  List<dynamic>? fcmTokens;
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
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
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
    if (fcmTokens != null) {
      map['fcmTokens'] = List<dynamic>.from(fcmTokens!);
    }
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['gender'] = gender;
    map['isAvailable'] = isAvailable;
    map['dateOfBirth'] = dateOfBirth;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    if (travelHistory != null) {
      map['travelHistory'] = List<dynamic>.from(travelHistory!);
    }
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

/// totalDonations : 1
/// points : 850
/// livesSaved : 3

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
/// lastUpdated : "2026-05-08T13:40:27.463Z"

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

/// privacy : "public"
/// emergencyAlerts : true
/// language : "en"
/// privacyMode : false
/// pushNotifications : true

class Settings {
  Settings({
      this.privacy, 
      this.emergencyAlerts, 
      this.language, 
      this.privacyMode, 
      this.pushNotifications,});

  Settings.fromJson(dynamic json) {
    privacy = json['privacy'];
    emergencyAlerts = json['emergencyAlerts'];
    language = json['language'];
    privacyMode = json['privacyMode'];
    pushNotifications = json['pushNotifications'];
  }
  String? privacy;
  bool? emergencyAlerts;
  String? language;
  bool? privacyMode;
  bool? pushNotifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['privacy'] = privacy;
    map['emergencyAlerts'] = emergencyAlerts;
    map['language'] = language;
    map['privacyMode'] = privacyMode;
    map['pushNotifications'] = pushNotifications;
    return map;
  }

}

/// chronicConditions : []
/// medications : []
/// allergies : []
/// recentIllness : ""
/// notes : ""
/// lastCheckupDate : null
/// updatedAt : null

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
      chronicConditions = json['chronicConditions'] is List
          ? List<dynamic>.from(json['chronicConditions'])
          : <dynamic>[];
    }
    if (json['medications'] != null) {
      medications = json['medications'] is List
          ? List<dynamic>.from(json['medications'])
          : <dynamic>[];
    }
    if (json['allergies'] != null) {
      allergies = json['allergies'] is List
          ? List<dynamic>.from(json['allergies'])
          : <dynamic>[];
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
      map['chronicConditions'] = List<dynamic>.from(chronicConditions!);
    }
    if (medications != null) {
      map['medications'] = List<dynamic>.from(medications!);
    }
    if (allergies != null) {
      map['allergies'] = List<dynamic>.from(allergies!);
    }
    map['recentIllness'] = recentIllness;
    map['notes'] = notes;
    map['lastCheckupDate'] = lastCheckupDate;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

