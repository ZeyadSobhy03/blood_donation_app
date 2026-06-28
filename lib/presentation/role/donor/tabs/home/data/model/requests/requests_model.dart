/// success : true
/// message : "Matching requests retrieved successfully"
/// data : {"matches":[...],"pagination":{...}}

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

/// matches : [...]
/// pagination : {...}

class Data {
  Data({
    this.matches,
    this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['matches'] != null) {
      matches = [];
      json['matches'].forEach((v) {
        matches?.add(Matches.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Matches>? matches;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (matches != null) {
      map['matches'] = matches?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 10
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

/// request : {...}
/// score : 120.7
/// locationScore : 96.47441997242002
/// compatibility : {...}

class Matches {
  Matches({
    this.request,
    this.score,
    this.locationScore,
    this.compatibility,});

  Matches.fromJson(dynamic json) {
    request = json['request'] != null ? Request.fromJson(json['request']) : null;
    score = json['score'];
    locationScore = json['locationScore'];
    compatibility = json['compatibility'] != null ? Compatibility.fromJson(json['compatibility']) : null;
  }
  Request? request;
  double? score;
  double? locationScore;
  Compatibility? compatibility;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (request != null) {
      map['request'] = request?.toJson();
    }
    map['score'] = score;
    map['locationScore'] = locationScore;
    if (compatibility != null) {
      map['compatibility'] = compatibility?.toJson();
    }
    return map;
  }

}

/// bloodTypeMatch : true
/// eligible : true
/// distanceKm : 1.06

class Compatibility {
  Compatibility({
    this.bloodTypeMatch,
    this.eligible,
    this.distanceKm,});

  Compatibility.fromJson(dynamic json) {
    bloodTypeMatch = json['bloodTypeMatch'];
    eligible = json['eligible'];
    distanceKm = json['distanceKm'];
  }
  bool? bloodTypeMatch;
  bool? eligible;
  double? distanceKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bloodTypeMatch'] = bloodTypeMatch;
    map['eligible'] = eligible;
    map['distanceKm'] = distanceKm;
    return map;
  }

}

/// _id : "6a2ebf149be69755f14bce14"
/// id : "6a2ebf149be69755f14bce14"
/// requestId : "6a2ebf149be69755f14bce14"
/// type : "blood"
/// bloodType : ["O+","O-"]
/// urgency : "critical"
/// status : "pending"
/// isEmergency : true
/// quantity : 2
/// unitsNeeded : 2
/// requiredBy : "2026-06-28T07:00:00.000Z"
/// hospitalName : "Cairo Care Operations"
/// hospitalContact : "1044444444"
/// contactNumber : "1044444444"
/// createdAt : "2026-06-14T14:47:48.765Z"
/// patientType : "general"
/// patientDetails : null
/// locationHospital : {"latitude":30.0511,"longitude":31.2435}
/// hospital : {...}
/// distanceKm : 1.06
/// distanceMeters : 1058
/// distance : "1.06 km"
/// estimatedTime : "2 min"
/// posted : "2026-06-14T14:47:48.765Z"
/// hospitalLatitude : 30.0511
/// hospitalLongitude : 31.2435

class Request {
  Request({
    this.id,
    this.requestId,
    this.type,
    this.bloodType,
    this.urgency,
    this.status,
    this.isEmergency,
    this.quantity,
    this.unitsNeeded,
    this.requiredBy,
    this.hospitalName,
    this.hospitalContact,
    this.contactNumber,
    this.createdAt,
    this.patientType,
    this.patientDetails,
    this.locationHospital,
    this.hospital,
    this.distanceKm,
    this.distanceMeters,
    this.distance,
    this.estimatedTime,
    this.posted,
    this.hospitalLatitude,
    this.hospitalLongitude,});

  Request.fromJson(dynamic json) {
    id = json['_id'];
    id = json['id'];
    requestId = json['requestId'];
    type = json['type'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    urgency = json['urgency'];
    status = json['status'];
    isEmergency = json['isEmergency'];
    quantity = json['quantity'];
    unitsNeeded = json['unitsNeeded'];
    requiredBy = json['requiredBy'];
    hospitalName = json['hospitalName'];
    hospitalContact = json['hospitalContact'];
    contactNumber = json['contactNumber'];
    createdAt = json['createdAt'];
    patientType = json['patientType'];
    patientDetails = json['patientDetails'];
    locationHospital = json['locationHospital'] != null ? LocationHospital.fromJson(json['locationHospital']) : null;
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    distanceKm = json['distanceKm'];
    distanceMeters = json['distanceMeters'];
    distance = json['distance'];
    estimatedTime = json['estimatedTime'];
    posted = json['posted'];
    hospitalLatitude = json['hospitalLatitude'];
    hospitalLongitude = json['hospitalLongitude'];
  }
  String? id;
  String? requestId;
  String? type;
  List<String>? bloodType;
  String? urgency;
  String? status;
  bool? isEmergency;
  int? quantity;
  int? unitsNeeded;
  String? requiredBy;
  String? hospitalName;
  String? hospitalContact;
  String? contactNumber;
  String? createdAt;
  String? patientType;
  dynamic patientDetails;
  LocationHospital? locationHospital;
  Hospital? hospital;
  double? distanceKm;
  int? distanceMeters;
  String? distance;
  String? estimatedTime;
  String? posted;
  double? hospitalLatitude;
  double? hospitalLongitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['id'] = id;
    map['requestId'] = requestId;
    map['type'] = type;
    map['bloodType'] = bloodType;
    map['urgency'] = urgency;
    map['status'] = status;
    map['isEmergency'] = isEmergency;
    map['quantity'] = quantity;
    map['unitsNeeded'] = unitsNeeded;
    map['requiredBy'] = requiredBy;
    map['hospitalName'] = hospitalName;
    map['hospitalContact'] = hospitalContact;
    map['contactNumber'] = contactNumber;
    map['createdAt'] = createdAt;
    map['patientType'] = patientType;
    map['patientDetails'] = patientDetails;
    if (locationHospital != null) {
      map['locationHospital'] = locationHospital?.toJson();
    }
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    map['estimatedTime'] = estimatedTime;
    map['posted'] = posted;
    map['hospitalLatitude'] = hospitalLatitude;
    map['hospitalLongitude'] = hospitalLongitude;
    return map;
  }

}

/// id : "6a130e820b339a45a51addb4"
/// name : "Cairo Care Operations"
/// contactNumber : "1044444444"
/// address : "Cairo, Garden City" OR {"city":"Cairo","governorate":"Cairo","district":"Cairo"}
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
/// - Object:  {"city":"Cairo","governorate":"Cairo","district":"Cairo"}
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