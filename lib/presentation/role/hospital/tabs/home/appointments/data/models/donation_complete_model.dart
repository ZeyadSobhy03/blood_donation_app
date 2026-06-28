class DonationCompleteModel {
  DonationCompleteModel({this.success, this.message, this.data});

  DonationCompleteModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? DonationCompleteData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  DonationCompleteData? data;
}

class DonationCompleteData {
  DonationCompleteData({this.donation, this.appointment, this.pointsEarned});

  DonationCompleteData.fromJson(dynamic json) {
    donation = json['donation'] != null
        ? DonationRecord.fromJson(json['donation'])
        : null;
    appointment = json['appointment'] != null
        ? DonationAppointmentInfo.fromJson(json['appointment'])
        : null;
    pointsEarned = (json['pointsEarned'] as num?)?.toInt();
  }

  DonationRecord? donation;
  DonationAppointmentInfo? appointment;
  int? pointsEarned;
}

class DonationRecord {
  DonationRecord({
    this.id,
    this.donorId,
    this.appointmentId,
    this.requestId,
    this.quantity,
    this.unitsCollected,
    this.hemoglobinLevel,
    this.weight,
    this.status,
    this.completedDate,
  });

  DonationRecord.fromJson(dynamic json) {
    id = json['_id'] ?? json['id'];
    donorId = json['donorId'];
    appointmentId = json['appointmentId'];
    requestId = json['requestId'];
    quantity = (json['quantity'] as num?)?.toInt();
    unitsCollected = (json['unitsCollected'] as num?)?.toInt();
    hemoglobinLevel = (json['hemoglobinLevel'] as num?)?.toDouble();
    weight = (json['weight'] as num?)?.toDouble();
    status = json['status'];
    completedDate = json['completedDate'];
  }

  String? id;
  String? donorId;
  String? appointmentId;
  String? requestId;
  int? quantity;
  int? unitsCollected;
  double? hemoglobinLevel;
  double? weight;
  String? status;
  String? completedDate;
}

class DonationAppointmentInfo {
  DonationAppointmentInfo({this.id, this.status, this.verificationStatus, this.donationType});

  DonationAppointmentInfo.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    verificationStatus = json['verificationStatus'];
    donationType = json['donationType'];
  }

  String? id;
  String? status;
  String? verificationStatus;
  String? donationType;
}
