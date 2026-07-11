class DonationHistoryModel {
  DonationHistoryModel({
    this.success,
    this.message,
    this.data,});

  DonationHistoryModel.fromJson(dynamic json) {
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
    this.donations,
    this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['donations'] != null) {
      donations = [];
      json['donations'].forEach((v) {
        donations?.add(Donations.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Donations>? donations;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (donations != null) {
      map['donations'] = donations?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}

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

class Donations {
  Donations({
    this.id,
    this.donorId,
    this.appointmentId,
    this.requestId,
    this.status,
    this.quantity,
    this.unitsCollected,
    this.hemoglobinLevel,
    this.weight,
    this.scheduledDate,
    this.verifiedAt,
    this.qrToken,
    this.qrExpiresAt,
    this.autoCancelledAt,
    this.qrScannedAt,
    this.verificationStatus,
    this.verificationSessionId,
    this.verificationStartedAt,
    this.verificationVerifiedAt,
    this.verificationRejectedAt,
    this.verificationRejectedReason,
    this.verificationChecklist,
    this.arrivalDeadline,
    this.qrUsed,
    this.qrUsedAt,
    this.appointmentScheduleDeadline,
    this.createdAt,
    this.updatedAt,
    this.pointsEarned,
    this.hospitalName,});

  Donations.fromJson(dynamic json) {
    id = json['_id'];
    donorId = json['donorId'];
    appointmentId = json['appointmentId'];
    requestId = json['requestId'] != null ? RequestId.fromJson(json['requestId']) : null;
    status = json['status'];
    quantity = json['quantity'];
    unitsCollected = json['unitsCollected'];
    hemoglobinLevel = json['hemoglobinLevel'];
    weight = json['weight'];
    scheduledDate = json['scheduledDate'];
    verifiedAt = json['verifiedAt'];
    qrToken = json['qrToken'];
    qrExpiresAt = json['qrExpiresAt'];
    autoCancelledAt = json['autoCancelledAt'];
    qrScannedAt = json['qrScannedAt'];
    verificationStatus = json['verificationStatus'];
    verificationSessionId = json['verificationSessionId'];
    verificationStartedAt = json['verificationStartedAt'];
    verificationVerifiedAt = json['verificationVerifiedAt'];
    verificationRejectedAt = json['verificationRejectedAt'];
    verificationRejectedReason = json['verificationRejectedReason'];
    verificationChecklist = json['verificationChecklist'] != null
        ? VerificationChecklist.fromJson(json['verificationChecklist'])
        : null;
    arrivalDeadline = json['arrivalDeadline'];
    qrUsed = json['qrUsed'] ?? false;
    qrUsedAt = json['qrUsedAt'];
    appointmentScheduleDeadline = json['appointmentScheduleDeadline'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    pointsEarned = json['pointsEarned'];
    hospitalName = json['hospitalName'];
  }
  String? id;
  String? donorId;
  String? appointmentId;
  RequestId? requestId;
  String? status;
  int? quantity;
  dynamic unitsCollected;
  dynamic hemoglobinLevel;
  dynamic weight;
  String? scheduledDate;
  dynamic verifiedAt;
  dynamic qrToken;
  dynamic qrExpiresAt;
  dynamic autoCancelledAt;
  dynamic qrScannedAt;
  dynamic verificationStatus;
  dynamic verificationSessionId;
  dynamic verificationStartedAt;
  dynamic verificationVerifiedAt;
  dynamic verificationRejectedAt;
  dynamic verificationRejectedReason;
  VerificationChecklist? verificationChecklist;
  dynamic arrivalDeadline;
  bool? qrUsed;
  String? qrUsedAt;
  String? appointmentScheduleDeadline;
  String? createdAt;
  String? updatedAt;
  int? pointsEarned;
  dynamic hospitalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['donorId'] = donorId;
    map['appointmentId'] = appointmentId;
    if (requestId != null) {
      map['requestId'] = requestId?.toJson();
    }
    map['status'] = status;
    map['quantity'] = quantity;
    map['unitsCollected'] = unitsCollected;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['weight'] = weight;
    map['scheduledDate'] = scheduledDate;
    map['verifiedAt'] = verifiedAt;
    map['qrToken'] = qrToken;
    map['qrExpiresAt'] = qrExpiresAt;
    map['autoCancelledAt'] = autoCancelledAt;
    map['qrScannedAt'] = qrScannedAt;
    map['verificationStatus'] = verificationStatus;
    map['verificationSessionId'] = verificationSessionId;
    map['verificationStartedAt'] = verificationStartedAt;
    map['verificationVerifiedAt'] = verificationVerifiedAt;
    map['verificationRejectedAt'] = verificationRejectedAt;
    map['verificationRejectedReason'] = verificationRejectedReason;
    if (verificationChecklist != null) {
      map['verificationChecklist'] = verificationChecklist?.toJson();
    }
    map['arrivalDeadline'] = arrivalDeadline;
    map['qrUsed'] = qrUsed;
    map['qrUsedAt'] = qrUsedAt;
    map['appointmentScheduleDeadline'] = appointmentScheduleDeadline;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['pointsEarned'] = pointsEarned;
    map['hospitalName'] = hospitalName;
    return map;
  }
}

class RequestId {
  RequestId({
    this.id,
    this.hospitalId,
    this.type,
    this.bloodType,
    this.urgency,
  });

  RequestId.fromJson(dynamic json) {
    id = json['_id'];
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    type = json['type'];
    if (json['bloodType'] != null) {
      bloodType = [];
      json['bloodType'].forEach((v) {
        bloodType?.add(v.toString());
      });
    }
    urgency = json['urgency'];
  }

  String? id;
  HospitalId? hospitalId;
  String? type;
  List<String>? bloodType;
  String? urgency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    map['type'] = type;
    if (bloodType != null) {
      map['bloodType'] = bloodType;
    }
    map['urgency'] = urgency;
    return map;
  }
}

class HospitalId {
  HospitalId({
    this.id,
    this.fullName,
    this.address,
    this.hospitalName,
  });

  HospitalId.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    hospitalName = json['hospitalName'];
  }

  String? id;
  String? fullName;
  Address? address;
  String? hospitalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['hospitalName'] = hospitalName;
    return map;
  }
}

class Address {
  Address({
    this.city,
    this.governorate,
    this.district,
  });

  Address.fromJson(dynamic json) {
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

class VerificationChecklist {
  VerificationChecklist({
    this.idVerified,
    this.questionnaireCompleted,
    this.consentSigned,
    this.completedAt,});

  VerificationChecklist.fromJson(dynamic json) {
    idVerified = json['idVerified'] ?? false;
    questionnaireCompleted = json['questionnaireCompleted'] ?? false;
    consentSigned = json['consentSigned'] ?? false;
    completedAt = json['completedAt'];
  }
  bool? idVerified;
  bool? questionnaireCompleted;
  bool? consentSigned;
  dynamic completedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idVerified'] = idVerified;
    map['questionnaireCompleted'] = questionnaireCompleted;
    map['consentSigned'] = consentSigned;
    map['completedAt'] = completedAt;
    return map;
  }
}