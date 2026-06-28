class RejectAppointmentModel {
  RejectAppointmentModel({this.success, this.message, this.data});

  RejectAppointmentModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? RejectAppointmentData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  RejectAppointmentData? data;
}

class RejectAppointmentData {
  RejectAppointmentData({
    this.appointmentId,
    this.verificationStatus,
    this.rejectedAt,
    this.reason,
    this.requestStatus,
    this.donationStatus,
  });

  RejectAppointmentData.fromJson(dynamic json) {
    appointmentId = json['appointmentId'];
    verificationStatus = json['verificationStatus'];
    rejectedAt = json['rejectedAt'];
    reason = json['reason'];
    requestStatus = json['requestStatus'];
    donationStatus = json['donationStatus'];
  }

  String? appointmentId;
  String? verificationStatus;
  String? rejectedAt;
  String? reason;
  String? requestStatus;
  String? donationStatus;
}