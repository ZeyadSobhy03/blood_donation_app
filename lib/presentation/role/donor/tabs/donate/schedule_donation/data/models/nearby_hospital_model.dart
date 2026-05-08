/// success : true
/// message : "Nearby hospitals retrieved successfully"
/// data : {"hospitals":[{"hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo"},"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-04-30T23:02:38.003Z"}},{"hospitalId":"69f3df925f42685cbbbcbb1c","hospital_id":"69f3df925f42685cbbbcbb1c","name":"Nile Hope Medical Center","fullName":"Nile Hope Blood Bank","contactNumber":"1055555555","email":"bloodbank@nilehope.demo","address":{"city":"Giza","governorate":"Giza"},"location":{"coordinates":{"lat":29.9953,"lng":31.2087},"city":"Giza","governorate":"Giza","lastUpdated":"2026-04-30T23:02:38.003Z"}}],"total":2}

class NearbyHospitalModel {
  NearbyHospitalModel({
      this.success, 
      this.message, 
      this.data,});

  NearbyHospitalModel.fromJson(dynamic json) {
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

/// hospitals : [{"hospitalId":"69f3df915f42685cbbbcbb1b","hospital_id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","fullName":"Cairo Care Operations","contactNumber":"1044444444","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo"},"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-04-30T23:02:38.003Z"}},{"hospitalId":"69f3df925f42685cbbbcbb1c","hospital_id":"69f3df925f42685cbbbcbb1c","name":"Nile Hope Medical Center","fullName":"Nile Hope Blood Bank","contactNumber":"1055555555","email":"bloodbank@nilehope.demo","address":{"city":"Giza","governorate":"Giza"},"location":{"coordinates":{"lat":29.9953,"lng":31.2087},"city":"Giza","governorate":"Giza","lastUpdated":"2026-04-30T23:02:38.003Z"}}]
/// total : 2

class Data {
  Data({
      this.hospitals, 
      this.total,});

  Data.fromJson(dynamic json) {
    if (json['hospitals'] != null) {
      hospitals = [];
      json['hospitals'].forEach((v) {
        hospitals?.add(Hospitals.fromJson(v));
      });
    }
    total = json['total'];
  }
  List<Hospitals>? hospitals;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hospitals != null) {
      map['hospitals'] = hospitals?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }

}

/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// hospital_id : "69f3df915f42685cbbbcbb1b"
/// name : "Cairo Care Hospital"
/// fullName : "Cairo Care Operations"
/// contactNumber : "1044444444"
/// email : "ops@cairocare.demo"
/// address : {"city":"Cairo","governorate":"Cairo"}
/// location : {"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-04-30T23:02:38.003Z"}

class Hospitals {
  Hospitals({
      this.hospitalId, 
      this.name,
      this.fullName, 
      this.contactNumber, 
      this.email, 
      this.address, 
      this.location,});

  Hospitals.fromJson(dynamic json) {
    hospitalId = json['hospitalId'];
    name = json['name'];
    fullName = json['fullName'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? hospitalId;

  String? name;
  String? fullName;
  String? contactNumber;
  String? email;
  Address? address;
  Location? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hospitalId'] = hospitalId;
    map['name'] = name;
    map['fullName'] = fullName;
    map['contactNumber'] = contactNumber;
    map['email'] = email;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }

}

/// coordinates : {"lat":30.0511,"lng":31.2435}
/// city : "Cairo"
/// governorate : "Cairo"
/// lastUpdated : "2026-04-30T23:02:38.003Z"

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