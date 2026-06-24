/// success : true
/// message : "Appointment booked"
/// data : {"_id":"6a2eb1ece944d62227671db8","appointmentDate":"2026-07-01T11:00:00.000Z","status":"pending","qrToken":"94f4770ab4a645bbb924c5a7687c500d9493ba7e3008a2a9a1c68a9b0d84ae28","qrExpiresAt":"2026-07-02T11:00:00.000Z","notes":"Available in the morning.","donationType":"Whole Blood","requestId":null,"donorId":{"_id":"6a135cce9b8ee66bb0201e27","fullName":"ziyad","phoneNumber":"01141935341","bloodType":"A-","email":"ziad60189@gmail.com"},"donorDetails":{"fullName":"ziyad","phoneNumber":"01141935341","bloodType":"A-","email":"ziad60189@gmail.com"},"hospitalId":{"_id":"6a130e820b339a45a51addb4","hospitalName":"Cairo Care Hospital","fullName":"Cairo Care Operations"}}

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

/// _id : "6a2eb1ece944d62227671db8"
/// appointmentDate : "2026-07-01T11:00:00.000Z"
/// status : "pending"
/// qrToken : "94f4770ab4a645bbb924c5a7687c500d9493ba7e3008a2a9a1c68a9b0d84ae28"
/// qrExpiresAt : "2026-07-02T11:00:00.000Z"
/// notes : "Available in the morning."
/// donationType : "Whole Blood"
/// requestId : null
/// donorId : {"_id":"6a135cce9b8ee66bb0201e27","fullName":"ziyad","phoneNumber":"01141935341","bloodType":"A-","email":"ziad60189@gmail.com"}
/// donorDetails : {"fullName":"ziyad","phoneNumber":"01141935341","bloodType":"A-","email":"ziad60189@gmail.com"}
/// hospitalId : {"_id":"6a130e820b339a45a51addb4","hospitalName":"Cairo Care Hospital","fullName":"Cairo Care Operations"}

class Data {
  Data({
      this.id, 
      this.appointmentDate, 
      this.status, 
      this.qrToken, 
      this.qrExpiresAt, 
      this.notes, 
      this.donationType, 
      this.requestId, 
      this.donorId, 
      this.donorDetails, 
      this.hospitalId,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    appointmentDate = json['appointmentDate'];
    status = json['status'];
    qrToken = json['qrToken'];
    qrExpiresAt = json['qrExpiresAt'];
    notes = json['notes'];
    donationType = json['donationType'];
    requestId = json['requestId'];
    donorId = json['donorId'] != null ? DonorId.fromJson(json['donorId']) : null;
    donorDetails = json['donorDetails'] != null ? DonorDetails.fromJson(json['donorDetails']) : null;
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
  }
  String? id;
  String? appointmentDate;
  String? status;
  String? qrToken;
  String? qrExpiresAt;
  String? notes;
  String? donationType;
  dynamic requestId;
  DonorId? donorId;
  DonorDetails? donorDetails;
  HospitalId? hospitalId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['appointmentDate'] = appointmentDate;
    map['status'] = status;
    map['qrToken'] = qrToken;
    map['qrExpiresAt'] = qrExpiresAt;
    map['notes'] = notes;
    map['donationType'] = donationType;
    map['requestId'] = requestId;
    if (donorId != null) {
      map['donorId'] = donorId?.toJson();
    }
    if (donorDetails != null) {
      map['donorDetails'] = donorDetails?.toJson();
    }
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    return map;
  }

}

/// _id : "6a130e820b339a45a51addb4"
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

/// fullName : "ziyad"
/// phoneNumber : "01141935341"
/// bloodType : "A-"
/// email : "ziad60189@gmail.com"

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

/// _id : "6a135cce9b8ee66bb0201e27"
/// fullName : "ziyad"
/// phoneNumber : "01141935341"
/// bloodType : "A-"
/// email : "ziad60189@gmail.com"

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