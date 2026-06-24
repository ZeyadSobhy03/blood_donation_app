/// success : true
/// message : "Appointment rescheduled"
/// data : {"_id":"69fe540565ff7785a031315c","appointmentId":"69fe540565ff7785a031315c","donorId":"69f3df915f42685cbbbcbb18","hospitalId":"69f3df915f42685cbbbcbb1b","requestId":"69fe540565ff7785a031314f","appointmentDate":"2026-05-15T14:00:00.000Z","appointmentTime":"02:00 PM","appointmentDay":"2026-05-15","status":"pending","notes":"Donation follow-up appointment","qrToken":"8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d","donationType":"Plasma","donor":{"donorId":"69f3df915f42685cbbbcbb18","firstName":"Aya","lastName":"Hassan","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","phoneNumber":"01011111111","bloodType":"O+","gender":"female","dateOfBirth":"1995-01-15T00:00:00.000Z"},"appointment":{"appointmentId":"69fe540565ff7785a031315c","donationType":"Plasma","appointmentDate":"2026-05-15T14:00:00.000Z","appointmentTime":"02:00 PM","status":"pending","hospitalId":"69f3df915f42685cbbbcbb1b","hospitalName":"Cairo Care Hospital"},"hospital":{"hospitalId":"69f3df915f42685cbbbcbb1b","id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","hospitalName":"Cairo Care Hospital"},"request":{"requestId":"69fe540565ff7785a031314f","id":"69fe540565ff7785a031314f","urgencyLevel":"high","unitsNeeded":2,"notes":"Donation follow-up appointment"},"rescheduleHistory":[{"previousAppointmentDate":"2026-05-12T10:00:00.000Z","newAppointmentDate":"2026-05-15T14:00:00.000Z","previousDonationType":"Whole Blood","newDonationType":"Plasma","reason":"Travel conflict","rescheduledAt":"2026-05-10T09:30:00.000Z"}],"createdAt":"2026-05-08T09:00:00.000Z","updatedAt":"2026-05-08T09:00:00.000Z"}

class RescheduledAppointmentModel {
  RescheduledAppointmentModel({
      this.success, 
      this.message, 
      this.data,});

  RescheduledAppointmentModel.fromJson(dynamic json) {
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

/// _id : "69fe540565ff7785a031315c"
/// appointmentId : "69fe540565ff7785a031315c"
/// donorId : "69f3df915f42685cbbbcbb18"
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// requestId : "69fe540565ff7785a031314f"
/// appointmentDate : "2026-05-15T14:00:00.000Z"
/// appointmentTime : "02:00 PM"
/// appointmentDay : "2026-05-15"
/// status : "pending"
/// notes : "Donation follow-up appointment"
/// qrToken : "8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d"
/// donationType : "Plasma"
/// donor : {"donorId":"69f3df915f42685cbbbcbb18","firstName":"Aya","lastName":"Hassan","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","phoneNumber":"01011111111","bloodType":"O+","gender":"female","dateOfBirth":"1995-01-15T00:00:00.000Z"}
/// appointment : {"appointmentId":"69fe540565ff7785a031315c","donationType":"Plasma","appointmentDate":"2026-05-15T14:00:00.000Z","appointmentTime":"02:00 PM","status":"pending","hospitalId":"69f3df915f42685cbbbcbb1b","hospitalName":"Cairo Care Hospital"}
/// hospital : {"hospitalId":"69f3df915f42685cbbbcbb1b","id":"69f3df915f42685cbbbcbb1b","name":"Cairo Care Hospital","hospitalName":"Cairo Care Hospital"}
/// request : {"requestId":"69fe540565ff7785a031314f","id":"69fe540565ff7785a031314f","urgencyLevel":"high","unitsNeeded":2,"notes":"Donation follow-up appointment"}
/// rescheduleHistory : [{"previousAppointmentDate":"2026-05-12T10:00:00.000Z","newAppointmentDate":"2026-05-15T14:00:00.000Z","previousDonationType":"Whole Blood","newDonationType":"Plasma","reason":"Travel conflict","rescheduledAt":"2026-05-10T09:30:00.000Z"}]
/// createdAt : "2026-05-08T09:00:00.000Z"
/// updatedAt : "2026-05-08T09:00:00.000Z"

class Data {
  Data({
      this.id, 
      this.appointmentId, 
      this.donorId, 
      this.hospitalId, 
      this.requestId, 
      this.appointmentDate, 
      this.appointmentTime, 
      this.appointmentDay, 
      this.status, 
      this.notes, 
      this.qrToken, 
      this.donationType, 
      this.donor, 
      this.appointment, 
      this.hospital, 
      this.request, 
      this.rescheduleHistory, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    appointmentId = json['appointmentId'];
    donorId = json['donorId'];
    hospitalId = json['hospitalId'];
    requestId = json['requestId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    appointmentDay = json['appointmentDay'];
    status = json['status'];
    notes = json['notes'];
    qrToken = json['qrToken'];
    donationType = json['donationType'];
    donor = json['donor'] != null ? Donor.fromJson(json['donor']) : null;
    appointment = json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null;
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    request = json['request'] != null ? Request.fromJson(json['request']) : null;
    if (json['rescheduleHistory'] != null) {
      rescheduleHistory = [];
      json['rescheduleHistory'].forEach((v) {
        rescheduleHistory?.add(RescheduleHistory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? appointmentId;
  String? donorId;
  String? hospitalId;
  String? requestId;
  String? appointmentDate;
  String? appointmentTime;
  String? appointmentDay;
  String? status;
  String? notes;
  String? qrToken;
  String? donationType;
  Donor? donor;
  Appointment? appointment;
  Hospital? hospital;
  Request? request;
  List<RescheduleHistory>? rescheduleHistory;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['appointmentId'] = appointmentId;
    map['donorId'] = donorId;
    map['hospitalId'] = hospitalId;
    map['requestId'] = requestId;
    map['appointmentDate'] = appointmentDate;
    map['appointmentTime'] = appointmentTime;
    map['appointmentDay'] = appointmentDay;
    map['status'] = status;
    map['notes'] = notes;
    map['qrToken'] = qrToken;
    map['donationType'] = donationType;
    if (donor != null) {
      map['donor'] = donor?.toJson();
    }
    if (appointment != null) {
      map['appointment'] = appointment?.toJson();
    }
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    if (request != null) {
      map['request'] = request?.toJson();
    }
    if (rescheduleHistory != null) {
      map['rescheduleHistory'] = rescheduleHistory?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// previousAppointmentDate : "2026-05-12T10:00:00.000Z"
/// newAppointmentDate : "2026-05-15T14:00:00.000Z"
/// previousDonationType : "Whole Blood"
/// newDonationType : "Plasma"
/// reason : "Travel conflict"
/// rescheduledAt : "2026-05-10T09:30:00.000Z"

class RescheduleHistory {
  RescheduleHistory({
      this.previousAppointmentDate, 
      this.newAppointmentDate, 
      this.previousDonationType, 
      this.newDonationType, 
      this.reason, 
      this.rescheduledAt,});

  RescheduleHistory.fromJson(dynamic json) {
    previousAppointmentDate = json['previousAppointmentDate'];
    newAppointmentDate = json['newAppointmentDate'];
    previousDonationType = json['previousDonationType'];
    newDonationType = json['newDonationType'];
    reason = json['reason'];
    rescheduledAt = json['rescheduledAt'];
  }
  String? previousAppointmentDate;
  String? newAppointmentDate;
  String? previousDonationType;
  String? newDonationType;
  String? reason;
  String? rescheduledAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['previousAppointmentDate'] = previousAppointmentDate;
    map['newAppointmentDate'] = newAppointmentDate;
    map['previousDonationType'] = previousDonationType;
    map['newDonationType'] = newDonationType;
    map['reason'] = reason;
    map['rescheduledAt'] = rescheduledAt;
    return map;
  }

}

/// requestId : "69fe540565ff7785a031314f"
/// id : "69fe540565ff7785a031314f"
/// urgencyLevel : "high"
/// unitsNeeded : 2
/// notes : "Donation follow-up appointment"

class Request {
  Request({
      this.requestId, 
      this.id, 
      this.urgencyLevel, 
      this.unitsNeeded, 
      this.notes,});

  Request.fromJson(dynamic json) {
    requestId = json['requestId'];
    id = json['id'];
    urgencyLevel = json['urgencyLevel'];
    unitsNeeded = json['unitsNeeded'];
    notes = json['notes'];
  }
  String? requestId;
  String? id;
  String? urgencyLevel;
  int? unitsNeeded;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['id'] = id;
    map['urgencyLevel'] = urgencyLevel;
    map['unitsNeeded'] = unitsNeeded;
    map['notes'] = notes;
    return map;
  }

}

/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// id : "69f3df915f42685cbbbcbb1b"
/// name : "Cairo Care Hospital"
/// hospitalName : "Cairo Care Hospital"

class Hospital {
  Hospital({
      this.hospitalId, 
      this.id, 
      this.name, 
      this.hospitalName,});

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

/// appointmentId : "69fe540565ff7785a031315c"
/// donationType : "Plasma"
/// appointmentDate : "2026-05-15T14:00:00.000Z"
/// appointmentTime : "02:00 PM"
/// status : "pending"
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// hospitalName : "Cairo Care Hospital"

class Appointment {
  Appointment({
      this.appointmentId, 
      this.donationType, 
      this.appointmentDate, 
      this.appointmentTime, 
      this.status, 
      this.hospitalId, 
      this.hospitalName,});

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

/// donorId : "69f3df915f42685cbbbcbb18"
/// firstName : "Aya"
/// lastName : "Hassan"
/// fullName : "Aya Hassan"
/// email : "aya.hassan@lifelink.demo"
/// phoneNumber : "01011111111"
/// bloodType : "O+"
/// gender : "female"
/// dateOfBirth : "1995-01-15T00:00:00.000Z"

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
      this.dateOfBirth,});

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
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? bloodType;
  String? gender;
  String? dateOfBirth;

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