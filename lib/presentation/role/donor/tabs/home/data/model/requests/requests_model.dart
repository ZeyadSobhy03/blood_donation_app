/// success : true
/// message : "Matching requests retrieved successfully"
/// data : {"matches":[...],"pagination":{...}}

class RequestsModel {
  RequestsModel({
    this.success,
    this.message,
    this.data,
  });

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

class Data {
  Data({
    this.matches,
    this.pagination,
  });

  Data.fromJson(dynamic json) {
    if (json['matches'] != null) {
      matches = [];
      json['matches'].forEach((v) {
        matches?.add(Matches.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  List<Matches>? matches;
  Pagination? pagination;

  /// Getter to extract List<Requests> from List<Matches>
  List<Requests> get requestsList =>
      matches
          ?.where((m) => m.request != null)
          .map((m) => m.request!)
          .toList() ??
          [];

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

class Pagination {
  Pagination({
    this.page,
    this.limit,
    this.total,
  });

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

class Matches {
  Matches({
    this.score,
    this.locationScore,
    this.compatibility,
    this.request,
  });

  Matches.fromJson(dynamic json) {
    score = json['score'];
    locationScore = json['locationScore'];
    compatibility = json['compatibility'] != null
        ? Compatibility.fromJson(json['compatibility'])
        : null;
    request =
    json['request'] != null ? Requests.fromJson(json['request']) : null;
  }

  double? score;
  double? locationScore;
  Compatibility? compatibility;
  Requests? request;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['locationScore'] = locationScore;
    if (compatibility != null) {
      map['compatibility'] = compatibility?.toJson();
    }
    if (request != null) {
      map['request'] = request?.toJson();
    }
    return map;
  }
}

class Requests {
  Requests({
    this.id,
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
    this.createdAt,
    this.locationHospital,
    this.hospital,
  });

  Requests.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    bloodType =
    json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    urgency = json['urgency'];
    status = json['status'];
    isEmergency = json['isEmergency'];
    quantity = json['quantity'];
    unitsNeeded = json['unitsNeeded'];
    requiredBy = json['requiredBy'];
    hospitalName = json['hospitalName'];
    hospitalContact = json['hospitalContact'];
    createdAt = json['createdAt'];
    locationHospital = json['locationHospital'] != null
        ? LocationHospital.fromJson(json['locationHospital'])
        : null;
    hospital =
    json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
  }

  String? id;
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
  String? createdAt;
  LocationHospital? locationHospital;
  Hospital? hospital;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
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
    map['createdAt'] = createdAt;
    if (locationHospital != null) {
      map['locationHospital'] = locationHospital?.toJson();
    }
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
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
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  String? id;
  String? name;
  String? contactNumber;
  String? address;
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['contactNumber'] = contactNumber;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

class LocationHospital {
  LocationHospital({
    this.latitude,
    this.longitude,
  });

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

class Compatibility {
  Compatibility({
    this.bloodTypeMatch,
    this.eligible,
    this.distanceKm,
  });

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