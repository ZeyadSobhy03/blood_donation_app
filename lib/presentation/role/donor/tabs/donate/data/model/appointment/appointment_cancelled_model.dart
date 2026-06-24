/// success : true
/// message : "Appointment cancelled"
/// data : {"_id":"69fe540565ff7785a031315c","donorId":"69f3df915f42685cbbbcbb18","hospitalId":"69f3df915f42685cbbbcbb1b","requestId":"69fe540565ff7785a031314f","appointmentDate":"2026-05-12T10:00:00.000Z","status":"cancelled","cancelledAt":"2026-05-09T10:30:00.000Z","notes":"Test appointment","qrToken":"8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d","donationType":"Whole Blood"}

class AppointmentCancelledModel {
  AppointmentCancelledModel({
      this.success, 
      this.message, 
      this.data,});

  AppointmentCancelledModel.fromJson(dynamic json) {
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
/// donorId : "69f3df915f42685cbbbcbb18"
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// requestId : "69fe540565ff7785a031314f"
/// appointmentDate : "2026-05-12T10:00:00.000Z"
/// status : "cancelled"
/// cancelledAt : "2026-05-09T10:30:00.000Z"
/// notes : "Test appointment"
/// qrToken : "8f3a4f2f6a6d4f3a9e2c1b0a7d6c5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d"
/// donationType : "Whole Blood"

class Data {
  Data({
      this.id, 
      this.donorId, 
      this.hospitalId, 
      this.requestId, 
      this.appointmentDate, 
      this.status, 
      this.cancelledAt, 
      this.notes, 
      this.qrToken, 
      this.donationType,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    donorId = json['donorId'];
    hospitalId = json['hospitalId'];
    requestId = json['requestId'];
    appointmentDate = json['appointmentDate'];
    status = json['status'];
    cancelledAt = json['cancelledAt'];
    notes = json['notes'];
    qrToken = json['qrToken'];
    donationType = json['donationType'];
  }
  String? id;
  String? donorId;
  String? hospitalId;
  String? requestId;
  String? appointmentDate;
  String? status;
  String? cancelledAt;
  String? notes;
  String? qrToken;
  String? donationType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['donorId'] = donorId;
    map['hospitalId'] = hospitalId;
    map['requestId'] = requestId;
    map['appointmentDate'] = appointmentDate;
    map['status'] = status;
    map['cancelledAt'] = cancelledAt;
    map['notes'] = notes;
    map['qrToken'] = qrToken;
    map['donationType'] = donationType;
    return map;
  }

}