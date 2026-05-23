class RequestsModel {
  RequestsModel({this.success, this.data});

  RequestsModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class Data {
  Data({this.requests, this.pagination, this.viewerLocation, this.radiusKm});

  Data.fromJson(dynamic json) {
    if (json['requests'] != null) {
      requests = [];
      json['requests'].forEach((v) {
        requests?.add(Requests.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    viewerLocation = json['viewerLocation'] != null
        ? ViewerLocation.fromJson(json['viewerLocation'])
        : null;
    radiusKm = (json['radiusKm'] as num?)?.toInt();
  }

  List<Requests>? requests;
  Pagination? pagination;
  ViewerLocation? viewerLocation;
  int? radiusKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requests != null) map['requests'] = requests?.map((v) => v.toJson()).toList();
    if (pagination != null) map['pagination'] = pagination?.toJson();
    if (viewerLocation != null) map['viewerLocation'] = viewerLocation?.toJson();
    map['radiusKm'] = radiusKm;
    return map;
  }
}

class ViewerLocation {
  ViewerLocation({this.latitude, this.longitude});

  ViewerLocation.fromJson(dynamic json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
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

class Pagination {
  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(dynamic json) {
    total = (json['total'] as num?)?.toInt();
    page = (json['page'] as num?)?.toInt();
    limit = (json['limit'] as num?)?.toInt();
    totalPages = (json['totalPages'] as num?)?.toInt();
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

class Requests {
  Requests({
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
    this.distance,
  });

  Requests.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['requestId'];
    bloodType = json['bloodType'];
    hospitalName = json['hospitalName'];
    patientType = json['patientType'];
    contactNumber = json['contactNumber'];
    unitsNeeded = (json['unitsNeeded'] as num?)?.toInt();
    isEmergency = json['isEmergency'];
    createdAt = json['createdAt'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    urgency = json['urgency'];
    type = json['type'];
    requiredBy = json['requiredBy'];
    locationHospital = json['locationHospital'] != null
        ? LocationHospital.fromJson(json['locationHospital'])
        : null;
    googleMapsUrl = json['googleMapsUrl'];
    qrToken = json['qrToken'];
    qrCreatedAt = json['qrCreatedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    hospital = json['hospital'] != null
        ? Hospital.fromJson(json['hospital'])
        : null;
    distanceKm = (json['distanceKm'] as num?)?.toDouble();
    distanceMeters = (json['distanceMeters'] as num?)?.toDouble();
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
  double? distanceKm;
  double? distanceMeters;
  String? distance;

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
    if (locationHospital != null) map['locationHospital'] = locationHospital?.toJson();
    map['googleMapsUrl'] = googleMapsUrl;
    map['qrToken'] = qrToken;
    map['qrCreatedAt'] = qrCreatedAt;
    map['qrExpiresAt'] = qrExpiresAt;
    if (hospital != null) map['hospital'] = hospital?.toJson();
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    return map;
  }
}

class Hospital {
  Hospital({
    this.id,
    this.name,
    this.contactNumber,
    this.address,
    this.latitude,
    this.longitude,
  });

  Hospital.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
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
    if (address != null) map['address'] = address?.toJson();
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

class Address {
  Address({this.city, this.governorate});

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

class LocationHospital {
  LocationHospital({this.latitude, this.longitude});

  LocationHospital.fromJson(dynamic json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
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