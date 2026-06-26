class AppointmentModel {
  bool? success;
  String? message;
  Data? data;

  AppointmentModel({this.success, this.message, this.data});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class Data {
  List<Appointments>? appointments;
  int? total;
  Meta? meta;

  Data({this.appointments, this.total, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    appointments = (json['appointments'] as List?)
        ?.map((e) => Appointments.fromJson(e))
        .toList();

    total = json['total'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'appointments': appointments?.map((e) => e.toJson()).toList(),
      'total': total,
      'meta': meta?.toJson(),
    };
  }
}

class Appointments {
  String? id;
  String? appointmentId;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? donationType;

  HospitalId? hospitalId;
  Hospital? hospital;
  Appointment? appointment;
  Donor? donor;
  VerificationChecklist? verificationChecklist;

  List<dynamic>? rescheduleHistory;

  String? createdAt;
  String? updatedAt;
  String? notes;
  String? donorId;
  int? version;
  String? cancelledAt;
  String? qrExpiresAt;
  String? qrScannedAt;
  String? qrToken;
  String? requestId;

  Appointments({
    this.id,
    this.appointmentId,
    this.appointmentDate,
    this.appointmentTime,
    this.status,
    this.donationType,
    this.hospitalId,
    this.hospital,
    this.appointment,
    this.donor,
    this.verificationChecklist,
    this.rescheduleHistory,
    this.createdAt,
    this.updatedAt,
    this.notes,
    this.donorId,
    this.version,
    this.cancelledAt,
    this.qrExpiresAt,
    this.qrScannedAt,
    this.qrToken,
    this.requestId,
  });

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    appointmentId = json['appointmentId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    status = json['status'];
    donationType = json['donationType'];

    hospitalId = json['hospitalId'] != null
        ? HospitalId.fromJson(json['hospitalId'])
        : null;

    hospital = json['hospital'] != null
        ? Hospital.fromJson(json['hospital'])
        : null;

    appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;

    donor = json['donor'] != null ? Donor.fromJson(json['donor']) : null;

    verificationChecklist = json['verificationChecklist'] != null
        ? VerificationChecklist.fromJson(json['verificationChecklist'])
        : null;

    rescheduleHistory = json['rescheduleHistory'] ?? [];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    notes = json['notes'];
    donorId = json['donorId'];
    version = json['__v'];
    cancelledAt = json['cancelledAt'];
    qrExpiresAt = json['qrExpiresAt'];
    qrScannedAt = json['qrScannedAt'];
    qrToken = json['qrToken'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'appointmentId': appointmentId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'status': status,
      'donationType': donationType,
      'hospitalId': hospitalId?.toJson(),
      'hospital': hospital?.toJson(),
      'appointment': appointment?.toJson(),
      'donor': donor?.toJson(),
      'verificationChecklist': verificationChecklist?.toJson(),
      'rescheduleHistory': rescheduleHistory,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'notes': notes,
      'donorId': donorId,
      '__v': version,
      'cancelledAt': cancelledAt,
      'qrExpiresAt': qrExpiresAt,
      'qrScannedAt': qrScannedAt,
      'qrToken': qrToken,
      'requestId': requestId,
    };
  }
}

class HospitalId {
  String? id;
  String? fullName;
  String? hospitalName;
  dynamic address;
  Location? location;
  String? contactNumber;

  HospitalId({
    this.id,
    this.fullName,
    this.hospitalName,
    this.address,
    this.location,
    this.contactNumber,
  });

  HospitalId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    hospitalName = json['hospitalName'];
    address = json['address'];

    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;

    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'hospitalName': hospitalName,
      'address': address,
      'location': location?.toJson(),
      'contactNumber': contactNumber,
    };
  }
}

class Location {
  Coordinates? coordinates;
  String? city;
  String? governorate;
  String? lastUpdated;

  Location({this.coordinates, this.city, this.governorate, this.lastUpdated});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;

    city = json['city'];
    governorate = json['governorate'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates?.toJson(),
      'city': city,
      'governorate': governorate,
      'lastUpdated': lastUpdated,
    };
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num?)?.toDouble();
    lng = (json['lng'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}

class Hospital {
  String? hospitalId;
  String? id;
  String? name;
  String? hospitalName;

  Hospital({this.hospitalId, this.id, this.name, this.hospitalName});

  Hospital.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospitalId'];
    id = json['id'];
    name = json['name'];
    hospitalName = json['hospitalName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'hospitalId': hospitalId,
      'id': id,
      'name': name,
      'hospitalName': hospitalName,
    };
  }
}

class Appointment {
  String? appointmentId;
  String? donationType;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? hospitalId;
  String? hospitalName;

  Appointment.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    donationType = json['donationType'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    status = json['status'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
  }

  Map<String, dynamic> toJson() => {};
}

class Donor {
  String? donorId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? bloodType;
  String? gender;
  String? dateOfBirth;

  Donor.fromJson(Map<String, dynamic> json) {
    donorId = json['donorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() => {};
}

class VerificationChecklist {
  bool? idVerified;
  bool? questionnaireCompleted;
  bool? consentSigned;
  String? completedAt;

  VerificationChecklist.fromJson(Map<String, dynamic> json) {
    idVerified = json['idVerified'];
    questionnaireCompleted = json['questionnaireCompleted'];
    consentSigned = json['consentSigned'];
    completedAt = json['completedAt'];
  }

  Map<String, dynamic> toJson() => {};
}

class Meta {
  int? total;
  int? page;
  int? currentPage;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() => {};
}
