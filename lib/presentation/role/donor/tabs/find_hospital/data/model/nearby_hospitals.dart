/// success : true
/// message : "Nearby hospitals retrieved successfully"
/// data : {"hospitals":[{"hospitalId":"6a380a6df7410911492c1fe8","hospital_id":"6a380a6df7410911492c1fe8","name":"cairo","fullName":"cairo","contactNumber":"01141935341","email":"cairoaa@gmail.com","address":"cairo","location":{"lat":30.365123,"lng":30.523868},"lat":30.365123,"lng":30.523868,"long":30.523868,"hospitalType":"General Hospital","workingHours":"9AM - 5PM","bloodTypes":["A-","A+","AB+","O+"],"isAvailable":true,"urgentNeedsCount":0,"appointmentSchedulingEnabled":true,"hospitalActive":true,"hospitalVerified":true,"distanceKm":64.68,"distanceMeters":64683,"distance":"64.68 km"}],"pagination":{"total":1,"page":1,"currentPage":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class NearbyHospitals {
  NearbyHospitals({
    this.success,
    this.message,
    this.data,
  });

  NearbyHospitals.fromJson(dynamic json) {
    success = json['success'];
    message = json['message']?.toString();
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

/// hospitals : [...]
/// pagination : {...}

class Data {
  Data({
    this.hospitals,
    this.pagination,
  });

  Data.fromJson(dynamic json) {
    if (json['hospitals'] != null) {
      hospitals = [];
      json['hospitals'].forEach((v) {
        hospitals?.add(Hospitals.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
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
    this.hasPrevPage,
  });

  Pagination.fromJson(dynamic json) {
    total        = (json['total']        as num?)?.toInt();
    page         = (json['page']         as num?)?.toInt();
    currentPage  = (json['currentPage']  as num?)?.toInt();
    limit        = (json['limit']        as num?)?.toInt();
    totalPages   = (json['totalPages']   as num?)?.toInt();
    hasNextPage  = json['hasNextPage']   as bool?;
    hasPrevPage  = json['hasPrevPage']   as bool?;
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
    map['total']       = total;
    map['page']        = page;
    map['currentPage'] = currentPage;
    map['limit']       = limit;
    map['totalPages']  = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }
}

/// hospitalId : "6a380a6df7410911492c1fe8"
/// hospital_id : "6a380a6df7410911492c1fe8"
/// name : "cairo"
/// fullName : "cairo"
/// contactNumber : "01141935341"
/// email : "cairoaa@gmail.com"
/// address : "cairo"
/// location : {"lat":30.365123,"lng":30.523868}
/// lat : 30.365123
/// lng : 30.523868
/// long : 30.523868
/// hospitalType : "General Hospital"
/// workingHours : "9AM - 5PM"
/// bloodTypes : ["A-","A+","AB+","O+"]
/// isAvailable : true
/// urgentNeedsCount : 0
/// appointmentSchedulingEnabled : true
/// hospitalActive : true
/// hospitalVerified : true
/// distanceKm : 64.68
/// distanceMeters : 64683
/// distance : "64.68 km"

class Hospitals {
  Hospitals({
    this.hospitalId,
    this.name,
    this.fullName,
    this.contactNumber,
    this.email,
    this.address,
    this.location,
    this.lat,
    this.lng,
    this.long,
    this.hospitalType,
    this.workingHours,
    this.bloodTypes,
    this.isAvailable,
    this.urgentNeedsCount,
    this.appointmentSchedulingEnabled,
    this.hospitalActive,
    this.hospitalVerified,
    this.distanceKm,
    this.distanceMeters,
    this.distance,
  });

  Hospitals.fromJson(dynamic json) {
    hospitalId    = (json['hospitalId'] ?? json['hospital_id'])?.toString();
    name          = json['name']?.toString();
    fullName      = json['fullName']?.toString();
    contactNumber = json['contactNumber']?.toString();
    email         = json['email']?.toString();
    address       = json['address']?.toString();

    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;

    lat  = (json['lat']  as num?)?.toDouble();
    lng  = (json['lng']  as num?)?.toDouble();
    long = (json['long'] as num?)?.toDouble();

    hospitalType = json['hospitalType']?.toString();
    workingHours = json['workingHours']?.toString();

    bloodTypes = json['bloodTypes'] != null
        ? List<String>.from(
      (json['bloodTypes'] as List).map((e) => e.toString()),
    )
        : [];

    isAvailable                  = json['isAvailable']                  as bool?;
    urgentNeedsCount             = (json['urgentNeedsCount']             as num?)?.toInt();
    appointmentSchedulingEnabled = json['appointmentSchedulingEnabled']  as bool?;
    hospitalActive               = json['hospitalActive']                as bool?;
    hospitalVerified             = json['hospitalVerified']              as bool?;

    distanceKm     = (json['distanceKm']     as num?)?.toDouble();
    distanceMeters = (json['distanceMeters'] as num?)?.toInt();
    distance       = json['distance']?.toString();
  }

  String? hospitalId;
  String? name;
  String? fullName;
  String? contactNumber;
  String? email;
  String? address;
  Location? location;
  double? lat;
  double? lng;
  double? long;
  String? hospitalType;
  String? workingHours;
  List<String>? bloodTypes;
  bool? isAvailable;
  int? urgentNeedsCount;
  bool? appointmentSchedulingEnabled;
  bool? hospitalActive;
  bool? hospitalVerified;
  double? distanceKm;
  int? distanceMeters;
  String? distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hospitalId']                    = hospitalId;
    map['hospital_id']                   = hospitalId;
    map['name']                          = name;
    map['fullName']                      = fullName;
    map['contactNumber']                 = contactNumber;
    map['email']                         = email;
    map['address']                       = address;
    if (location != null) {
      map['location']                    = location?.toJson();
    }
    map['lat']                           = lat;
    map['lng']                           = lng;
    map['long']                          = long;
    map['hospitalType']                  = hospitalType;
    map['workingHours']                  = workingHours;
    map['bloodTypes']                    = bloodTypes;
    map['isAvailable']                   = isAvailable;
    map['urgentNeedsCount']              = urgentNeedsCount;
    map['appointmentSchedulingEnabled']  = appointmentSchedulingEnabled;
    map['hospitalActive']                = hospitalActive;
    map['hospitalVerified']              = hospitalVerified;
    map['distanceKm']                    = distanceKm;
    map['distanceMeters']                = distanceMeters;
    map['distance']                      = distance;
    return map;
  }
}

/// lat : 30.365123
/// lng : 30.523868

class Location {
  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(dynamic json) {
    lat = (json['lat'] as num?)?.toDouble();
    lng = (json['lng'] as num?)?.toDouble();
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