/// success : true
/// data : {"user":{"fullName":"ziyad Sobhy","email":"ahmed@gmail.com","password":"$2b$10$Uu0rUvxNCieMJEFHezJ2LuAoat.dP2WOLNdq7D3WEAzeP9BFazJm.","passwordChangedAt":null,"isEmailVerified":false,"emailVerifiedAt":null,"role":"donor","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":null,"address":null,"_id":"69fe0c76ee128be1f559fb43","__t":"donor","phoneNumber":"01141935341","bloodType":"A+","dateOfBirth":"2004-12-02T00:00:00.000Z","weight":null,"hemoglobinLevel":null,"temporaryDeferralUntil":null,"lastDeferralReason":null,"healthHistory":{"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null},"isAvailable":true,"settings":{"pushNotifications":true,"emergencyAlerts":true,"privacy":"public","language":"en"},"travelHistory":[],"createdAt":"2026-05-08T16:16:54.566Z","updatedAt":"2026-05-08T16:16:55.317Z","fullNameNormalized":"ziyad sobhy","__v":0,"emailVerificationOtp":"9f7e815da19fa0761a97d57ea9b8cfc7f7e4ac02c131b11c81e8a26b6490f02a","emailVerificationOtpExpires":"2026-05-08T16:26:55.316Z","isBanned":false,"availableToDonate":true,"isVerified":false,"id":"69fe0c76ee128be1f559fb43"},"tokens":{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc3ODg2MTkzNX0.ZYzu4fImRIRlJcBFw9MSiIJqkljRhhUGGSkJHpBrnSA","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc4MDg0OTEzNX0.FQGGZDijc5gvNKfQP90SiQnhVWJpuNvZIkNbhawmiFA"},"verificationEmail":{"sent":false,"error":"Failed to send email"}}

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

/// user : {"fullName":"ziyad Sobhy","email":"ahmed@gmail.com","password":"$2b$10$Uu0rUvxNCieMJEFHezJ2LuAoat.dP2WOLNdq7D3WEAzeP9BFazJm.","passwordChangedAt":null,"isEmailVerified":false,"emailVerifiedAt":null,"role":"donor","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":null,"address":null,"_id":"69fe0c76ee128be1f559fb43","__t":"donor","phoneNumber":"01141935341","bloodType":"A+","dateOfBirth":"2004-12-02T00:00:00.000Z","weight":null,"hemoglobinLevel":null,"temporaryDeferralUntil":null,"lastDeferralReason":null,"healthHistory":{"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null},"isAvailable":true,"settings":{"pushNotifications":true,"emergencyAlerts":true,"privacy":"public","language":"en"},"travelHistory":[],"createdAt":"2026-05-08T16:16:54.566Z","updatedAt":"2026-05-08T16:16:55.317Z","fullNameNormalized":"ziyad sobhy","__v":0,"emailVerificationOtp":"9f7e815da19fa0761a97d57ea9b8cfc7f7e4ac02c131b11c81e8a26b6490f02a","emailVerificationOtpExpires":"2026-05-08T16:26:55.316Z","isBanned":false,"availableToDonate":true,"isVerified":false,"id":"69fe0c76ee128be1f559fb43"}
/// tokens : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc3ODg2MTkzNX0.ZYzu4fImRIRlJcBFw9MSiIJqkljRhhUGGSkJHpBrnSA","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc4MDg0OTEzNX0.FQGGZDijc5gvNKfQP90SiQnhVWJpuNvZIkNbhawmiFA"}
/// verificationEmail : {"sent":false,"error":"Failed to send email"}

class Data {
  Data({
      this.user, 
      this.tokens, 
      this.verificationEmail,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    verificationEmail = json['verificationEmail'] != null ? VerificationEmail.fromJson(json['verificationEmail']) : null;
  }
  User? user;
  Tokens? tokens;
  VerificationEmail? verificationEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    if (verificationEmail != null) {
      map['verificationEmail'] = verificationEmail?.toJson();
    }
    return map;
  }

}

/// sent : false
/// error : "Failed to send email"

class VerificationEmail {
  VerificationEmail({
      this.sent, 
      this.error,});

  VerificationEmail.fromJson(dynamic json) {
    sent = json['sent'];
    error = json['error'];
  }
  bool? sent;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sent'] = sent;
    map['error'] = error;
    return map;
  }

}

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc3ODg2MTkzNX0.ZYzu4fImRIRlJcBFw9MSiIJqkljRhhUGGSkJHpBrnSA"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWZlMGM3NmVlMTI4YmUxZjU1OWZiNDMiLCJyb2xlIjoiZG9ub3IiLCJpYXQiOjE3NzgyNTcxMzUsImV4cCI6MTc4MDg0OTEzNX0.FQGGZDijc5gvNKfQP90SiQnhVWJpuNvZIkNbhawmiFA"

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

/// fullName : "ziyad Sobhy"
/// email : "ahmed@gmail.com"
/// password : "$2b$10$Uu0rUvxNCieMJEFHezJ2LuAoat.dP2WOLNdq7D3WEAzeP9BFazJm."
/// passwordChangedAt : null
/// isEmailVerified : false
/// emailVerifiedAt : null
/// role : "donor"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : []
/// phone : null
/// address : null
/// _id : "69fe0c76ee128be1f559fb43"
/// __t : "donor"
/// phoneNumber : "01141935341"
/// bloodType : "A+"
/// dateOfBirth : "2004-12-02T00:00:00.000Z"
/// weight : null
/// hemoglobinLevel : null
/// temporaryDeferralUntil : null
/// lastDeferralReason : null
/// healthHistory : {"chronicConditions":[],"medications":[],"allergies":[],"recentIllness":"","notes":"","lastCheckupDate":null,"updatedAt":null}
/// isAvailable : true
/// settings : {"pushNotifications":true,"emergencyAlerts":true,"privacy":"public","language":"en"}
/// travelHistory : []
/// createdAt : "2026-05-08T16:16:54.566Z"
/// updatedAt : "2026-05-08T16:16:55.317Z"
/// fullNameNormalized : "ziyad sobhy"
/// __v : 0
/// emailVerificationOtp : "9f7e815da19fa0761a97d57ea9b8cfc7f7e4ac02c131b11c81e8a26b6490f02a"
/// emailVerificationOtpExpires : "2026-05-08T16:26:55.316Z"
/// isBanned : false
/// availableToDonate : true
/// isVerified : false
/// id : "69fe0c76ee128be1f559fb43"

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
      this.fcmTokens, 
      this.phone, 
      this.address, 
      this.id, 
      this.t, 
      this.phoneNumber, 
      this.bloodType, 
      this.dateOfBirth, 
      this.weight, 
      this.hemoglobinLevel, 
      this.temporaryDeferralUntil, 
      this.lastDeferralReason, 
      this.healthHistory, 
      this.isAvailable, 
      this.settings, 
      this.travelHistory, 
      this.createdAt, 
      this.updatedAt, 
      this.fullNameNormalized, 
      this.v, 
      this.emailVerificationOtp, 
      this.emailVerificationOtpExpires, 
      this.isBanned, 
      this.availableToDonate, 
      this.isVerified,});

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
    if (json['fcmTokens'] != null) {
      fcmTokens = json['fcmTokens'] is List
          ? List<dynamic>.from(json['fcmTokens'])
          : <dynamic>[];
    }
    phone = json['phone'];
    address = json['address'];
    id = json['_id'];
    t = json['__t'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    dateOfBirth = json['dateOfBirth'];
    weight = json['weight'];
    hemoglobinLevel = json['hemoglobinLevel'];
    temporaryDeferralUntil = json['temporaryDeferralUntil'];
    lastDeferralReason = json['lastDeferralReason'];
    healthHistory = json['healthHistory'] != null ? HealthHistory.fromJson(json['healthHistory']) : null;
    isAvailable = json['isAvailable'];
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    if (json['travelHistory'] != null) {
      travelHistory = json['travelHistory'] is List
          ? List<dynamic>.from(json['travelHistory'])
          : <dynamic>[];
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    v = json['__v'];
    emailVerificationOtp = json['emailVerificationOtp'];
    emailVerificationOtpExpires = json['emailVerificationOtpExpires'];
    isBanned = json['isBanned'];
    availableToDonate = json['availableToDonate'];
    isVerified = json['isVerified'];
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
  List<dynamic>? fcmTokens;
  dynamic phone;
  dynamic address;
  String? id;
  String? t;
  String? phoneNumber;
  String? bloodType;
  String? dateOfBirth;
  dynamic weight;
  dynamic hemoglobinLevel;
  dynamic temporaryDeferralUntil;
  dynamic lastDeferralReason;
  HealthHistory? healthHistory;
  bool? isAvailable;
  Settings? settings;
  List<dynamic>? travelHistory;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  int? v;
  String? emailVerificationOtp;
  String? emailVerificationOtpExpires;
  bool? isBanned;
  bool? availableToDonate;
  bool? isVerified;

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
    if (fcmTokens != null) {
      map['fcmTokens'] = List<dynamic>.from(fcmTokens!);
    }
    map['phone'] = phone;
    map['address'] = address;
    map['_id'] = id;
    map['__t'] = t;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['dateOfBirth'] = dateOfBirth;
    map['weight'] = weight;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['temporaryDeferralUntil'] = temporaryDeferralUntil;
    map['lastDeferralReason'] = lastDeferralReason;
    if (healthHistory != null) {
      map['healthHistory'] = healthHistory?.toJson();
    }
    map['isAvailable'] = isAvailable;
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    if (travelHistory != null) {
      map['travelHistory'] = List<dynamic>.from(travelHistory!);
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['__v'] = v;
    map['emailVerificationOtp'] = emailVerificationOtp;
    map['emailVerificationOtpExpires'] = emailVerificationOtpExpires;
    map['isBanned'] = isBanned;
    map['availableToDonate'] = availableToDonate;
    map['isVerified'] = isVerified;
    return map;
  }

}

/// pushNotifications : true
/// emergencyAlerts : true
/// privacy : "public"
/// language : "en"

class Settings {
  Settings({
      this.pushNotifications, 
      this.emergencyAlerts, 
      this.privacy, 
      this.language,});

  Settings.fromJson(dynamic json) {
    pushNotifications = json['pushNotifications'];
    emergencyAlerts = json['emergencyAlerts'];
    privacy = json['privacy'];
    language = json['language'];
  }
  bool? pushNotifications;
  bool? emergencyAlerts;
  String? privacy;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushNotifications'] = pushNotifications;
    map['emergencyAlerts'] = emergencyAlerts;
    map['privacy'] = privacy;
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