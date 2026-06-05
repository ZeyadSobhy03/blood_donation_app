/// success : true
/// message : "Appointment booked"
/// data : {"_id":"69fe540565ff7785a031315c","donorId":{"_id":"69f3df915f42685cbbbcbb18","fullName":"Noor Ahmed","phoneNumber":"01123456789","bloodType":"O+","email":"noor.ahmed@example.com"},"donorDetails":{"fullName":"Noor Ahmed","phoneNumber":"01123456789","bloodType":"O+","email":"noor.ahmed@example.com"},"hospitalId":{"_id":"69f3df915f42685cbbbcbb1b","hospitalName":"Cairo Care Hospital","fullName":"Cairo Care Operations"},"requestId":null,"appointmentDate":"2026-05-12T10:00:00.000Z","status":"pending","qrToken":"8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d","qrExpiresAt":"2026-05-13T10:00:00.000Z","notes":"First-time donor, available in the morning.","donationType":"Whole Blood"}

class BookAppointmentModel {
  BookAppointmentModel({
      this.success, 
      this.message, 
      this.data,});

  BookAppointmentModel.fromJson(dynamic json) {
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
/// donorId : {"_id":"69f3df915f42685cbbbcbb18","fullName":"Noor Ahmed","phoneNumber":"01123456789","bloodType":"O+","email":"noor.ahmed@example.com"}
/// donorDetails : {"fullName":"Noor Ahmed","phoneNumber":"01123456789","bloodType":"O+","email":"noor.ahmed@example.com"}
/// hospitalId : {"_id":"69f3df915f42685cbbbcbb1b","hospitalName":"Cairo Care Hospital","fullName":"Cairo Care Operations"}
/// requestId : null
/// appointmentDate : "2026-05-12T10:00:00.000Z"
/// status : "pending"
/// qrToken : "8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d"
/// qrExpiresAt : "2026-05-13T10:00:00.000Z"
/// notes : "First-time donor, available in the morning."
/// donationType : "Whole Blood"

class Data {
  Data({
      this.id, 
      this.donorId, 
      this.donorDetails, 
      this.hospitalId, 
      this.requestId, 
      this.appointmentDate, 
      this.status, 
      this.qrToken, 
      this.qrExpiresAt, 
      this.notes, 
      this.donationType,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    donorId = json['donorId'] != null ? DonorId.fromJson(json['donorId']) : null;
    donorDetails = json['donorDetails'] != null ? DonorDetails.fromJson(json['donorDetails']) : null;
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    requestId = json['requestId'];
    appointmentDate = json['appointmentDate'];
    status = json['status'];
    qrToken = json['qrToken'];
    qrExpiresAt = json['qrExpiresAt'];
    notes = json['notes'];
    donationType = json['donationType'];
  }
  String? id;
  DonorId? donorId;
  DonorDetails? donorDetails;
  HospitalId? hospitalId;
  dynamic requestId;
  String? appointmentDate;
  String? status;
  String? qrToken;
  String? qrExpiresAt;
  String? notes;
  String? donationType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (donorId != null) {
      map['donorId'] = donorId?.toJson();
    }
    if (donorDetails != null) {
      map['donorDetails'] = donorDetails?.toJson();
    }
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    map['requestId'] = requestId;
    map['appointmentDate'] = appointmentDate;
    map['status'] = status;
    map['qrToken'] = qrToken;
    map['qrExpiresAt'] = qrExpiresAt;
    map['notes'] = notes;
    map['donationType'] = donationType;
    return map;
  }

}

/// _id : "69f3df915f42685cbbbcbb1b"
/// hospitalName : "Cairo Care Hospital"
/// fullName : "Cairo Care Operations"

class HospitalId {
  HospitalId({
      this.id, 
      this.hospitalName, 
      this.fullName,});

  HospitalId.fromJson(dynamic json) {
    id = json['_id'];
    hospitalName = json['hospitalName'];
    fullName = json['fullName'];
  }
  String? id;
  String? hospitalName;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hospitalName'] = hospitalName;
    map['fullName'] = fullName;
    return map;
  }

}

/// fullName : "Noor Ahmed"
/// phoneNumber : "01123456789"
/// bloodType : "O+"
/// email : "noor.ahmed@example.com"

class DonorDetails {
  DonorDetails({
      this.fullName, 
      this.phoneNumber, 
      this.bloodType, 
      this.email,});

  DonorDetails.fromJson(dynamic json) {
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    email = json['email'];
  }
  String? fullName;
  String? phoneNumber;
  String? bloodType;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['email'] = email;
    return map;
  }

}

/// _id : "69f3df915f42685cbbbcbb18"
/// fullName : "Noor Ahmed"
/// phoneNumber : "01123456789"
/// bloodType : "O+"
/// email : "noor.ahmed@example.com"

class DonorId {
  DonorId({
      this.id, 
      this.fullName, 
      this.phoneNumber, 
      this.bloodType, 
      this.email,});

  DonorId.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    email = json['email'];
  }
  String? id;
  String? fullName;
  String? phoneNumber;
  String? bloodType;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['bloodType'] = bloodType;
    map['email'] = email;
    return map;
  }

}