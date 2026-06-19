/// success : true
/// message : "Nearby hospitals retrieved successfully"
/// data : {"hospitals":[{"id":"69f3df915f42685cbbbcbb1b","hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","phoneNumber":"1044444444","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo"},"location":{"lat":30.0511,"lng":31.2435},"lat":30.0511,"lng":31.2435,"hospitalType":"General Hospital","workingHours":"9AM - 5PM","bloodTypes":["O+","A-"],"isAvailable":true,"urgentNeedsCount":2,"distanceKm":2.35,"distanceMeters":2350,"distance":"2.35 km","appointmentSchedulingEnabled":true,"hospitalActive":true,"hospitalVerified":true}],"pagination":{"page":1,"limit":20,"total":1}}

class NearbyHospitals {
  NearbyHospitals({
      this.success, 
      this.message, 
      this.data,});

  NearbyHospitals.fromJson(dynamic json) {
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

/// hospitals : [{"id":"69f3df915f42685cbbbcbb1b","hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","phoneNumber":"1044444444","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo"},"location":{"lat":30.0511,"lng":31.2435},"lat":30.0511,"lng":31.2435,"hospitalType":"General Hospital","workingHours":"9AM - 5PM","bloodTypes":["O+","A-"],"isAvailable":true,"urgentNeedsCount":2,"distanceKm":2.35,"distanceMeters":2350,"distance":"2.35 km","appointmentSchedulingEnabled":true,"hospitalActive":true,"hospitalVerified":true}]
/// pagination : {"page":1,"limit":20,"total":1}

class Data {
  Data({
      this.hospitals, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['hospitals'] != null) {
      hospitals = [];
      json['hospitals'].forEach((v) {
        hospitals?.add(Hospitals.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Hospitals>? hospitals;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hospitals != null) {
      map['hospitals'] = hospitals?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// page : 1
/// limit : 20
/// total : 1

class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }
  int? page;
  int? limit;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    return map;
  }

}

/// id : "69f3df915f42685cbbbcbb1b"
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// hospital_id : "69f3df915f42685cbbbcbb1b"
/// name : "Cairo Care Hospital"
/// fullName : "Cairo Care Operations"
/// phoneNumber : "1044444444"
/// contactNumber : "1044444444"
/// email : "ops@cairocare.demo"
/// address : {"city":"Cairo","governorate":"Cairo"}
/// location : {"lat":30.0511,"lng":31.2435}
/// lat : 30.0511
/// lng : 31.2435
/// hospitalType : "General Hospital"
/// workingHours : "9AM - 5PM"
/// bloodTypes : ["O+","A-"]
/// isAvailable : true
/// urgentNeedsCount : 2
/// distanceKm : 2.35
/// distanceMeters : 2350
/// distance : "2.35 km"
/// appointmentSchedulingEnabled : true
/// hospitalActive : true
/// hospitalVerified : true

class Hospitals {
  Hospitals({
      this.id, 
      this.hospitalId, 
      this.fullName,
      this.phoneNumber, 
      this.contactNumber, 
      this.email, 
      this.address, 
      this.location, 
      this.lat, 
      this.lng, 
      this.hospitalType, 
      this.workingHours, 
      this.bloodTypes, 
      this.isAvailable, 
      this.urgentNeedsCount, 
      this.distanceKm, 
      this.distanceMeters, 
      this.distance, 
      this.appointmentSchedulingEnabled, 
      this.hospitalActive, 
      this.hospitalVerified,});

  Hospitals.fromJson(dynamic json) {
    id = json['id'];
    hospitalId = json['hospitalId'];
    hospitalId = json['hospital_id'];
    name = json['name'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    lat = json['lat'];
    lng = json['lng'];
    hospitalType = json['hospitalType'];
    workingHours = json['workingHours'];
    bloodTypes = json['bloodTypes'] != null ? json['bloodTypes'].cast<String>() : [];
    isAvailable = json['isAvailable'];
    urgentNeedsCount = json['urgentNeedsCount'];
    distanceKm = json['distanceKm'];
    distanceMeters = json['distanceMeters'];
    distance = json['distance'];
    appointmentSchedulingEnabled = json['appointmentSchedulingEnabled'];
    hospitalActive = json['hospitalActive'];
    hospitalVerified = json['hospitalVerified'];
  }
  String? id;
  String? hospitalId;
  String? name;
  String? fullName;
  String? phoneNumber;
  String? contactNumber;
  String? email;
  Address? address;
  Location? location;
  double? lat;
  double? lng;
  String? hospitalType;
  String? workingHours;
  List<String>? bloodTypes;
  bool? isAvailable;
  int? urgentNeedsCount;
  double? distanceKm;
  int? distanceMeters;
  String? distance;
  bool? appointmentSchedulingEnabled;
  bool? hospitalActive;
  bool? hospitalVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['hospitalId'] = hospitalId;
    map['hospital_id'] = hospitalId;
    map['name'] = name;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['contactNumber'] = contactNumber;
    map['email'] = email;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['lat'] = lat;
    map['lng'] = lng;
    map['hospitalType'] = hospitalType;
    map['workingHours'] = workingHours;
    map['bloodTypes'] = bloodTypes;
    map['isAvailable'] = isAvailable;
    map['urgentNeedsCount'] = urgentNeedsCount;
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    map['appointmentSchedulingEnabled'] = appointmentSchedulingEnabled;
    map['hospitalActive'] = hospitalActive;
    map['hospitalVerified'] = hospitalVerified;
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

/// city : "Cairo"
/// governorate : "Cairo"

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