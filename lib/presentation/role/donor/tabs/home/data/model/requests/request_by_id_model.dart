/// success : true
/// message : "Request details retrieved successfully"
/// data : {...}

class RequestByIdModel {
  RequestByIdModel({
    this.success,
    this.message,
    this.data,});

  RequestByIdModel.fromJson(dynamic json) {
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

class Data {
  Data({
    this.id,
    this.requestId,
    this.bloodType,
    this.hospitalName,
    this.patientType,
    this.patientDetails,
    this.contactNumber,
    this.unitsNeeded,
    this.quantity,
    this.isEmergency,
    this.createdAt,
    this.status,
    this.urgency,
    this.type,
    this.requiredBy,
    this.location,
    this.locationHospital,
    this.hospitalContact,
    this.qrToken,
    this.qrCreatedAt,
    this.qrExpiresAt,
    this.hospital,
    this.distanceKm,
    this.distanceMeters,
    this.distance,
    this.estimatedTime,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    id = json['id'];
    requestId = json['requestId'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    hospitalName = json['hospitalName'];
    patientType = json['patientType'];
    patientDetails = json['patientDetails'];
    contactNumber = json['contactNumber'];
    unitsNeeded = json['unitsNeeded'];
    quantity = json['quantity'];
    isEmergency = json['isEmergency'];
    createdAt = json['createdAt'];
    status = json['status'];
    urgency = json['urgency'];
    type = json['type'];
    requiredBy = json['requiredBy'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    locationHospital = json['locationHospital'] != null ? LocationHospital.fromJson(json['locationHospital']) : null;
    hospitalContact = json['hospitalContact'];
    qrToken = json['qrToken'];
    qrCreatedAt = json['qrCreatedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    distanceKm = json['distanceKm'];
    distanceMeters = json['distanceMeters'];
    distance = json['distance'];
    estimatedTime = json['estimatedTime'];
  }
  String? id;
  String? requestId;
  List<String>? bloodType;
  String? hospitalName;
  String? patientType;
  dynamic patientDetails;
  String? contactNumber;
  int? unitsNeeded;
  int? quantity;
  bool? isEmergency;
  String? createdAt;
  String? status;
  String? urgency;
  String? type;
  String? requiredBy;
  Location? location;
  LocationHospital? locationHospital;
  String? hospitalContact;
  dynamic qrToken;
  dynamic qrCreatedAt;
  dynamic qrExpiresAt;
  Hospital? hospital;
  dynamic distanceKm;
  dynamic distanceMeters;
  dynamic distance;
  dynamic estimatedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['id'] = id;
    map['requestId'] = requestId;
    map['bloodType'] = bloodType;
    map['hospitalName'] = hospitalName;
    map['patientType'] = patientType;
    map['patientDetails'] = patientDetails;
    map['contactNumber'] = contactNumber;
    map['unitsNeeded'] = unitsNeeded;
    map['quantity'] = quantity;
    map['isEmergency'] = isEmergency;
    map['createdAt'] = createdAt;
    map['status'] = status;
    map['urgency'] = urgency;
    map['type'] = type;
    map['requiredBy'] = requiredBy;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (locationHospital != null) {
      map['locationHospital'] = locationHospital?.toJson();
    }
    map['hospitalContact'] = hospitalContact;
    map['qrToken'] = qrToken;
    map['qrCreatedAt'] = qrCreatedAt;
    map['qrExpiresAt'] = qrExpiresAt;
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    map['estimatedTime'] = estimatedTime;
    return map;
  }

}

/// id : "6a130e820b339a45a51addb4"
/// name : "Cairo Care Operations"
/// contactNumber : "1044444444"
/// address : "Cairo, Garden City" OR {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
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

/// Handles both API shapes for "address":
/// - String:  "Cairo, Garden City"
/// - Object:  {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
class Address {
  Address({
    this.raw,
    this.city,
    this.governorate,
    this.district,});

  factory Address.fromJson(dynamic json) {
    if (json is String) {
      return Address(raw: json);
    } else if (json is Map<String, dynamic>) {
      return Address(
        city: json['city'],
        governorate: json['governorate'],
        district: json['district'],
      );
    }
    return Address();
  }

  String? raw;
  String? city;
  String? governorate;
  String? district;

  Map<String, dynamic> toJson() {
    if (raw != null) return {'address': raw};
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    map['district'] = district;
    return map;
  }

  /// Friendly display string regardless of which shape the API sent
  @override
  String toString() {
    if (raw != null && raw!.isNotEmpty) return raw!;
    return [governorate, city, district]
        .where((e) => e != null && e.isNotEmpty)
        .toSet()
        .join(', ');
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