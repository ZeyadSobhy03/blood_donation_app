class VerifyAppointmentQrModel {
  VerifyAppointmentQrModel({this.success, this.message, this.data});

  VerifyAppointmentQrModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? VerifyAppointmentQrData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  VerifyAppointmentQrData? data;
}

class VerifyAppointmentQrData {
  VerifyAppointmentQrData({
    this.verificationStatus,
    this.verificationSessionId,
    this.appointment,
    this.donor,
    this.eligibility,
  });

  VerifyAppointmentQrData.fromJson(dynamic json) {
    verificationStatus = json['verificationStatus'];
    verificationSessionId = json['verificationSessionId'];
    appointment = json['appointment'] != null
        ? QrAppointmentData.fromJson(json['appointment'])
        : null;
    donor = json['donor'] != null ? QrDonorData.fromJson(json['donor']) : null;
    eligibility = json['eligibility'] != null
        ? QrEligibilityData.fromJson(json['eligibility'])
        : null;
  }

  String? verificationStatus;
  String? verificationSessionId;
  QrAppointmentData? appointment;
  QrDonorData? donor;
  QrEligibilityData? eligibility;
}

class QrAppointmentData {
  QrAppointmentData({
    this.id,
    this.appointmentDate,
    this.status,
    this.donationType,
    this.qrToken,
    this.qrScannedAt,
    this.qrExpiresAt,
    this.requestId,
    this.hospital,
  });

  QrAppointmentData.fromJson(dynamic json) {
    id = json['id'];
    appointmentDate = json['appointmentDate'];
    status = json['status'];
    donationType = json['donationType'];
    qrToken = json['qrToken'];
    qrScannedAt = json['qrScannedAt'];
    qrExpiresAt = json['qrExpiresAt'];
    requestId = json['requestId'];
    hospital = json['hospital'] != null
        ? QrHospitalData.fromJson(json['hospital'])
        : null;
  }

  String? id;
  String? appointmentDate;
  String? status;
  String? donationType;
  String? qrToken;
  String? qrScannedAt;
  String? qrExpiresAt;
  String? requestId;
  QrHospitalData? hospital;
}

class QrHospitalData {
  QrHospitalData({this.id, this.fullName, this.hospitalName, this.contactNumber});

  QrHospitalData.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    hospitalName = json['hospitalName'];
    contactNumber = json['contactNumber'];
  }

  String? id;
  String? fullName;
  String? hospitalName;
  String? contactNumber;
}

class QrDonorData {
  QrDonorData({
    this.id,
    this.fullName,
    this.initials,
    this.bloodType,
    this.phoneNumber,
    this.email,
    this.location,
    this.lastDonationDate,
    this.hemoglobinLevel,
    this.weight,
    this.participation,
  });

  QrDonorData.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    initials = json['initials'];
    bloodType = json['bloodType'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    if (json['location'] is Map) {
      location = QrLocationData.fromJson(json['location']);
    }
    lastDonationDate = json['lastDonationDate'];
    hemoglobinLevel = (json['hemoglobinLevel'] as num?)?.toDouble();
    weight = (json['weight'] as num?)?.toDouble();
    participation = json['participation'];
  }

  String? id;
  String? fullName;
  String? initials;
  String? bloodType;
  String? phoneNumber;
  String? email;
  QrLocationData? location;
  String? lastDonationDate;
  double? hemoglobinLevel;
  double? weight;
  bool? participation;
}

class QrLocationData {
  QrLocationData({this.lat, this.lng});

  QrLocationData.fromJson(dynamic json) {
    lat = (json['lat'] as num?)?.toDouble();
    lng = (json['lng'] as num?)?.toDouble();
  }

  double? lat;
  double? lng;
}

class QrEligibilityData {
  QrEligibilityData({this.eligible, this.reason, this.nextEligibleDate});

  QrEligibilityData.fromJson(dynamic json) {
    eligible = json['eligible'];
    reason = json['reason'];
    nextEligibleDate = json['nextEligibleDate'];
  }

  bool? eligible;
  String? reason;
  String? nextEligibleDate;
}
