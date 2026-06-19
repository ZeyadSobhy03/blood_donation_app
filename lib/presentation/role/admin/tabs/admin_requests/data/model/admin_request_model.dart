
class AdminRequestModel {
  AdminRequestModel({
      this.success, 
      this.message, 
      this.data,});

  AdminRequestModel.fromJson(dynamic json) {
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
      this.requests, 
      this.total, 
      this.page, 
      this.limit, 
      this.stats,});

  Data.fromJson(dynamic json) {
    if (json['requests'] != null) {
      requests = [];
      json['requests'].forEach((v) {
        requests?.add(Requests.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }
  List<Requests>? requests;
  int? total;
  int? page;
  int? limit;
  Stats? stats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requests != null) {
      map['requests'] = requests?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    return map;
  }

}

class Stats {
  Stats({
      this.total, 
      this.byStatus, 
      this.byUrgency, 
      this.byBloodType,});

  Stats.fromJson(dynamic json) {
    total = json['total'];
    byStatus = json['byStatus'] != null ? ByStatus.fromJson(json['byStatus']) : null;
    byUrgency = json['byUrgency'] != null ? ByUrgency.fromJson(json['byUrgency']) : null;
    byBloodType = json['byBloodType'] != null ? ByBloodType.fromJson(json['byBloodType']) : null;
  }
  int? total;
  ByStatus? byStatus;
  ByUrgency? byUrgency;
  ByBloodType? byBloodType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (byStatus != null) {
      map['byStatus'] = byStatus?.toJson();
    }
    if (byUrgency != null) {
      map['byUrgency'] = byUrgency?.toJson();
    }
    if (byBloodType != null) {
      map['byBloodType'] = byBloodType?.toJson();
    }
    return map;
  }

}


class ByBloodType {
  ByBloodType({
      this.ab, 
      this.a, 
      this.o, 

      this.b, 
     });

  ByBloodType.fromJson(dynamic json) {
    ab = json['AB+'];
    a = json['A-'];
    o = json['O+'];
    o = json['O-'];
    b = json['B+'];
    a = json['A+'];
  }
  int? ab;
  int? a;
  int? o;
  int? b;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AB+'] = ab;
    map['A-'] = a;
    map['O+'] = o;
    map['O-'] = o;
    map['B+'] = b;
    map['A+'] = a;
    return map;
  }

}

/// low : 2
/// high : 2
/// medium : 2
/// critical : 4

class ByUrgency {
  ByUrgency({
      this.low, 
      this.high, 
      this.medium, 
      this.critical,});

  ByUrgency.fromJson(dynamic json) {
    low = json['low'];
    high = json['high'];
    medium = json['medium'];
    critical = json['critical'];
  }
  int? low;
  int? high;
  int? medium;
  int? critical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['low'] = low;
    map['high'] = high;
    map['medium'] = medium;
    map['critical'] = critical;
    return map;
  }

}


class ByStatus {
  ByStatus({
      this.accepted, 
      this.cancelled, 
      this.pending, 
      this.completed,});

  ByStatus.fromJson(dynamic json) {
    accepted = json['accepted'];
    cancelled = json['cancelled'];
    pending = json['pending'];
    completed = json['completed'];
  }
  int? accepted;
  int? cancelled;
  int? pending;
  int? completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accepted'] = accepted;
    map['cancelled'] = cancelled;
    map['pending'] = pending;
    map['completed'] = completed;
    return map;
  }

}

/// locationHospital : {"latitude":30.0511,"longitude":31.2435}
/// hospitalLocationGeo : {"type":"Point","coordinates":[31.2435,30.0511]}
/// hospitalLocation : {"lat":30.0511,"lng":31.2435}
/// patientType : "general"
/// _id : "6a2ebf149be69755f14bce16"
/// notes : "[demo-seed] cairo-available-medium-o-positive"
/// hospitalId : {"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-14T17:27:02.232Z"},"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","email":"ops@cairocare.demo","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","hospitalName":"Cairo Care Hospital","contactNumber":"1044444444"}
/// __v : 0
/// acceptanceDeadline : null
/// acceptedAt : null
/// acceptedBy : null
/// acceptedByBloodType : null
/// acceptedByName : null
/// acceptedByPhoneNumber : null
/// acceptedDonationId : null
/// arrivalDeadline : null
/// bloodType : ["O+","O-","B+"]
/// cancelledAt : null
/// cause : "Active medium-priority request for nearby list demos"
/// completedAt : null
/// createdAt : "2026-06-14T14:47:48.908Z"
/// escalationLevel : 3
/// hospitalContact : "1044444444"
/// hospitalName : "Cairo Care Hospital"
/// isEmergency : false
/// lastBroadcastAt : "2026-06-14T22:52:04.975Z"
/// manualInterventionFlag : false
/// qrCreatedAt : null
/// qrExpiresAt : null
/// quantity : 1
/// requiredBy : "2026-06-21T07:00:00.000Z"
/// status : "pending"
/// type : "blood"
/// unitsNeeded : 1
/// updatedAt : "2026-06-14T22:52:07.539Z"
/// urgency : "medium"
/// bloodTypes : ["O+","O-","B+"]
/// isFulfilled : false
/// location : "Cairo, Cairo"
/// urgencyLevel : "medium"
/// unitsRequested : 1
/// completionTimeInHours : 152
/// id : "6a2ebf149be69755f14bce16"
/// requestId : "6a2ebf149be69755f14bce16"
/// bloodTypeLabel : "O+, O-, B+"
/// contactNumber : "1044444444"
/// requestStatus : "pending"
/// qrToken : null
/// hospital : {"id":"6a130e820b339a45a51addb4","name":"Cairo Care Hospital","contactNumber":"1044444444","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"latitude":30.0511,"longitude":31.2435}
/// distanceKm : null
/// distanceMeters : null
/// distance : null
/// estimatedTime : null
/// donationCount : 0
/// donorsConfirmed : 0
/// donorsContacted : 10
/// timeline : [{"event":"REQUEST_CREATED","timestamp":"2026-06-14T14:47:48.908Z","actorType":"system","actorId":null,"metadata":{"status":"pending","urgency":"medium"}}]

class Requests {
  Requests({
      this.locationHospital, 
      this.hospitalLocationGeo, 
      this.hospitalLocation, 
      this.patientType, 
      this.id, 
      this.notes, 
      this.hospitalId, 
      this.v, 
      this.acceptanceDeadline, 
      this.acceptedAt, 
      this.acceptedBy, 
      this.acceptedByBloodType, 
      this.acceptedByName, 
      this.acceptedByPhoneNumber, 
      this.acceptedDonationId, 
      this.arrivalDeadline, 
      this.bloodType, 
      this.cancelledAt, 
      this.cause, 
      this.completedAt, 
      this.createdAt, 
      this.escalationLevel, 
      this.hospitalContact, 
      this.hospitalName, 
      this.isEmergency, 
      this.lastBroadcastAt, 
      this.manualInterventionFlag, 
      this.qrCreatedAt, 
      this.qrExpiresAt, 
      this.quantity, 
      this.requiredBy, 
      this.status, 
      this.type, 
      this.unitsNeeded, 
      this.updatedAt, 
      this.urgency, 
      this.bloodTypes, 
      this.isFulfilled, 
      this.location, 
      this.urgencyLevel, 
      this.unitsRequested, 
      this.completionTimeInHours, 
      this.requestId,
      this.bloodTypeLabel, 
      this.contactNumber, 
      this.requestStatus, 
      this.qrToken, 
      this.hospital, 
      this.distanceKm, 
      this.distanceMeters, 
      this.distance, 
      this.estimatedTime, 
      this.donationCount, 
      this.donorsConfirmed, 
      this.donorsContacted, 
      this.timeline,});

  Requests.fromJson(dynamic json) {
    locationHospital = json['locationHospital'] != null ? LocationHospital.fromJson(json['locationHospital']) : null;
    hospitalLocationGeo = json['hospitalLocationGeo'] != null ? HospitalLocationGeo.fromJson(json['hospitalLocationGeo']) : null;
    hospitalLocation = json['hospitalLocation'] != null ? HospitalLocation.fromJson(json['hospitalLocation']) : null;
    patientType = json['patientType'];
    id = json['_id'];
    notes = json['notes'];
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    v = json['__v'];
    acceptanceDeadline = json['acceptanceDeadline'];
    acceptedAt = json['acceptedAt'];
    acceptedBy = json['acceptedBy'];
    acceptedByBloodType = json['acceptedByBloodType'];
    acceptedByName = json['acceptedByName'];
    acceptedByPhoneNumber = json['acceptedByPhoneNumber'];
    acceptedDonationId = json['acceptedDonationId'];
    arrivalDeadline = json['arrivalDeadline'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    cancelledAt = json['cancelledAt'];
    cause = json['cause'];
    completedAt = json['completedAt'];
    createdAt = json['createdAt'];
    escalationLevel = json['escalationLevel'];
    hospitalContact = json['hospitalContact'];
    hospitalName = json['hospitalName'];
    isEmergency = json['isEmergency'];
    lastBroadcastAt = json['lastBroadcastAt'];
    manualInterventionFlag = json['manualInterventionFlag'];
    qrCreatedAt = json['qrCreatedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    quantity = json['quantity'];
    requiredBy = json['requiredBy'];
    status = json['status'];
    type = json['type'];
    unitsNeeded = json['unitsNeeded'];
    updatedAt = json['updatedAt'];
    urgency = json['urgency'];
    bloodTypes = json['bloodTypes'] != null ? json['bloodTypes'].cast<String>() : [];
    isFulfilled = json['isFulfilled'];
    location = json['location'];
    urgencyLevel = json['urgencyLevel'];
    unitsRequested = json['unitsRequested'];
    completionTimeInHours = json['completionTimeInHours'];
    id = json['id'];
    requestId = json['requestId'];
    bloodTypeLabel = json['bloodTypeLabel'];
    contactNumber = json['contactNumber'];
    requestStatus = json['requestStatus'];
    qrToken = json['qrToken'];
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    distanceKm = json['distanceKm'];
    distanceMeters = json['distanceMeters'];
    distance = json['distance'];
    estimatedTime = json['estimatedTime'];
    donationCount = json['donationCount'];
    donorsConfirmed = json['donorsConfirmed'];
    donorsContacted = json['donorsContacted'];
    if (json['timeline'] != null) {
      timeline = [];
      json['timeline'].forEach((v) {
        timeline?.add(Timeline.fromJson(v));
      });
    }
  }
  LocationHospital? locationHospital;
  HospitalLocationGeo? hospitalLocationGeo;
  HospitalLocation? hospitalLocation;
  String? patientType;
  String? id;
  String? notes;
  HospitalId? hospitalId;
  int? v;
  dynamic acceptanceDeadline;
  dynamic acceptedAt;
  dynamic acceptedBy;
  dynamic acceptedByBloodType;
  dynamic acceptedByName;
  dynamic acceptedByPhoneNumber;
  dynamic acceptedDonationId;
  dynamic arrivalDeadline;
  List<String>? bloodType;
  dynamic cancelledAt;
  String? cause;
  dynamic completedAt;
  String? createdAt;
  int? escalationLevel;
  String? hospitalContact;
  String? hospitalName;
  bool? isEmergency;
  String? lastBroadcastAt;
  bool? manualInterventionFlag;
  dynamic qrCreatedAt;
  dynamic qrExpiresAt;
  int? quantity;
  String? requiredBy;
  String? status;
  String? type;
  int? unitsNeeded;
  String? updatedAt;
  String? urgency;
  List<String>? bloodTypes;
  bool? isFulfilled;
  String? location;
  String? urgencyLevel;
  int? unitsRequested;
  int? completionTimeInHours;
  String? requestId;
  String? bloodTypeLabel;
  String? contactNumber;
  String? requestStatus;
  dynamic qrToken;
  Hospital? hospital;
  dynamic distanceKm;
  dynamic distanceMeters;
  dynamic distance;
  dynamic estimatedTime;
  int? donationCount;
  int? donorsConfirmed;
  int? donorsContacted;
  List<Timeline>? timeline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (locationHospital != null) {
      map['locationHospital'] = locationHospital?.toJson();
    }
    if (hospitalLocationGeo != null) {
      map['hospitalLocationGeo'] = hospitalLocationGeo?.toJson();
    }
    if (hospitalLocation != null) {
      map['hospitalLocation'] = hospitalLocation?.toJson();
    }
    map['patientType'] = patientType;
    map['_id'] = id;
    map['notes'] = notes;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    map['__v'] = v;
    map['acceptanceDeadline'] = acceptanceDeadline;
    map['acceptedAt'] = acceptedAt;
    map['acceptedBy'] = acceptedBy;
    map['acceptedByBloodType'] = acceptedByBloodType;
    map['acceptedByName'] = acceptedByName;
    map['acceptedByPhoneNumber'] = acceptedByPhoneNumber;
    map['acceptedDonationId'] = acceptedDonationId;
    map['arrivalDeadline'] = arrivalDeadline;
    map['bloodType'] = bloodType;
    map['cancelledAt'] = cancelledAt;
    map['cause'] = cause;
    map['completedAt'] = completedAt;
    map['createdAt'] = createdAt;
    map['escalationLevel'] = escalationLevel;
    map['hospitalContact'] = hospitalContact;
    map['hospitalName'] = hospitalName;
    map['isEmergency'] = isEmergency;
    map['lastBroadcastAt'] = lastBroadcastAt;
    map['manualInterventionFlag'] = manualInterventionFlag;
    map['qrCreatedAt'] = qrCreatedAt;
    map['qrExpiresAt'] = qrExpiresAt;
    map['quantity'] = quantity;
    map['requiredBy'] = requiredBy;
    map['status'] = status;
    map['type'] = type;
    map['unitsNeeded'] = unitsNeeded;
    map['updatedAt'] = updatedAt;
    map['urgency'] = urgency;
    map['bloodTypes'] = bloodTypes;
    map['isFulfilled'] = isFulfilled;
    map['location'] = location;
    map['urgencyLevel'] = urgencyLevel;
    map['unitsRequested'] = unitsRequested;
    map['completionTimeInHours'] = completionTimeInHours;
    map['id'] = id;
    map['requestId'] = requestId;
    map['bloodTypeLabel'] = bloodTypeLabel;
    map['contactNumber'] = contactNumber;
    map['requestStatus'] = requestStatus;
    map['qrToken'] = qrToken;
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    map['distanceKm'] = distanceKm;
    map['distanceMeters'] = distanceMeters;
    map['distance'] = distance;
    map['estimatedTime'] = estimatedTime;
    map['donationCount'] = donationCount;
    map['donorsConfirmed'] = donorsConfirmed;
    map['donorsContacted'] = donorsContacted;
    if (timeline != null) {
      map['timeline'] = timeline?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// event : "REQUEST_CREATED"
/// timestamp : "2026-06-14T14:47:48.908Z"
/// actorType : "system"
/// actorId : null
/// metadata : {"status":"pending","urgency":"medium"}

class Timeline {
  Timeline({
      this.event, 
      this.timestamp, 
      this.actorType, 
      this.actorId, 
      this.metadata,});

  Timeline.fromJson(dynamic json) {
    event = json['event'];
    timestamp = json['timestamp'];
    actorType = json['actorType'];
    actorId = json['actorId'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  String? event;
  String? timestamp;
  String? actorType;
  dynamic actorId;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event'] = event;
    map['timestamp'] = timestamp;
    map['actorType'] = actorType;
    map['actorId'] = actorId;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }

}

/// status : "pending"
/// urgency : "medium"

class Metadata {
  Metadata({
      this.status, 
      this.urgency,});

  Metadata.fromJson(dynamic json) {
    status = json['status'];
    urgency = json['urgency'];
  }
  String? status;
  String? urgency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['urgency'] = urgency;
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

/// location : {"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-06-14T17:27:02.232Z"}
/// _id : "6a130e820b339a45a51addb4"
/// fullName : "Cairo Care Operations"
/// email : "ops@cairocare.demo"
/// address : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
/// __t : "hospital"
/// hospitalName : "Cairo Care Hospital"
/// contactNumber : "1044444444"

class HospitalId {
  HospitalId({
      this.location, 
      this.id, 
      this.fullName, 
      this.email, 
      this.address, 
      this.t, 
      this.hospitalName, 
      this.contactNumber,});

  HospitalId.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    t = json['__t'];
    hospitalName = json['hospitalName'];
    contactNumber = json['contactNumber'];
  }
  Location? location;
  String? id;
  String? fullName;
  String? email;
  Address? address;
  String? t;
  String? hospitalName;
  String? contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['__t'] = t;
    map['hospitalName'] = hospitalName;
    map['contactNumber'] = contactNumber;
    return map;
  }

}

/// city : "Cairo"
/// governorate : "Cairo"
/// district : "Garden City"


/// coordinates : {"lat":30.0511,"lng":31.2435}
/// city : "Cairo"
/// governorate : "Cairo"
/// lastUpdated : "2026-06-14T17:27:02.232Z"

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

/// lat : 30.0511
/// lng : 31.2435

class HospitalLocation {
  HospitalLocation({
      this.lat, 
      this.lng,});

  HospitalLocation.fromJson(dynamic json) {
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

/// type : "Point"
/// coordinates : [31.2435,30.0511]

class HospitalLocationGeo {
  HospitalLocationGeo({
      this.type, 
      this.coordinates,});

  HospitalLocationGeo.fromJson(dynamic json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
  }
  String? type;
  List<double>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['coordinates'] = coordinates;
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