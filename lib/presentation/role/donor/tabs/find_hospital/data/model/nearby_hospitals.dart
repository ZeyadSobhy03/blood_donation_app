/// success : true
/// data : {"hospitals":[{"hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","phoneNumber":"1044444444","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"location":{"lat":30.0511,"lng":31.2435},"lat":30.0511,"lng":31.2435,"hospitalType":"General Hospital","workingHours":"9AM - 5PM","bloodTypes":["O+","O-","A+","A-","B+","AB+"],"isAvailable":true,"urgentNeedsCount":3,"distanceKm":0}],"pagination":{"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class NearbyHospitals {
  NearbyHospitals({
      this.success, 
      this.data,});

  NearbyHospitals.fromJson(dynamic json) {
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

/// hospitals : [{"hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","phoneNumber":"1044444444","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"location":{"lat":30.0511,"lng":31.2435},"lat":30.0511,"lng":31.2435,"hospitalType":"General Hospital","workingHours":"9AM - 5PM","bloodTypes":["O+","O-","A+","A-","B+","AB+"],"isAvailable":true,"urgentNeedsCount":3,"distanceKm":0}]
/// pagination : {"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

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

/// total : 1
/// page : 1
/// limit : 20
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.hasNextPage, 
      this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }

}

/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// hospital_id : "69f3df915f42685cbbbcbb1b"
/// name : "Cairo Care Hospital"
/// fullName : "Cairo Care Operations"
/// phoneNumber : "1044444444"
/// contactNumber : "1044444444"
/// email : "ops@cairocare.demo"
/// address : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
/// location : {"lat":30.0511,"lng":31.2435}
/// lat : 30.0511
/// lng : 31.2435
/// hospitalType : "General Hospital"
/// workingHours : "9AM - 5PM"
/// bloodTypes : ["O+","O-","A+","A-","B+","AB+"]
/// isAvailable : true
/// urgentNeedsCount : 3
/// distanceKm : 0

class Hospitals {
  Hospitals({
      this.hospitalId, 
      this.name,
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
      this.distanceKm,});

  Hospitals.fromJson(dynamic json) {
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
  }
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
  int? distanceKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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