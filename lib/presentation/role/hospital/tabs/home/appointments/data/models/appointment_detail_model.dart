class AppointmentDetailModel {
  AppointmentDetailModel({this.success, this.message, this.data});

  AppointmentDetailModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? AppointmentDetailData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  AppointmentDetailData? data;
}

class AppointmentDetailData {
  AppointmentDetailData({
    this.appointmentId,
    this.appointmentDate,
    this.status,
    this.donorId,
    this.hospitalId,
    this.requestId,
    this.donorDetails,
    this.donor,
  });

  AppointmentDetailData.fromJson(dynamic json) {
    appointmentId = _asString(json['appointmentId'] ?? json['_id'] ?? json['id']);
    appointmentDate = _asString(json['appointmentDate']);
    status = _asString(json['status']);
    donorId = _asString(json['donorId']);
    hospitalId = _asString(json['hospitalId']);
    requestId = _asString(json['requestId']);
    donorDetails = json['donorDetails'] != null
        ? AppointmentDetailDonor.fromJson(json['donorDetails'])
        : null;
    donor = json['donor'] != null
        ? AppointmentDetailDonor.fromJson(json['donor'])
        : null;
  }

  String? appointmentId;
  String? appointmentDate;
  String? status;
  String? donorId;
  String? hospitalId;
  String? requestId;
  AppointmentDetailDonor? donorDetails;
  AppointmentDetailDonor? donor;

  String? get donorName =>
      donor?.fullName ?? donorDetails?.fullName;
  String? get donorBloodType =>
      donor?.bloodType ?? donorDetails?.bloodType;
  String? get donorPhone =>
      donor?.phoneNumber ?? donorDetails?.phoneNumber;
  String? get donorEmail => donor?.email ?? donorDetails?.email;
}

class AppointmentDetailDonor {
  AppointmentDetailDonor({
    this.donorId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.bloodType,
  });

  AppointmentDetailDonor.fromJson(dynamic json) {
    donorId = _asString(json['donorId'] ?? json['_id'] ?? json['id']);
    fullName = _asString(json['fullName']);
    email = _asString(json['email']);
    phoneNumber = _asString(json['phoneNumber']);
    bloodType = _asString(json['bloodType']);
  }

  String? donorId;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? bloodType;
}

String? _asString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}
