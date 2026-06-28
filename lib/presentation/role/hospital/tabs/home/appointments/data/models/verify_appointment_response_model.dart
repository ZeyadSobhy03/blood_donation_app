class VerifyAppointmentResponseModel {
  VerifyAppointmentResponseModel({this.success, this.message, this.data});

  VerifyAppointmentResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? VerifyAppointmentResponseData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  VerifyAppointmentResponseData? data;
}

class VerifyAppointmentResponseData {
  VerifyAppointmentResponseData({
    this.verificationStatus,
    this.appointmentId,
    this.appointment,
    this.donor,
    this.diseaseScreening,
  });

  VerifyAppointmentResponseData.fromJson(dynamic json) {
    verificationStatus = json['verificationStatus'];
    appointmentId = json['appointmentId'];
    appointment = json['appointment'] != null
        ? VerifyAppointmentInfo.fromJson(json['appointment'])
        : null;
    donor = json['donor'] != null
        ? VerifyDonorInfo.fromJson(json['donor'])
        : null;
    diseaseScreening = json['diseaseScreening'] != null
        ? VerifyDiseaseScreening.fromJson(json['diseaseScreening'])
        : null;
  }

  String? verificationStatus;
  String? appointmentId;
  VerifyAppointmentInfo? appointment;
  VerifyDonorInfo? donor;
  VerifyDiseaseScreening? diseaseScreening;
}

class VerifyAppointmentInfo {
  VerifyAppointmentInfo({this.id, this.status, this.verificationStatus, this.donationType});

  VerifyAppointmentInfo.fromJson(dynamic json) {
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

class VerifyDonorInfo {
  VerifyDonorInfo({this.id, this.fullName, this.initials, this.bloodType});

  VerifyDonorInfo.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    initials = json['initials'];
    bloodType = json['bloodType'];
  }

  String? id;
  String? fullName;
  String? initials;
  String? bloodType;
}

class VerifyDiseaseScreening {
  VerifyDiseaseScreening({this.screeningCompleted, this.disqualifyingDiseaseFound});

  VerifyDiseaseScreening.fromJson(dynamic json) {
    screeningCompleted = json['screeningCompleted'];
    disqualifyingDiseaseFound = json['disqualifyingDiseaseFound'];
  }

  bool? screeningCompleted;
  bool? disqualifyingDiseaseFound;
}
