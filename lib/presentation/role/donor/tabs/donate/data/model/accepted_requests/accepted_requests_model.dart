
class AcceptedRequestsModel {
  AcceptedRequestsModel({
      this.success, 
      this.message, 
      this.data,});

  AcceptedRequestsModel.fromJson(dynamic json) {
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


class Data {
  Data({
      this.requests, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['requests'] != null) {
      requests = [];
      json['requests'].forEach((v) {
        requests?.add(Requests.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Requests>? requests;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requests != null) {
      map['requests'] = requests?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 1
/// page : 1
/// currentPage : 1
/// limit : 20
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.currentPage, 
      this.limit, 
      this.totalPages, 
      this.hasNextPage, 
      this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
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

/// requestId : "6a130e83f9830f9b4aeb149d"
/// donationId : "6a1b1f26b61716677456fc66"
/// status : "accepted"
/// donationStatus : "pending"
/// acceptedAt : "2026-06-20T20:14:07.722Z"
/// qrToken : null
/// arrivalDeadline : null
/// qrExpiresAt : null
/// qrExpired : true
/// arrivalDeadlinePassed : false
/// bloodType : ["O+","A+"]
/// bloodTypeLabel : "O+, A+"
/// urgency : "critical"
/// unitsNeeded : 2
/// patientType : "adult"
/// patientDetails : null
/// isEmergency : true
/// hospitalName : "Cairo Care Hospital"
/// contactNumber : "1044444444"
/// hospitalId : "6a130e820b339a45a51addb4"
/// hospitalAddress : {"city":"Cairo","governorate":"Cairo","district":"Garden City"}

class Requests {
  Requests({
      this.requestId, 
      this.donationId, 
      this.status, 
      this.donationStatus, 
      this.acceptedAt, 
      this.qrToken, 
      this.arrivalDeadline, 
      this.qrExpiresAt, 
      this.qrExpired, 
      this.arrivalDeadlinePassed, 
      this.bloodType, 
      this.bloodTypeLabel, 
      this.urgency, 
      this.unitsNeeded, 
      this.patientType, 
      this.patientDetails, 
      this.isEmergency, 
      this.hospitalName, 
      this.contactNumber, 
      this.hospitalId, 
      this.hospitalAddress,});

  Requests.fromJson(dynamic json) {
    requestId = json['requestId'];
    donationId = json['donationId'];
    status = json['status'];
    donationStatus = json['donationStatus'];
    acceptedAt = json['acceptedAt'];
    qrToken = json['qrToken'];
    arrivalDeadline = json['arrivalDeadline'];
    qrExpiresAt = json['qrExpiresAt'];
    qrExpired = json['qrExpired'];
    arrivalDeadlinePassed = json['arrivalDeadlinePassed'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    bloodTypeLabel = json['bloodTypeLabel'];
    urgency = json['urgency'];
    unitsNeeded = json['unitsNeeded'];
    patientType = json['patientType'];
    patientDetails = json['patientDetails'];
    isEmergency = json['isEmergency'];
    hospitalName = json['hospitalName'];
    contactNumber = json['contactNumber'];
    hospitalId = json['hospitalId'];
    hospitalAddress = json['hospitalAddress'] != null ? HospitalAddress.fromJson(json['hospitalAddress']) : null;
  }
  String? requestId;
  String? donationId;
  String? status;
  String? donationStatus;
  String? acceptedAt;
  dynamic qrToken;
  dynamic arrivalDeadline;
  dynamic qrExpiresAt;
  bool? qrExpired;
  bool? arrivalDeadlinePassed;
  List<String>? bloodType;
  String? bloodTypeLabel;
  String? urgency;
  int? unitsNeeded;
  String? patientType;
  dynamic patientDetails;
  bool? isEmergency;
  String? hospitalName;
  String? contactNumber;
  String? hospitalId;
  HospitalAddress? hospitalAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['donationId'] = donationId;
    map['status'] = status;
    map['donationStatus'] = donationStatus;
    map['acceptedAt'] = acceptedAt;
    map['qrToken'] = qrToken;
    map['arrivalDeadline'] = arrivalDeadline;
    map['qrExpiresAt'] = qrExpiresAt;
    map['qrExpired'] = qrExpired;
    map['arrivalDeadlinePassed'] = arrivalDeadlinePassed;
    map['bloodType'] = bloodType;
    map['bloodTypeLabel'] = bloodTypeLabel;
    map['urgency'] = urgency;
    map['unitsNeeded'] = unitsNeeded;
    map['patientType'] = patientType;
    map['patientDetails'] = patientDetails;
    map['isEmergency'] = isEmergency;
    map['hospitalName'] = hospitalName;
    map['contactNumber'] = contactNumber;
    map['hospitalId'] = hospitalId;
    if (hospitalAddress != null) {
      map['hospitalAddress'] = hospitalAddress?.toJson();
    }
    return map;
  }

}

/// city : "Cairo"
/// governorate : "Cairo"
/// district : "Garden City"

class HospitalAddress {
  HospitalAddress({
      this.city, 
      this.governorate, 
      this.district,});

  HospitalAddress.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
    district = json['district'];
  }
  String? city;
  String? governorate;
  String? district;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    map['district'] = district;
    return map;
  }

}