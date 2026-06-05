/// success : true
/// message : "Nearby requests retrieved successfully"
/// data : {"requests":[{"id":"6a130e83f9830f9b4aeb149d","requestId":"6a130e83f9830f9b4aeb149d","bloodType":["O+","A+"],"bloodTypeLabel":"O+, A+","hospitalName":"Cairo Care Hospital","patientType":"Emergency blood loss response - critical responder match","contactNumber":"1044444444","unitsNeeded":2,"isEmergency":true,"createdAt":"2026-05-24T14:43:15.108Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"blood","requiredBy":"2026-05-31T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a130e82f9830f9b4aeb149a","requestId":"6a130e82f9830f9b4aeb149a","bloodType":["AB+","O+"],"bloodTypeLabel":"AB+, O+","hospitalName":"Cairo Care Hospital","patientType":"Trauma patient requiring urgent plasma transfusion","contactNumber":"1044444444","unitsNeeded":5,"isEmergency":true,"createdAt":"2026-05-24T14:43:14.917Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"plasma","requiredBy":"2026-05-31T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a130e82f9830f9b4aeb1494","requestId":"6a130e82f9830f9b4aeb1494","bloodType":["O+","B-"],"bloodTypeLabel":"O+, B-","hospitalName":"Cairo Care Hospital","patientType":"Emergency surgery support","contactNumber":"1044444444","unitsNeeded":3,"isEmergency":true,"createdAt":"2026-05-24T14:43:14.523Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"blood","requiredBy":"2026-06-01T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a1a03f485d2cd97a5b5c072","requestId":"6a1a03f485d2cd97a5b5c072","bloodType":["O+"],"bloodTypeLabel":"O+","hospitalName":"Test Hospital","patientType":null,"contactNumber":"2000000000","unitsNeeded":2,"isEmergency":false,"createdAt":"2026-05-29T21:24:04.934Z","status":"pending","requestStatus":"pending","urgency":"high","type":"blood","requiredBy":"2026-06-01T21:24:04.930Z","locationHospital":{"latitude":30.0444,"longitude":31.2357},"location":{"lat":30.0444,"lng":31.2357},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a1a03f485d2cd97a5b5c071","name":"Test Hospital","contactNumber":"2000000000","address":{"city":"Test City","governorate":"Test Governorate"},"latitude":30.0444,"longitude":31.2357},"distanceKm":1.06,"distanceMeters":1058,"distance":"1.06 km"}],"pagination":{"total":4,"page":1,"currentPage":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false},"viewerLocation":{"latitude":30.0511,"longitude":31.2435},"radiusKm":25}

class RequestsModel {
  RequestsModel({
      this.success, 
      this.message, 
      this.data,});

  RequestsModel.fromJson(dynamic json) {
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

/// requests : [{"id":"6a130e83f9830f9b4aeb149d","requestId":"6a130e83f9830f9b4aeb149d","bloodType":["O+","A+"],"bloodTypeLabel":"O+, A+","hospitalName":"Cairo Care Hospital","patientType":"Emergency blood loss response - critical responder match","contactNumber":"1044444444","unitsNeeded":2,"isEmergency":true,"createdAt":"2026-05-24T14:43:15.108Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"blood","requiredBy":"2026-05-31T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a130e82f9830f9b4aeb149a","requestId":"6a130e82f9830f9b4aeb149a","bloodType":["AB+","O+"],"bloodTypeLabel":"AB+, O+","hospitalName":"Cairo Care Hospital","patientType":"Trauma patient requiring urgent plasma transfusion","contactNumber":"1044444444","unitsNeeded":5,"isEmergency":true,"createdAt":"2026-05-24T14:43:14.917Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"plasma","requiredBy":"2026-05-31T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a130e82f9830f9b4aeb1494","requestId":"6a130e82f9830f9b4aeb1494","bloodType":["O+","B-"],"bloodTypeLabel":"O+, B-","hospitalName":"Cairo Care Hospital","patientType":"Emergency surgery support","contactNumber":"1044444444","unitsNeeded":3,"isEmergency":true,"createdAt":"2026-05-24T14:43:14.523Z","status":"pending","requestStatus":"pending","urgency":"critical","type":"blood","requiredBy":"2026-06-01T07:00:00.000Z","locationHospital":{"latitude":30.0511,"longitude":31.2435},"location":{"lat":30.0511,"lng":31.2435},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435},"distanceKm":0,"distanceMeters":0,"distance":"0 m"},{"id":"6a1a03f485d2cd97a5b5c072","requestId":"6a1a03f485d2cd97a5b5c072","bloodType":["O+"],"bloodTypeLabel":"O+","hospitalName":"Test Hospital","patientType":null,"contactNumber":"2000000000","unitsNeeded":2,"isEmergency":false,"createdAt":"2026-05-29T21:24:04.934Z","status":"pending","requestStatus":"pending","urgency":"high","type":"blood","requiredBy":"2026-06-01T21:24:04.930Z","locationHospital":{"latitude":30.0444,"longitude":31.2357},"location":{"lat":30.0444,"lng":31.2357},"qrToken":null,"qrCreatedAt":null,"qrExpiresAt":null,"hospital":{"id":"6a1a03f485d2cd97a5b5c071","name":"Test Hospital","contactNumber":"2000000000","address":{"city":"Test City","governorate":"Test Governorate"},"latitude":30.0444,"longitude":31.2357},"distanceKm":1.06,"distanceMeters":1058,"distance":"1.06 km"}]
/// pagination : {"total":4,"page":1,"currentPage":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}
/// viewerLocation : {"latitude":30.0511,"longitude":31.2435}
/// radiusKm : 25

class Data {
  Data({
      this.requests, 
      this.pagination, 
      this.viewerLocation, 
      this.radiusKm,});

  Data.fromJson(dynamic json) {
    if (json['requests'] != null) {
      requests = [];
      json['requests'].forEach((v) {
        requests?.add(Requests.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    viewerLocation = json['viewerLocation'] != null ? ViewerLocation.fromJson(json['viewerLocation']) : null;
    radiusKm = json['radiusKm'];
  }
  List<Requests>? requests;
  Pagination? pagination;
  ViewerLocation? viewerLocation;
  int? radiusKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requests != null) {
      map['requests'] = requests?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    if (viewerLocation != null) {
      map['viewerLocation'] = viewerLocation?.toJson();
    }
    map['radiusKm'] = radiusKm;
    return map;
  }

}

/// latitude : 30.0511
/// longitude : 31.2435

class ViewerLocation {
  ViewerLocation({
      this.latitude, 
      this.longitude,});

  ViewerLocation.fromJson(dynamic json) {
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

/// total : 4
/// page : 1
/// currentPage : 1
/// limit : 20
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

/// id : "6a130e83f9830f9b4aeb149d"
/// requestId : "6a130e83f9830f9b4aeb149d"
/// bloodType : ["O+","A+"]
/// bloodTypeLabel : "O+, A+"
/// hospitalName : "Cairo Care Hospital"
/// patientType : "Emergency blood loss response - critical responder match"
/// contactNumber : "1044444444"
/// unitsNeeded : 2
/// isEmergency : true
/// createdAt : "2026-05-24T14:43:15.108Z"
/// status : "pending"
/// requestStatus : "pending"
/// urgency : "critical"
/// type : "blood"
/// requiredBy : "2026-05-31T07:00:00.000Z"
/// locationHospital : {"latitude":30.0511,"longitude":31.2435}
/// location : {"lat":30.0511,"lng":31.2435}
/// qrToken : null
/// qrCreatedAt : null
/// qrExpiresAt : null
/// hospital : {"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435}
/// distanceKm : 0
/// distanceMeters : 0
/// distance : "0 m"

class Requests {
  Requests({
      this.id, 
      this.requestId, 
      this.bloodType, 
      this.bloodTypeLabel, 
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
      this.location, 
      this.qrToken, 
      this.qrCreatedAt, 
      this.qrExpiresAt, 
      this.hospital, 
      this.distanceKm, 
      this.distanceMeters, 
      this.distance,});

  Requests.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['requestId'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    bloodTypeLabel = json['bloodTypeLabel'];
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
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    qrToken = json['qrToken'];
    qrCreatedAt = json['qrCreatedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    distanceKm = (json['distanceKm'] as num?)?.toDouble();
    distanceMeters = (json['distanceMeters'] as num?)?.toDouble();
    distance = json['distance'];
  }
  String? id;
  String? requestId;
  List<String>? bloodType;
  String? bloodTypeLabel;
  String? hospitalName;
  String? patientType;
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
  Location? location;
  dynamic qrToken;
  dynamic qrCreatedAt;
  dynamic qrExpiresAt;
  Hospital? hospital;
  double? distanceKm;
  double? distanceMeters;
  String? distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['requestId'] = requestId;
    map['bloodType'] = bloodType;
    map['bloodTypeLabel'] = bloodTypeLabel;
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
    if (location != null) {
      map['location'] = location?.toJson();
    }
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

/// id : "6a130e820b339a45a51addb4"
/// name : "Cairo Care Hospital"
/// contactNumber : "1044444444"
/// address : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
/// latitude : 30.0511
/// longitude : 31.2435

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

/// lat : 30.0511
/// lng : 31.2435

class Location {
  Location({
      this.lat, 
      this.lng,});

  Location.fromJson(dynamic json) {
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

/// latitude : 30.0511
/// longitude : 31.2435

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