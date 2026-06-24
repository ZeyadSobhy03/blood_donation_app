/// success : true
/// message : "Appointments fetched"
/// data : {...}

class AppointmentModel {
  AppointmentModel({
    this.success,
    this.message,
    this.data,
  });

  AppointmentModel.fromJson(dynamic json) {
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

/// appointments : [...]
/// total : 1
/// meta : {...}

class Data {
  Data({
    this.appointments,
    this.total,
    this.meta,
  });

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

/// total : 1
/// page : 1
/// currentPage : 1
/// limit : 10
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Meta {
  Meta({
    this.total,
    this.page,
    this.currentPage,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Meta.fromJson(dynamic json) {
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

/// _id : "6a3b0d3fca8d9db9e754bde1"
/// appointmentId : "6a3b0d3fca8d9db9e754bde1"
/// appointmentDate : "2026-06-26"
/// appointmentTime : "1:00 PM"
/// status : "pending"
/// donationType : "Plasma"
/// ... and other fields

class Appointments {
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
    this.rescheduleHistory,
    this.verificationChecklist,
    this.createdAt,
    this.updatedAt,
    this.notes,
    this.donorId,
    this.v,
    this.cancelledAt,
    this.qrExpiresAt,
    this.qrScannedAt,
    this.qrToken,
    this.requestId,
  });

  Appointments.fromJson(dynamic json) {
    id = json['_id'];
    appointmentId = json['appointmentId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    status = json['status'];
    donationType = json['donationType'];
    hospitalId =
    json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    appointment =
    json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null;
    donor = json['donor'] != null ? Donor.fromJson(json['donor']) : null;
    if (json['rescheduleHistory'] != null) {
      rescheduleHistory = [];
      json['rescheduleHistory'].forEach((v) {
        rescheduleHistory?.add(v);
      });
    }
    verificationChecklist = json['verificationChecklist'] != null
        ? VerificationChecklist.fromJson(json['verificationChecklist'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    notes = json['notes'];
    donorId = json['donorId'];
    v = json['__v'];
    cancelledAt = json['cancelledAt'];
    qrExpiresAt = json['qrExpiresAt'];
    qrScannedAt = json['qrScannedAt'];
    qrToken = json['qrToken'];
    requestId = json['requestId'];
  }

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
  List<dynamic>? rescheduleHistory;
  VerificationChecklist? verificationChecklist;
  String? createdAt;
  String? updatedAt;
  String? notes;
  String? donorId;
  int? v;
  dynamic cancelledAt;
  String? qrExpiresAt;
  dynamic qrScannedAt;
  String? qrToken;
  dynamic requestId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['appointmentId'] = appointmentId;
    map['appointmentDate'] = appointmentDate;
    map['appointmentTime'] = appointmentTime;
    map['status'] = status;
    map['donationType'] = donationType;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    if (appointment != null) {
      map['appointment'] = appointment?.toJson();
    }
    if (donor != null) {
      map['donor'] = donor?.toJson();
    }
    if (rescheduleHistory != null) {
      map['rescheduleHistory'] = rescheduleHistory;
    }
    if (verificationChecklist != null) {
      map['verificationChecklist'] = verificationChecklist?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['notes'] = notes;
    map['donorId'] = donorId;
    map['__v'] = v;
    map['cancelledAt'] = cancelledAt;
    map['qrExpiresAt'] = qrExpiresAt;
    map['qrScannedAt'] = qrScannedAt;
    map['qrToken'] = qrToken;
    map['requestId'] = requestId;
    return map;
  }
}

/// idVerified : false
/// questionnaireCompleted : false
/// consentSigned : false
/// completedAt : null

class VerificationChecklist {
  VerificationChecklist({
    this.idVerified,
    this.questionnaireCompleted,
    this.consentSigned,
    this.completedAt,
  });

  VerificationChecklist.fromJson(dynamic json) {
    idVerified = json['idVerified'];
    questionnaireCompleted = json['questionnaireCompleted'];
    consentSigned = json['consentSigned'];
    completedAt = json['completedAt'];
  }

  bool? idVerified;
  bool? questionnaireCompleted;
  bool? consentSigned;
  dynamic completedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idVerified'] = idVerified;
    map['questionnaireCompleted'] = questionnaireCompleted;
    map['consentSigned'] = consentSigned;
    map['completedAt'] = completedAt;
    return map;
  }
}

/// donorId : "6a3b0a0fca8d9db9e754bddf"
/// firstName : null
/// lastName : null
/// fullName : null
/// email : null
/// phoneNumber : null
/// bloodType : null
/// gender : null
/// dateOfBirth : null

class Donor {
  Donor({
    this.donorId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.bloodType,
    this.gender,
    this.dateOfBirth,
  });

  Donor.fromJson(dynamic json) {
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

  String? donorId;
  dynamic firstName;
  dynamic lastName;
  dynamic fullName;
  dynamic email;
  dynamic phoneNumber;
  dynamic bloodType;
  dynamic gender;
  dynamic dateOfBirth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donorId'] = donorId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['gender'] = gender;
    map['dateOfBirth'] = dateOfBirth;
    return map;
  }
}

/// appointmentId : "6a3b0d3fca8d9db9e754bde1"
/// donationType : "Plasma"
/// appointmentDate : "2026-06-26T13:00:00.000Z"
/// appointmentTime : "1:00 PM"
/// status : "pending"
/// hospitalId : "6a3838cf044cabc1d7806b67"
/// hospitalName : "cairo hospital"

class Appointment {
  Appointment({
    this.appointmentId,
    this.donationType,
    this.appointmentDate,
    this.appointmentTime,
    this.status,
    this.hospitalId,
    this.hospitalName,
  });

  Appointment.fromJson(dynamic json) {
    appointmentId = json['appointmentId'];
    donationType = json['donationType'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    status = json['status'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
  }

  String? appointmentId;
  String? donationType;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? hospitalId;
  String? hospitalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointmentId'] = appointmentId;
    map['donationType'] = donationType;
    map['appointmentDate'] = appointmentDate;
    map['appointmentTime'] = appointmentTime;
    map['status'] = status;
    map['hospitalId'] = hospitalId;
    map['hospitalName'] = hospitalName;
    return map;
  }
}

/// hospitalId : "6a3838cf044cabc1d7806b67"
/// id : "6a3838cf044cabc1d7806b67"
/// name : "cairo hospital"
/// hospitalName : "cairo hospital"

class Hospital {
  Hospital({
    this.hospitalId,
    this.id,
    this.name,
    this.hospitalName,
  });

  Hospital.fromJson(dynamic json) {
    hospitalId = json['hospitalId'];
    id = json['id'];
    name = json['name'];
    hospitalName = json['hospitalName'];
  }

  String? hospitalId;
  String? id;
  String? name;
  String? hospitalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hospitalId'] = hospitalId;
    map['id'] = id;
    map['name'] = name;
    map['hospitalName'] = hospitalName;
    return map;
  }
}

/// _id : "6a3838cf044cabc1d7806b67"
/// fullName : "cairo hospital"
/// hospitalName : "cairo hospital"
/// address : "cairo"
/// location : null
/// contactNumber : "01141935344"

class HospitalId {
  HospitalId({
    this.id,
    this.fullName,
    this.hospitalName,
    this.address,
    this.location,
    this.contactNumber,
  });

  HospitalId.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    hospitalName = json['hospitalName'];
    address = json['address'];
    location = json['location'];
    contactNumber = json['contactNumber'];
  }

  String? id;
  String? fullName;
  String? hospitalName;
  String? address;
  dynamic location;
  String? contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['hospitalName'] = hospitalName;
    map['address'] = address;
    map['location'] = location;
    map['contactNumber'] = contactNumber;
    return map;
  }
}