
class SignUpModel {
  SignUpModel({
      this.success, 
      this.data,});

  SignUpModel.fromJson(dynamic json) {
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

/// user : {"fullName":"Aya Hassan","email":"aya.hassan5555@lifelink.demo","password":"$2b$10$bC1j4dy6xBWkYXq.xgBRWevwKX6TjcfcTwYSFAz/HylmvCPECHB0.","passwordChangedAt":null,"isEmailVerified":false,"emailVerifiedAt":null,"role":"donor","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-24T17:34:27.726Z"},"fcmTokens":[],"phone":null,"address":null,"_id":"6a1336a36e9541206b58505f","__t":"donor","phoneNumber":"01011111111","bloodType":"O+","dateOfBirth":"1995-05-15T00:00:00.000Z","gender":"female","weight":null,"hemoglobinLevel":null,"temporaryDeferralUntil":null,"lastDeferralReason":null,"healthHistory":{"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null},"isOptedIn":true,"settings":{"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"},"travelHistory":[],"createdAt":"2026-05-24T17:34:27.741Z","updatedAt":"2026-05-24T17:34:28.332Z","fullNameNormalized":"aya hassan","__v":0,"emailVerificationOtp":"823edbac2785048f77a52c47e7016080ad137c0dcdfad2e5153203ad93e9a1f9","emailVerificationOtpExpires":"2026-05-24T17:44:28.331Z","isBanned":false,"isVerified":false,"id":"6a1336a36e9541206b58505f"}
/// tokens : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMzZhMzZlOTU0MTIwNmI1ODUwNWYiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk2NDQwNjksImV4cCI6MTc4MDI0ODg2OX0.vLJr9xtz97NxKXOFJdAfeMYcc0Cz4iQF5hh-jvSrnb8","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMzZhMzZlOTU0MTIwNmI1ODUwNWYiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk2NDQwNjksImV4cCI6MTc4MjIzNjA2OX0.UWT9tOavPkAgAnt8CpwhsoYN6DBQS0E03-NNGCkF1O0"}
/// locationRequired : false
/// verificationEmail : {"sent":true,"id":"1d75e124-d0f5-49f9-a4f7-3b4e8dcb840f"}

class Data {
  Data({
      this.user, 
      this.tokens, 
      this.locationRequired, 
      this.verificationEmail,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    locationRequired = json['locationRequired'];
    verificationEmail = json['verificationEmail'] != null ? VerificationEmail.fromJson(json['verificationEmail']) : null;
  }
  User? user;
  Tokens? tokens;
  bool? locationRequired;
  VerificationEmail? verificationEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    map['locationRequired'] = locationRequired;
    if (verificationEmail != null) {
      map['verificationEmail'] = verificationEmail?.toJson();
    }
    return map;
  }

}

/// sent : true
/// id : "1d75e124-d0f5-49f9-a4f7-3b4e8dcb840f"

class VerificationEmail {
  VerificationEmail({
      this.sent, 
      this.id,});

  VerificationEmail.fromJson(dynamic json) {
    sent = json['sent'];
    id = json['id'];
  }
  bool? sent;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sent'] = sent;
    map['id'] = id;
    return map;
  }

}

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMzZhMzZlOTU0MTIwNmI1ODUwNWYiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk2NDQwNjksImV4cCI6MTc4MDI0ODg2OX0.vLJr9xtz97NxKXOFJdAfeMYcc0Cz4iQF5hh-jvSrnb8"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YTEzMzZhMzZlOTU0MTIwNmI1ODUwNWYiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3Nzk2NDQwNjksImV4cCI6MTc4MjIzNjA2OX0.UWT9tOavPkAgAnt8CpwhsoYN6DBQS0E03-NNGCkF1O0"

class Tokens {
  Tokens({
      this.accessToken, 
      this.refreshToken,});

  Tokens.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }

}

/// fullName : "Aya Hassan"
/// email : "aya.hassan5555@lifelink.demo"
/// password : "$2b$10$bC1j4dy6xBWkYXq.xgBRWevwKX6TjcfcTwYSFAz/HylmvCPECHB0."
/// passwordChangedAt : null
/// isEmailVerified : false
/// emailVerifiedAt : null
/// role : "donor"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// location : {"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-24T17:34:27.726Z"}
/// fcmTokens : []
/// phone : null
/// address : null
/// _id : "6a1336a36e9541206b58505f"
/// __t : "donor"
/// phoneNumber : "01011111111"
/// bloodType : "O+"
/// dateOfBirth : "1995-05-15T00:00:00.000Z"
/// gender : "female"
/// weight : null
/// hemoglobinLevel : null
/// temporaryDeferralUntil : null
/// lastDeferralReason : null
/// healthHistory : {"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null}
/// isOptedIn : true
/// settings : {"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"}
/// travelHistory : []
/// createdAt : "2026-05-24T17:34:27.741Z"
/// updatedAt : "2026-05-24T17:34:28.332Z"
/// fullNameNormalized : "aya hassan"
/// __v : 0
/// emailVerificationOtp : "823edbac2785048f77a52c47e7016080ad137c0dcdfad2e5153203ad93e9a1f9"
/// emailVerificationOtpExpires : "2026-05-24T17:44:28.331Z"
/// isBanned : false
/// isVerified : false
/// id : "6a1336a36e9541206b58505f"

class User {
  User({
      this.fullName, 
      this.email, 
      this.password, 
      this.passwordChangedAt, 
      this.isEmailVerified, 
      this.emailVerifiedAt, 
      this.role, 
      this.isSuspended, 
      this.suspendedAt, 
      this.suspendedReason, 
      this.deletedAt, 
      this.location, 
      this.fcmTokens, 
      this.phone, 
      this.address, 
      this.sId, 
      this.t, 
      this.phoneNumber, 
      this.bloodType, 
      this.dateOfBirth, 
      this.gender, 
      this.weight, 
      this.hemoglobinLevel, 
      this.temporaryDeferralUntil, 
      this.lastDeferralReason, 
      this.healthHistory, 
      this.isOptedIn, 
      this.settings, 
      this.travelHistory, 
      this.createdAt, 
      this.updatedAt, 
      this.fullNameNormalized, 
      this.v, 
      this.emailVerificationOtp, 
      this.emailVerificationOtpExpires, 
      this.isBanned, 
      this.isVerified, 
      this.id,});

  User.fromJson(dynamic json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    passwordChangedAt = json['passwordChangedAt'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedAt = json['emailVerifiedAt'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    suspendedAt = json['suspendedAt'];
    suspendedReason = json['suspendedReason'];
    deletedAt = json['deletedAt'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['fcmTokens'] != null) {
      fcmTokens = [];
      json['fcmTokens'].forEach((v) {
        fcmTokens?.add(v);
      });
    }
    phone = json['phone'];
    address = json['address'];
    sId = json['_id'];
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    healthHistory = json['healthHistory'] != null ? HealthHistory.fromJson(json['healthHistory']) : null;
    isOptedIn = json['isOptedIn'];
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
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
    emailVerificationOtp = json['emailVerificationOtp'];
    emailVerificationOtpExpires = json['emailVerificationOtpExpires'];
    isBanned = json['isBanned'];
    isVerified = json['isVerified'];
    id = json['id'];
  }
  String? fullName;
  String? email;
  String? password;
  dynamic passwordChangedAt;
  bool? isEmailVerified;
  dynamic emailVerifiedAt;
  String? role;
  bool? isSuspended;
  dynamic suspendedAt;
  dynamic suspendedReason;
  dynamic deletedAt;
  Location? location;
  List<dynamic>? fcmTokens;
  dynamic phone;
  dynamic address;
  String? sId;
  String? t;
  String? phoneNumber;
  String? bloodType;
  String? dateOfBirth;
  String? gender;
  dynamic weight;
  dynamic hemoglobinLevel;
  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;
  HealthHistory? healthHistory;
  bool? isOptedIn;
  Settings? settings;
  List<dynamic>? travelHistory;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  int? v;
  String? emailVerificationOtp;
  String? emailVerificationOtpExpires;
  bool? isBanned;
  bool? isVerified;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    map['password'] = password;
    map['passwordChangedAt'] = passwordChangedAt;
    map['isEmailVerified'] = isEmailVerified;
    map['emailVerifiedAt'] = emailVerifiedAt;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['suspendedAt'] = suspendedAt;
    map['suspendedReason'] = suspendedReason;
    map['deletedAt'] = deletedAt;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (fcmTokens != null) {
      map['fcmTokens'] = fcmTokens?.map((v) => v.toJson()).toList();
    }
    map['phone'] = phone;
    map['address'] = address;
    map['_id'] = sId;
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    if (healthHistory != null) {
      map['healthHistory'] = healthHistory?.toJson();
    }
    map['isOptedIn'] = isOptedIn;
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    if (travelHistory != null) {
      map['travelHistory'] = travelHistory?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['emailVerificationOtp'] = emailVerificationOtp;
    map['emailVerificationOtpExpires'] = emailVerificationOtpExpires;
    map['isBanned'] = isBanned;
    map['isVerified'] = isVerified;
    map['id'] = id;
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
  dynamic lastCheckupDate;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chronicConditions != null) {
      map['chronicConditions'] = chronicConditions?.map((v) => v).toList();
    }
    if (medications != null) {
      map['medications'] = medications?.map((v) => v).toList();
    }
    if (allergies != null) {
      map['allergies'] = allergies?.map((v) => v).toList();
    }
    map['recentIllness'] = recentIllness;
    map['notes'] = notes;
    map['lastCheckupDate'] = lastCheckupDate;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// city : "Cairo"
/// governorate : "Cairo"
/// coordinates : {"lat":30.0444,"lng":31.2357}
/// lastUpdated : "2026-05-24T17:34:27.726Z"

class Location {
  Location({
      this.city, 
      this.governorate, 
      this.coordinates, 
      this.lastUpdated,});

  Location.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    lastUpdated = json['lastUpdated'];
  }
  String? city;
  String? governorate;
  Coordinates? coordinates;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }
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