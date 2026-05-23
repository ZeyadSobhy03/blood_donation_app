/// success : true
/// data : {"request":{"id":"6a07521ef89827b0ef07e126","requestId":"6a07521ef89827b0ef07e126","bloodType":"O+","hospitalName":"General Test Hospital","patientType":null,"contactNumber":"2000000000","unitsNeeded":1,"isEmergency":false,"createdAt":"2026-05-15T17:04:30.994Z","status":"accepted","requestStatus":"accepted","urgency":"high","type":"blood","requiredBy":"2026-05-18T17:04:30.993Z","locationHospital":{"latitude":30.0444,"longitude":31.2357},"googleMapsUrl":"https://www.google.com/maps/dir/?api=1&destination=30.0444,31.2357","qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a07521ef89827b0ef07e125","name":"General Test Hospital","contactNumber":"2000000000","address":{"city":"Test City","governorate":"Test Governorate"},"latitude":30.0444,"longitude":31.2357},"distanceKm":null,"distanceMeters":null,"distance":null},"donor":{"id":"69f3df915f42685cbbbcbb18","name":"Aya Hassan","phoneNumber":"01011111111","bloodType":"O+"},"donation":{"donorId":"69f3df915f42685cbbbcbb18","requestId":"6a07521ef89827b0ef07e126","status":"pending","quantity":1,"qrToken":null,"qrExpires":null,"_id":"6a087f725ddb09b486411993","createdAt":"2026-05-16T14:30:10.952Z","updatedAt":"2026-05-16T14:30:10.952Z","__v":0}}

class RequestAcceptModel {
  RequestAcceptModel({
      this.success, 
      this.data,});

  RequestAcceptModel.fromJson(dynamic json) {
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

/// request : {"id":"6a07521ef89827b0ef07e126","requestId":"6a07521ef89827b0ef07e126","bloodType":"O+","hospitalName":"General Test Hospital","patientType":null,"contactNumber":"2000000000","unitsNeeded":1,"isEmergency":false,"createdAt":"2026-05-15T17:04:30.994Z","status":"accepted","requestStatus":"accepted","urgency":"high","type":"blood","requiredBy":"2026-05-18T17:04:30.993Z","locationHospital":{"latitude":30.0444,"longitude":31.2357},"googleMapsUrl":"https://www.google.com/maps/dir/?api=1&destination=30.0444,31.2357","qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a07521ef89827b0ef07e125","name":"General Test Hospital","contactNumber":"2000000000","address":{"city":"Test City","governorate":"Test Governorate"},"latitude":30.0444,"longitude":31.2357},"distanceKm":null,"distanceMeters":null,"distance":null}
/// donor : {"id":"69f3df915f42685cbbbcbb18","name":"Aya Hassan","phoneNumber":"01011111111","bloodType":"O+"}
/// donation : {"donorId":"69f3df915f42685cbbbcbb18","requestId":"6a07521ef89827b0ef07e126","status":"pending","quantity":1,"qrToken":null,"qrExpires":null,"_id":"6a087f725ddb09b486411993","createdAt":"2026-05-16T14:30:10.952Z","updatedAt":"2026-05-16T14:30:10.952Z","__v":0}

class Data {
  Data({
      this.request, 
      this.donor, 
      this.donation,});

  Data.fromJson(dynamic json) {
    request = json['request'] != null ? Request.fromJson(json['request']) : null;
    donor = json['donor'] != null ? Donor.fromJson(json['donor']) : null;
    donation = json['donation'] != null ? Donation.fromJson(json['donation']) : null;
  }
  Request? request;
  Donor? donor;
  Donation? donation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (request != null) {
      map['request'] = request?.toJson();
    }
    if (donor != null) {
      map['donor'] = donor?.toJson();
    }
    if (donation != null) {
      map['donation'] = donation?.toJson();
    }
    return map;
  }

}

/// donorId : "69f3df915f42685cbbbcbb18"
/// requestId : "6a07521ef89827b0ef07e126"
/// status : "pending"
/// quantity : 1
/// qrToken : null
/// qrExpires : null
/// _id : "6a087f725ddb09b486411993"
/// createdAt : "2026-05-16T14:30:10.952Z"
/// updatedAt : "2026-05-16T14:30:10.952Z"
/// __v : 0

class Donation {
  Donation({
      this.donorId, 
      this.requestId, 
      this.status, 
      this.quantity, 
      this.qrToken, 
      this.qrExpires, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Donation.fromJson(dynamic json) {
    donorId = json['donorId'];
    requestId = json['requestId'];
    status = json['status'];
    quantity = json['quantity'];
    qrToken = json['qrToken'];
    qrExpires = json['qrExpires'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? donorId;
  String? requestId;
  String? status;
  int? quantity;
  dynamic qrToken;
  dynamic qrExpires;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donorId'] = donorId;
    map['requestId'] = requestId;
    map['status'] = status;
    map['quantity'] = quantity;
    map['qrToken'] = qrToken;
    map['qrExpires'] = qrExpires;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

/// id : "69f3df915f42685cbbbcbb18"
/// name : "Aya Hassan"
/// phoneNumber : "01011111111"
/// bloodType : "O+"

class Donor {
  Donor({
      this.id, 
      this.name, 
      this.phoneNumber, 
      this.bloodType,});

  Donor.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
  }
  String? id;
  String? name;
  String? phoneNumber;
  String? bloodType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    return map;
  }

}

/// id : "6a07521ef89827b0ef07e126"
/// requestId : "6a07521ef89827b0ef07e126"
/// bloodType : "O+"
/// hospitalName : "General Test Hospital"
/// patientType : null
/// contactNumber : "2000000000"
/// unitsNeeded : 1
/// isEmergency : false
/// createdAt : "2026-05-15T17:04:30.994Z"
/// status : "accepted"
/// requestStatus : "accepted"
/// urgency : "high"
/// type : "blood"
/// requiredBy : "2026-05-18T17:04:30.993Z"
/// locationHospital : {"latitude":30.0444,"longitude":31.2357}
/// googleMapsUrl : "https://www.google.com/maps/dir/?api=1&destination=30.0444,31.2357"
/// qrToken : null
/// qrCreatedAt : null
/// qrExpiresAt : null
/// hospital : {"id":"6a07521ef89827b0ef07e125","name":"General Test Hospital","contactNumber":"2000000000","address":{"city":"Test City","governorate":"Test Governorate"},"latitude":30.0444,"longitude":31.2357}
/// distanceKm : null
/// distanceMeters : null
/// distance : null

class Request {
  Request({
      this.id, 
      this.requestId, 
      this.bloodType, 
      this.hospitalName, 
      this.patientType, 
      this.contactNumber, 
      this.unitsNeeded, 
      this.isEmergency, 
      this.createdAt, 
      this.status, 
      this.requestStatus, 
      this.urgency, 
      this.type, 
      this.requiredBy, 
      this.locationHospital, 
      this.googleMapsUrl, 
      this.qrToken, 
      this.qrCreatedAt, 
      this.qrExpiresAt, 
      this.hospital, 
      this.distanceKm, 
      this.distanceMeters, 
      this.distance,});

  Request.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['requestId'];
    bloodType = json['bloodType'];
    hospitalName = json['hospitalName'];
    patientType = json['patientType'];
    contactNumber = json['contactNumber'];
    unitsNeeded = json['unitsNeeded'];
    isEmergency = json['isEmergency'];
    createdAt = json['createdAt'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    urgency = json['urgency'];
    type = json['type'];
    requiredBy = json['requiredBy'];
    locationHospital = json['locationHospital'] != null ? LocationHospital.fromJson(json['locationHospital']) : null;
    googleMapsUrl = json['googleMapsUrl'];
    qrToken = json['qrToken'];
    qrCreatedAt = json['qrCreatedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    distanceKm = json['distanceKm'];
    distanceMeters = json['distanceMeters'];
    distance = json['distance'];
  }
  String? id;
  String? requestId;
  String? bloodType;
  String? hospitalName;
  dynamic patientType;
  String? contactNumber;
  int? unitsNeeded;
  bool? isEmergency;
  String? createdAt;
  String? status;
  String? requestStatus;
  String? urgency;
  String? type;
  String? requiredBy;
  LocationHospital? locationHospital;
  String? googleMapsUrl;
  dynamic qrToken;
  dynamic qrCreatedAt;
  dynamic qrExpiresAt;
  Hospital? hospital;
  dynamic distanceKm;
  dynamic distanceMeters;
  dynamic distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['requestId'] = requestId;
    map['bloodType'] = bloodType;
    map['hospitalName'] = hospitalName;
    map['patientType'] = patientType;
    map['contactNumber'] = contactNumber;
    map['unitsNeeded'] = unitsNeeded;
    map['isEmergency'] = isEmergency;
    map['createdAt'] = createdAt;
    map['status'] = status;
    map['requestStatus'] = requestStatus;
    map['urgency'] = urgency;
    map['type'] = type;
    map['requiredBy'] = requiredBy;
    if (locationHospital != null) {
      map['locationHospital'] = locationHospital?.toJson();
    }
    map['googleMapsUrl'] = googleMapsUrl;
    map['qrToken'] = qrToken;
    map['qrCreatedAt'] = qrCreatedAt;
    map['qrExpiresAt'] = qrExpiresAt;
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    return map;
  }

}

/// id : "6a07521ef89827b0ef07e125"
/// name : "General Test Hospital"
/// contactNumber : "2000000000"
/// address : {"city":"Test City","governorate":"Test Governorate"}
/// latitude : 30.0444
/// longitude : 31.2357

class Hospital {
  Hospital({
      this.id, 
      this.name, 
      this.contactNumber, 
      this.address, 
      this.latitude, 
      this.longitude,});

  Hospital.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? id;
  String? name;
  String? contactNumber;
  Address? address;
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['contactNumber'] = contactNumber;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

/// city : "Test City"
/// governorate : "Test Governorate"

class Address {
  Address({
      this.city, 
      this.governorate,});

  Address.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
  }
  String? city;
  String? governorate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    return map;
  }

}

/// latitude : 30.0444
/// longitude : 31.2357

class LocationHospital {
  LocationHospital({
      this.latitude, 
      this.longitude,});

  LocationHospital.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}