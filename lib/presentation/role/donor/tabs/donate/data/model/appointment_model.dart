/// success : true
/// data : {"appointments":[{"_id":"69fe540565ff7785a031315b","notes":"[demo-seed] appointment-aya-urgent","donorId":"69f3df915f42685cbbbcbb18","__v":0,"appointmentDate":"2026-05-12T07:00:00.000Z","cancelledAt":null,"createdAt":"2026-05-08T21:22:14.466Z","donationType":"Whole Blood","hospitalId":{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"},"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"contactNumber":"1044444444"},"qrExpiresAt":"2026-05-13T07:00:00.000Z","qrScannedAt":null,"qrToken":"demo-qr-aya-critical","requestId":"69fe540565ff7785a031314f","status":"pending","updatedAt":"2026-05-08T21:33:29.691Z"},{"_id":"69fde7d0d6844d06c2b258d0","donorId":"69f3df915f42685cbbbcbb18","hospitalId":{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"},"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"contactNumber":"1044444444"},"notes":"[demo-seed] appointment-1","__v":0,"appointmentDate":"2026-05-11T13:40:33.910Z","cancelledAt":null,"createdAt":"2026-05-08T13:40:33.910Z","donationType":"Whole Blood","qrExpiresAt":null,"qrScannedAt":null,"qrToken":"f066c5ca98d9cca17e2e6ae955aa80c564b92ee4b69f7fe29e682096b61c9e0e","requestId":null,"status":"pending","updatedAt":"2026-05-08T13:40:33.910Z"}],"total":2,"meta":{"total":2,"page":0,"limit":10,"totalPages":1,"hasNextPage":true,"hasPrevPage":false}}

class AppointmentModel {
  AppointmentModel({
      this.success, 
      this.data,});

  AppointmentModel.fromJson(dynamic json) {
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

/// appointments : [{"_id":"69fe540565ff7785a031315b","notes":"[demo-seed] appointment-aya-urgent","donorId":"69f3df915f42685cbbbcbb18","__v":0,"appointmentDate":"2026-05-12T07:00:00.000Z","cancelledAt":null,"createdAt":"2026-05-08T21:22:14.466Z","donationType":"Whole Blood","hospitalId":{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"},"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"contactNumber":"1044444444"},"qrExpiresAt":"2026-05-13T07:00:00.000Z","qrScannedAt":null,"qrToken":"demo-qr-aya-critical","requestId":"69fe540565ff7785a031314f","status":"pending","updatedAt":"2026-05-08T21:33:29.691Z"},{"_id":"69fde7d0d6844d06c2b258d0","donorId":"69f3df915f42685cbbbcbb18","hospitalId":{"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"},"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"contactNumber":"1044444444"},"notes":"[demo-seed] appointment-1","__v":0,"appointmentDate":"2026-05-11T13:40:33.910Z","cancelledAt":null,"createdAt":"2026-05-08T13:40:33.910Z","donationType":"Whole Blood","qrExpiresAt":null,"qrScannedAt":null,"qrToken":"f066c5ca98d9cca17e2e6ae955aa80c564b92ee4b69f7fe29e682096b61c9e0e","requestId":null,"status":"pending","updatedAt":"2026-05-08T13:40:33.910Z"}]
/// total : 2
/// meta : {"total":2,"page":0,"limit":10,"totalPages":1,"hasNextPage":true,"hasPrevPage":false}

class Data {
  Data({
      this.appointments, 
      this.total, 
      this.meta,});

  Data.fromJson(dynamic json) {
    if (json['appointments'] != null) {
      appointments = [];
      json['appointments'].forEach((v) {
        appointments?.add(Appointments.fromJson(v));
      });
    }
    total = json['total'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Appointments>? appointments;
  int? total;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (appointments != null) {
      map['appointments'] = appointments?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

/// total : 2
/// page : 0
/// limit : 10
/// totalPages : 1
/// hasNextPage : true
/// hasPrevPage : false

class Meta {
  Meta({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.hasNextPage, 
      this.hasPrevPage,});

  Meta.fromJson(dynamic json) {
     total = json['total'] is int ? json['total'] : (json['total'] as num?)?.toInt();
     page = json['page'] is int ? json['page'] : (json['page'] as num?)?.toInt();
     limit = json['limit'] is int ? json['limit'] : (json['limit'] as num?)?.toInt();
     totalPages = json['totalPages'] is int ? json['totalPages'] : (json['totalPages'] as num?)?.toInt();
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

/// _id : "69fe540565ff7785a031315b"
/// notes : "[demo-seed] appointment-aya-urgent"
/// donorId : "69f3df915f42685cbbbcbb18"
/// __v : 0
/// appointmentDate : "2026-05-12T07:00:00.000Z"
/// cancelledAt : null
/// createdAt : "2026-05-08T21:22:14.466Z"
/// donationType : "Whole Blood"
/// hospitalId : {"location":{"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"},"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"contactNumber":"1044444444"}
/// qrExpiresAt : "2026-05-13T07:00:00.000Z"
/// qrScannedAt : null
/// qrToken : "demo-qr-aya-critical"
/// requestId : "69fe540565ff7785a031314f"
/// status : "pending"
/// updatedAt : "2026-05-08T21:33:29.691Z"

class Appointments {
  Appointments({
      this.id, 
      this.notes, 
      this.donorId, 
      this.v, 
      this.appointmentDate, 
      this.cancelledAt, 
      this.createdAt, 
      this.donationType, 
      this.hospitalId, 
      this.qrExpiresAt, 
      this.qrScannedAt, 
      this.qrToken, 
      this.requestId, 
      this.status, 
      this.updatedAt,});

  Appointments.fromJson(dynamic json) {
    id = json['_id'];
    notes = json['notes'];
    donorId = json['donorId'];
    v = json['__v'];
    appointmentDate = json['appointmentDate'];
    cancelledAt = json['cancelledAt'];
    createdAt = json['createdAt'];
    donationType = json['donationType'];
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    qrExpiresAt = json['qrExpiresAt'];
    qrScannedAt = json['qrScannedAt'];
    qrToken = json['qrToken'];
    requestId = json['requestId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? notes;
  String? donorId;
  int? v;
  String? appointmentDate;
  dynamic cancelledAt;
  String? createdAt;
  String? donationType;
  HospitalId? hospitalId;
  String? qrExpiresAt;
  dynamic qrScannedAt;
  String? qrToken;
  String? requestId;
  String? status;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['notes'] = notes;
    map['donorId'] = donorId;
    map['__v'] = v;
    map['appointmentDate'] = appointmentDate;
    map['cancelledAt'] = cancelledAt;
    map['createdAt'] = createdAt;
    map['donationType'] = donationType;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    map['qrExpiresAt'] = qrExpiresAt;
    map['qrScannedAt'] = qrScannedAt;
    map['qrToken'] = qrToken;
    map['requestId'] = requestId;
    map['status'] = status;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// location : {"coordinates":{"lat":30.0511,"lng":31.2435},"city":"Cairo","governorate":"Cairo","lastUpdated":"2026-05-08T21:33:23.752Z"}
/// _id : "69f3df915f42685cbbbcbb1b"
/// fullName : "Cairo Care Operations"
/// __t : "hospital"
/// hospitalName : "Cairo Care Hospital"
/// address : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}
/// contactNumber : "1044444444"

class HospitalId {
  HospitalId({
      this.location, 
      this.id, 
      this.fullName, 
      this.t, 
      this.hospitalName, 
      this.address, 
      this.contactNumber,});

  HospitalId.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    id = json['_id'];
    fullName = json['fullName'];
    t = json['__t'];
    hospitalName = json['hospitalName'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    contactNumber = json['contactNumber'];
  }
  Location? location;
  String? id;
  String? fullName;
  String? t;
  String? hospitalName;
  Address? address;
  String? contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['_id'] = id;
    map['fullName'] = fullName;
    map['__t'] = t;
    map['hospitalName'] = hospitalName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['contactNumber'] = contactNumber;
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

/// coordinates : {"lat":30.0511,"lng":31.2435}
/// city : "Cairo"
/// governorate : "Cairo"
/// lastUpdated : "2026-05-08T21:33:23.752Z"

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
     lat = json['lat'] != null ? (json['lat'] is double ? json['lat'] : (json['lat'] as num).toDouble()) : null;
     lng = json['lng'] != null ? (json['lng'] is double ? json['lng'] : (json['lng'] as num).toDouble()) : null;
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