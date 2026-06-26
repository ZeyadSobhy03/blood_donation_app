/// success : true
/// message : "Hospital updated successfully"
/// data : {"user":{"location":{"coordinates":{"lat":30.5669,"lng":31.5015},"city":"Zagazig","governorate":"Sharqia","lastUpdated":"2026-06-25T22:32:49.192Z"},"_id":"6a3d9f853439aa31647283c9","fullName":"Cairo Care Hospital","email":"hospital020@lifelink.data","isEmailVerified":true,"emailVerifiedAt":"2026-06-25T22:32:49.192Z","role":"hospital","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":"01043024504","address":{"city":"Zagazig","governorate":"Sharqia","district":"Zagazig"},"position":null,"department":null,"__t":"hospital","type":"hospital","hospitalType":"Teaching Hospital","workingHours":"9AM - 5PM","city":"Zagazig","state":"Sharqia","zipCode":null,"hospitalId":"HOSP-REAL-020","licenseNumber":null,"adminContactName":null,"adminContactPhone":null,"emergencyContact":null,"bloodBanksAvailable":["O+","O-","A+","B+"],"name":"Al Ahrar Teaching Hospital","contactNumber":"1044444444","capacity":200,"lat":30.5669,"long":31.5015,"hospitalName":"Cairo Care Hospital","slotsPerHour":5,"workingHoursStart":8,"workingHoursEnd":18,"createdAt":"2026-06-25T21:37:09.329Z","updatedAt":"2026-06-26T00:12:55.613Z","fullNameNormalized":"cairo care hospital","hospitalNameNormalized":"cairo care hospital","__v":4}}

class AdminUpdateHospitalModel {
  AdminUpdateHospitalModel({
      this.success, 
      this.message, 
      this.data,});

  AdminUpdateHospitalModel.fromJson(dynamic json) {
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

/// user : {"location":{"coordinates":{"lat":30.5669,"lng":31.5015},"city":"Zagazig","governorate":"Sharqia","lastUpdated":"2026-06-25T22:32:49.192Z"},"_id":"6a3d9f853439aa31647283c9","fullName":"Cairo Care Hospital","email":"hospital020@lifelink.data","isEmailVerified":true,"emailVerifiedAt":"2026-06-25T22:32:49.192Z","role":"hospital","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":"01043024504","address":{"city":"Zagazig","governorate":"Sharqia","district":"Zagazig"},"position":null,"department":null,"__t":"hospital","type":"hospital","hospitalType":"Teaching Hospital","workingHours":"9AM - 5PM","city":"Zagazig","state":"Sharqia","zipCode":null,"hospitalId":"HOSP-REAL-020","licenseNumber":null,"adminContactName":null,"adminContactPhone":null,"emergencyContact":null,"bloodBanksAvailable":["O+","O-","A+","B+"],"name":"Al Ahrar Teaching Hospital","contactNumber":"1044444444","capacity":200,"lat":30.5669,"long":31.5015,"hospitalName":"Cairo Care Hospital","slotsPerHour":5,"workingHoursStart":8,"workingHoursEnd":18,"createdAt":"2026-06-25T21:37:09.329Z","updatedAt":"2026-06-26T00:12:55.613Z","fullNameNormalized":"cairo care hospital","hospitalNameNormalized":"cairo care hospital","__v":4}

class Data {
  Data({
      this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// location : {"coordinates":{"lat":30.5669,"lng":31.5015},"city":"Zagazig","governorate":"Sharqia","lastUpdated":"2026-06-25T22:32:49.192Z"}
/// _id : "6a3d9f853439aa31647283c9"
/// fullName : "Cairo Care Hospital"
/// email : "hospital020@lifelink.data"
/// isEmailVerified : true
/// emailVerifiedAt : "2026-06-25T22:32:49.192Z"
/// role : "hospital"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : []
/// phone : "01043024504"
/// address : {"city":"Zagazig","governorate":"Sharqia","district":"Zagazig"}
/// position : null
/// department : null
/// __t : "hospital"
/// type : "hospital"
/// hospitalType : "Teaching Hospital"
/// workingHours : "9AM - 5PM"
/// city : "Zagazig"
/// state : "Sharqia"
/// zipCode : null
/// hospitalId : "HOSP-REAL-020"
/// licenseNumber : null
/// adminContactName : null
/// adminContactPhone : null
/// emergencyContact : null
/// bloodBanksAvailable : ["O+","O-","A+","B+"]
/// name : "Al Ahrar Teaching Hospital"
/// contactNumber : "1044444444"
/// capacity : 200
/// lat : 30.5669
/// long : 31.5015
/// hospitalName : "Cairo Care Hospital"
/// slotsPerHour : 5
/// workingHoursStart : 8
/// workingHoursEnd : 18
/// createdAt : "2026-06-25T21:37:09.329Z"
/// updatedAt : "2026-06-26T00:12:55.613Z"
/// fullNameNormalized : "cairo care hospital"
/// hospitalNameNormalized : "cairo care hospital"
/// __v : 4

class User {
  User({
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
      this.name, 
      this.contactNumber, 
      this.capacity, 
      this.lat, 
      this.long, 
      this.hospitalName, 
      this.slotsPerHour, 
      this.workingHoursStart, 
      this.workingHoursEnd, 
      this.createdAt, 
      this.updatedAt, 
      this.fullNameNormalized, 
      this.hospitalNameNormalized, 
      this.v,});

  User.fromJson(dynamic json) {
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
      fcmTokens = [];
      json['fcmTokens'].forEach((v) {
        fcmTokens?.add(v.toString());
      });
    }
    phone = json['phone'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    position = json['position'];
    department = json['department'];
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
    bloodBanksAvailable = json['bloodBanksAvailable'] != null ? json['bloodBanksAvailable'].cast<String>() : [];
    name = json['name'];
    contactNumber = json['contactNumber'];
    capacity = json['capacity'];
    lat = json['lat'];
    long = json['long'];
    hospitalName = json['hospitalName'];
    slotsPerHour = json['slotsPerHour'];
    workingHoursStart = json['workingHoursStart'];
    workingHoursEnd = json['workingHoursEnd'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    hospitalNameNormalized = json['hospitalNameNormalized'];
    v = json['__v'];
  }
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
  Address? address;
  dynamic position;
  dynamic department;
  String? t;
  String? type;
  String? hospitalType;
  String? workingHours;
  String? city;
  String? state;
  dynamic zipCode;
  String? hospitalId;
  dynamic licenseNumber;
  dynamic adminContactName;
  dynamic adminContactPhone;
  dynamic emergencyContact;
  List<String>? bloodBanksAvailable;
  String? name;
  String? contactNumber;
  int? capacity;
  double? lat;
  double? long;
  String? hospitalName;
  int? slotsPerHour;
  int? workingHoursStart;
  int? workingHoursEnd;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  String? hospitalNameNormalized;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
      map['fcmTokens'] = fcmTokens?.map((v) => v.toJson()).toList();
    }
    map['phone'] = phone;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['position'] = position;
    map['department'] = department;
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
    map['bloodBanksAvailable'] = bloodBanksAvailable;
    map['name'] = name;
    map['contactNumber'] = contactNumber;
    map['capacity'] = capacity;
    map['lat'] = lat;
    map['long'] = long;
    map['hospitalName'] = hospitalName;
    map['slotsPerHour'] = slotsPerHour;
    map['workingHoursStart'] = workingHoursStart;
    map['workingHoursEnd'] = workingHoursEnd;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['hospitalNameNormalized'] = hospitalNameNormalized;
    map['__v'] = v;
    return map;
  }

}

/// city : "Zagazig"
/// governorate : "Sharqia"
/// district : "Zagazig"

class Address {
  Address({
      this.city, 
      this.governorate, 
      this.district,});

  Address.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
    district = json['district'];
  }
  String? city;
  String? governorate;
  String? district;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    map['district'] = district;
    return map;
  }

}

/// coordinates : {"lat":30.5669,"lng":31.5015}
/// city : "Zagazig"
/// governorate : "Sharqia"
/// lastUpdated : "2026-06-25T22:32:49.192Z"

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

/// lat : 30.5669
/// lng : 31.5015

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