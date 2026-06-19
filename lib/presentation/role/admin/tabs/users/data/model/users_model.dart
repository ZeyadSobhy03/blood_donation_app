/// success : true
/// message : "Users list"
/// data : {"users":[{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-15T18:11:30.572Z"},"licenseNumber":null,"position":null,"department":null,"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","email":"ops@cairocare.demo","isEmailVerified":true,"emailVerifiedAt":"2026-06-15T18:11:30.572Z","role":"hospital","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":null,"address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","name":"Cairo Care Operations","type":"hospital","hospitalType":"General Hospital","workingHours":"9AM - 5PM","city":"Cairo","state":"Cairo","zipCode":null,"hospitalId":"HOSP-CAIRO-001","adminContactName":null,"adminContactPhone":null,"emergencyContact":null,"bloodBanksAvailable":["O+","O-","A+","A-","B+","AB+"],"capacity":30,"lat":30.0511,"long":31.2435,"hospitalName":"Cairo Care Hospital","contactNumber":"1044444444","slotsPerHour":5,"workingHoursStart":9,"workingHoursEnd":17,"createdAt":"2026-05-24T14:43:14.029Z","updatedAt":"2026-06-15T18:11:36.029Z","fullNameNormalized":"cairo care operations","hospitalNameNormalized":"cairo care hospital","__v":0,"id":"6a130e820b339a45a51addb4","isActive":true,"isVerified":true,"joinedAt":"2026-05-24T14:43:14.029Z","totalDonations":0}],"pagination":{"total":1,"page":1,"currentPage":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false},"stats":{"totalUsers":33,"totalDonors":23,"totalHospitals":8,"totalAdmins":2,"verifiedUsers":30,"unverifiedUsers":3,"suspendedUsers":0,"totalUsersGrowth":"+100%","totalDonorsGrowth":"+100%","totalHospitalsGrowth":"+100%","verifiedUsersGrowth":"+100%","suspendedUsersGrowth":"0%","aiInsights":[{"title":"Donor Registrations Declining","description":"Donor signups are -60% this week compared to last week. Consider increasing outreach efforts.","confidence":0.95}]}}

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

/// users : [{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-15T18:11:30.572Z"},"licenseNumber":null,"position":null,"department":null,"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","email":"ops@cairocare.demo","isEmailVerified":true,"emailVerifiedAt":"2026-06-15T18:11:30.572Z","role":"hospital","isSuspended":false,"suspendedAt":null,"suspendedReason":null,"deletedAt":null,"fcmTokens":[],"phone":null,"address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","name":"Cairo Care Operations","type":"hospital","hospitalType":"General Hospital","workingHours":"9AM - 5PM","city":"Cairo","state":"Cairo","zipCode":null,"hospitalId":"HOSP-CAIRO-001","adminContactName":null,"adminContactPhone":null,"emergencyContact":null,"bloodBanksAvailable":["O+","O-","A+","A-","B+","AB+"],"capacity":30,"lat":30.0511,"long":31.2435,"hospitalName":"Cairo Care Hospital","contactNumber":"1044444444","slotsPerHour":5,"workingHoursStart":9,"workingHoursEnd":17,"createdAt":"2026-05-24T14:43:14.029Z","updatedAt":"2026-06-15T18:11:36.029Z","fullNameNormalized":"cairo care operations","hospitalNameNormalized":"cairo care hospital","__v":0,"id":"6a130e820b339a45a51addb4","isActive":true,"isVerified":true,"joinedAt":"2026-05-24T14:43:14.029Z","totalDonations":0}]
/// pagination : {"total":1,"page":1,"currentPage":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}
/// stats : {"totalUsers":33,"totalDonors":23,"totalHospitals":8,"totalAdmins":2,"verifiedUsers":30,"unverifiedUsers":3,"suspendedUsers":0,"totalUsersGrowth":"+100%","totalDonorsGrowth":"+100%","totalHospitalsGrowth":"+100%","verifiedUsersGrowth":"+100%","suspendedUsersGrowth":"0%","aiInsights":[{"title":"Donor Registrations Declining","description":"Donor signups are -60% this week compared to last week. Consider increasing outreach efforts.","confidence":0.95}]}

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

/// totalUsers : 33
/// totalDonors : 23
/// totalHospitals : 8
/// totalAdmins : 2
/// verifiedUsers : 30
/// unverifiedUsers : 3
/// suspendedUsers : 0
/// totalUsersGrowth : "+100%"
/// totalDonorsGrowth : "+100%"
/// totalHospitalsGrowth : "+100%"
/// verifiedUsersGrowth : "+100%"
/// suspendedUsersGrowth : "0%"
/// aiInsights : [{"title":"Donor Registrations Declining","description":"Donor signups are -60% this week compared to last week. Consider increasing outreach efforts.","confidence":0.95}]

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

/// title : "Donor Registrations Declining"
/// description : "Donor signups are -60% this week compared to last week. Consider increasing outreach efforts."
/// confidence : 0.95

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

/// total : 1
/// page : 1
/// currentPage : 1
/// limit : 10
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

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

/// location : {"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-15T18:11:30.572Z"}
/// licenseNumber : null
/// position : null
/// department : null
/// _id : "6a130e820b339a45a51addb4"
/// fullName : "Cairo Care Operations"
/// email : "ops@cairocare.demo"
/// isEmailVerified : true
/// emailVerifiedAt : "2026-06-15T18:11:30.572Z"
/// role : "hospital"
/// isSuspended : false
/// suspendedAt : null
/// suspendedReason : null
/// deletedAt : null
/// fcmTokens : []
/// phone : null
/// address : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
/// __t : "hospital"
/// name : "Cairo Care Operations"
/// type : "hospital"
/// hospitalType : "General Hospital"
/// workingHours : "9AM - 5PM"
/// city : "Cairo"
/// state : "Cairo"
/// zipCode : null
/// hospitalId : "HOSP-CAIRO-001"
/// adminContactName : null
/// adminContactPhone : null
/// emergencyContact : null
/// bloodBanksAvailable : ["O+","O-","A+","A-","B+","AB+"]
/// capacity : 30
/// lat : 30.0511
/// long : 31.2435
/// hospitalName : "Cairo Care Hospital"
/// contactNumber : "1044444444"
/// slotsPerHour : 5
/// workingHoursStart : 9
/// workingHoursEnd : 17
/// createdAt : "2026-05-24T14:43:14.029Z"
/// updatedAt : "2026-06-15T18:11:36.029Z"
/// fullNameNormalized : "cairo care operations"
/// hospitalNameNormalized : "cairo care hospital"
/// __v : 0
/// id : "6a130e820b339a45a51addb4"
/// isActive : true
/// isVerified : true
/// joinedAt : "2026-05-24T14:43:14.029Z"
/// totalDonations : 0

class Users {
  Users({
      this.location, 
      this.licenseNumber, 
      this.position, 
      this.department, 
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
      this.name, 
      this.type, 
      this.hospitalType, 
      this.workingHours, 
      this.city, 
      this.state, 
      this.zipCode, 
      this.hospitalId, 
      this.adminContactName, 
      this.adminContactPhone, 
      this.emergencyContact, 
      this.bloodBanksAvailable, 
      this.capacity, 
      this.lat, 
      this.long, 
      this.hospitalName, 
      this.contactNumber, 
      this.slotsPerHour, 
      this.workingHoursStart, 
      this.workingHoursEnd, 
      this.createdAt, 
      this.updatedAt, 
      this.fullNameNormalized, 
      this.hospitalNameNormalized, 
      this.v, 
      this.isActive,
      this.isVerified, 
      this.joinedAt, 
      this.totalDonations,});

  Users.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    licenseNumber = json['licenseNumber'];
    position = json['position'];
    department = json['department'];
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
    fcmTokens = json['fcmTokens'] != null ? json['fcmTokens'].cast<String>() : [];    phone = json['phone'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    t = json['__t'];
    name = json['name'];
    type = json['type'];
    hospitalType = json['hospitalType'];
    workingHours = json['workingHours'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    hospitalId = json['hospitalId'];
    adminContactName = json['adminContactName'];
    adminContactPhone = json['adminContactPhone'];
    emergencyContact = json['emergencyContact'];
    bloodBanksAvailable = json['bloodBanksAvailable'] != null ? json['bloodBanksAvailable'].cast<String>() : [];
    capacity = json['capacity'];
    lat = json['lat'];
    long = json['long'];
    hospitalName = json['hospitalName'];
    contactNumber = json['contactNumber'];
    slotsPerHour = json['slotsPerHour'];
    workingHoursStart = json['workingHoursStart'];
    workingHoursEnd = json['workingHoursEnd'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullNameNormalized = json['fullNameNormalized'];
    hospitalNameNormalized = json['hospitalNameNormalized'];
    v = json['__v'];
    id = json['id'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    joinedAt = json['joinedAt'];
    totalDonations = json['totalDonations'];
  }
  Location? location;
  dynamic licenseNumber;
  dynamic position;
  dynamic department;
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
  dynamic phone;
  Address? address;
  String? t;
  String? name;
  String? type;
  String? hospitalType;
  String? workingHours;
  String? city;
  String? state;
  dynamic zipCode;
  String? hospitalId;
  dynamic adminContactName;
  dynamic adminContactPhone;
  dynamic emergencyContact;
  List<String>? bloodBanksAvailable;
  int? capacity;
  double? lat;
  double? long;
  String? hospitalName;
  String? contactNumber;
  int? slotsPerHour;
  int? workingHoursStart;
  int? workingHoursEnd;
  String? createdAt;
  String? updatedAt;
  String? fullNameNormalized;
  String? hospitalNameNormalized;
  int? v;
  bool? isActive;
  bool? isVerified;
  String? joinedAt;
  int? totalDonations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['licenseNumber'] = licenseNumber;
    map['position'] = position;
    map['department'] = department;
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
    map['__t'] = t;
    map['name'] = name;
    map['type'] = type;
    map['hospitalType'] = hospitalType;
    map['workingHours'] = workingHours;
    map['city'] = city;
    map['state'] = state;
    map['zipCode'] = zipCode;
    map['hospitalId'] = hospitalId;
    map['adminContactName'] = adminContactName;
    map['adminContactPhone'] = adminContactPhone;
    map['emergencyContact'] = emergencyContact;
    map['bloodBanksAvailable'] = bloodBanksAvailable;
    map['capacity'] = capacity;
    map['lat'] = lat;
    map['long'] = long;
    map['hospitalName'] = hospitalName;
    map['contactNumber'] = contactNumber;
    map['slotsPerHour'] = slotsPerHour;
    map['workingHoursStart'] = workingHoursStart;
    map['workingHoursEnd'] = workingHoursEnd;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['fullNameNormalized'] = fullNameNormalized;
    map['hospitalNameNormalized'] = hospitalNameNormalized;
    map['__v'] = v;
    map['id'] = id;
    map['isActive'] = isActive;
    map['isVerified'] = isVerified;
    map['joinedAt'] = joinedAt;
    map['totalDonations'] = totalDonations;
    return map;
  }

}

/// city : "Cairo"
/// governorate : "Cairo"
/// district : "Garden City"

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

/// coordinates : {"lat":30.0511,"lng":31.2435}
/// city : "Cairo"
/// governorate : "Cairo"
/// lastUpdated : "2026-06-15T18:11:30.572Z"

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

/// lat : 30.0511
/// lng : 31.2435

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