/// success : true
/// message : "Donation history retrieved successfully"
/// data : {"donations":[{"_id":"6a3c1b0b904b2a5a51805c7c","donorId":"6a130e800b339a45a51addad","appointmentId":"6a3c1b0b904b2a5a51805c7b","requestId":null,"status":"cancelled","quantity":1,"unitsCollected":null,"hemoglobinLevel":null,"weight":null,"scheduledDate":"2026-06-30T12:00:00.000Z","verifiedAt":null,"qrToken":null,"qrExpiresAt":null,"autoCancelledAt":null,"qrScannedAt":null,"verificationStatus":null,"verificationSessionId":null,"verificationStartedAt":null,"verificationVerifiedAt":null,"verificationRejectedAt":null,"verificationRejectedReason":null,"verificationChecklist":{"idVerified":false,"questionnaireCompleted":false,"consentSigned":false,"completedAt":null},"arrivalDeadline":null,"qrUsed":true,"qrUsedAt":"2026-06-24T17:59:59.682Z","appointmentScheduleDeadline":"2026-07-08T17:59:39.770Z","createdAt":"2026-06-24T17:59:39.770Z","updatedAt":"2026-06-24T17:59:59.711Z","pointsEarned":0,"hospitalName":null},{"_id":"6a3aff85cc4d84c574c92bad","donorId":"6a130e800b339a45a51addad","appointmentId":null,"requestId":{"_id":"6a3af9b10444869ae3903166","hospitalId":{"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","hospitalName":"Cairo Care Operations"},"type":"blood","bloodType":["A+","A-","B+","AB-","AB+","B-","O+","O-"],"urgency":"high"},"status":"cancelled","quantity":1,"unitsCollected":null,"hemoglobinLevel":null,"weight":null,"verifiedAt":null,"qrToken":"52b45f02e0f133628b8a5302a98a373eb133941895102fc9ec7a3bc8783f50f0","qrExpiresAt":"2026-06-24T09:49:57.275Z","autoCancelledAt":null,"qrScannedAt":null,"verificationStatus":null,"verificationSessionId":null,"verificationStartedAt":null,"verificationVerifiedAt":null,"verificationRejectedAt":null,"verificationRejectedReason":null,"verificationChecklist":{"idVerified":false,"questionnaireCompleted":false,"consentSigned":false,"completedAt":null},"arrivalDeadline":"2026-06-24T09:49:57.275Z","qrUsed":true,"qrUsedAt":"2026-06-23T22:17:12.090Z","appointmentScheduleDeadline":"2026-07-07T21:49:57.279Z","createdAt":"2026-06-23T21:49:57.283Z","updatedAt":"2026-06-23T22:17:12.150Z","pointsEarned":0,"hospitalName":"Cairo Care Operations"},{"_id":"6a130e83f9830f9b4aeb149f","donorId":"6a130e800b339a45a51addad","status":"pending","requestId":{"_id":"6a130e82f9830f9b4aeb1494","hospitalId":{"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","hospitalName":"Cairo Care Operations"},"bloodType":["O+","B-"],"type":"blood","urgency":"critical"},"appointmentId":null,"createdAt":"2026-05-24T14:43:15.234Z","hemoglobinLevel":null,"notes":"Confirmed availability for urgent O+ request.","qrExpires":null,"qrToken":null,"quantity":1,"unitsCollected":null,"updatedAt":"2026-06-25T22:31:10.654Z","verifiedAt":null,"weight":null,"qrUsed":true,"qrUsedAt":"2026-06-23T21:34:17.760Z","appointmentScheduleDeadline":"2026-07-07T21:34:17.681Z","verificationChecklist":{"consentSigned":false,"idVerified":false,"questionnaireCompleted":false},"pointsEarned":0,"hospitalName":"Cairo Care Operations"}],"pagination":{"total":3,"page":1,"currentPage":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

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

/// donations : [{"_id":"6a3c1b0b904b2a5a51805c7c","donorId":"6a130e800b339a45a51addad","appointmentId":"6a3c1b0b904b2a5a51805c7b","requestId":null,"status":"cancelled","quantity":1,"unitsCollected":null,"hemoglobinLevel":null,"weight":null,"scheduledDate":"2026-06-30T12:00:00.000Z","verifiedAt":null,"qrToken":null,"qrExpiresAt":null,"autoCancelledAt":null,"qrScannedAt":null,"verificationStatus":null,"verificationSessionId":null,"verificationStartedAt":null,"verificationVerifiedAt":null,"verificationRejectedAt":null,"verificationRejectedReason":null,"verificationChecklist":{"idVerified":false,"questionnaireCompleted":false,"consentSigned":false,"completedAt":null},"arrivalDeadline":null,"qrUsed":true,"qrUsedAt":"2026-06-24T17:59:59.682Z","appointmentScheduleDeadline":"2026-07-08T17:59:39.770Z","createdAt":"2026-06-24T17:59:39.770Z","updatedAt":"2026-06-24T17:59:59.711Z","pointsEarned":0,"hospitalName":null},{"_id":"6a3aff85cc4d84c574c92bad","donorId":"6a130e800b339a45a51addad","appointmentId":null,"requestId":{"_id":"6a3af9b10444869ae3903166","hospitalId":{"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","hospitalName":"Cairo Care Operations"},"type":"blood","bloodType":["A+","A-","B+","AB-","AB+","B-","O+","O-"],"urgency":"high"},"status":"cancelled","quantity":1,"unitsCollected":null,"hemoglobinLevel":null,"weight":null,"verifiedAt":null,"qrToken":"52b45f02e0f133628b8a5302a98a373eb133941895102fc9ec7a3bc8783f50f0","qrExpiresAt":"2026-06-24T09:49:57.275Z","autoCancelledAt":null,"qrScannedAt":null,"verificationStatus":null,"verificationSessionId":null,"verificationStartedAt":null,"verificationVerifiedAt":null,"verificationRejectedAt":null,"verificationRejectedReason":null,"verificationChecklist":{"idVerified":false,"questionnaireCompleted":false,"consentSigned":false,"completedAt":null},"arrivalDeadline":"2026-06-24T09:49:57.275Z","qrUsed":true,"qrUsedAt":"2026-06-23T22:17:12.090Z","appointmentScheduleDeadline":"2026-07-07T21:49:57.279Z","createdAt":"2026-06-23T21:49:57.283Z","updatedAt":"2026-06-23T22:17:12.150Z","pointsEarned":0,"hospitalName":"Cairo Care Operations"},{"_id":"6a130e83f9830f9b4aeb149f","donorId":"6a130e800b339a45a51addad","status":"pending","requestId":{"_id":"6a130e82f9830f9b4aeb1494","hospitalId":{"_id":"6a130e820b339a45a51addb4","fullName":"Cairo Care Operations","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"},"__t":"hospital","hospitalName":"Cairo Care Operations"},"bloodType":["O+","B-"],"type":"blood","urgency":"critical"},"appointmentId":null,"createdAt":"2026-05-24T14:43:15.234Z","hemoglobinLevel":null,"notes":"Confirmed availability for urgent O+ request.","qrExpires":null,"qrToken":null,"quantity":1,"unitsCollected":null,"updatedAt":"2026-06-25T22:31:10.654Z","verifiedAt":null,"weight":null,"qrUsed":true,"qrUsedAt":"2026-06-23T21:34:17.760Z","appointmentScheduleDeadline":"2026-07-07T21:34:17.681Z","verificationChecklist":{"consentSigned":false,"idVerified":false,"questionnaireCompleted":false},"pointsEarned":0,"hospitalName":"Cairo Care Operations"}]
/// pagination : {"total":3,"page":1,"currentPage":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

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

/// total : 3
/// page : 1
/// currentPage : 1
/// limit : 10
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

/// _id : "6a3c1b0b904b2a5a51805c7c"
/// donorId : "6a130e800b339a45a51addad"
/// appointmentId : "6a3c1b0b904b2a5a51805c7b"
/// requestId : null
/// status : "cancelled"
/// quantity : 1
/// unitsCollected : null
/// hemoglobinLevel : null
/// weight : null
/// scheduledDate : "2026-06-30T12:00:00.000Z"
/// verifiedAt : null
/// qrToken : null
/// qrExpiresAt : null
/// autoCancelledAt : null
/// qrScannedAt : null
/// verificationStatus : null
/// verificationSessionId : null
/// verificationStartedAt : null
/// verificationVerifiedAt : null
/// verificationRejectedAt : null
/// verificationRejectedReason : null
/// verificationChecklist : {"idVerified":false,"questionnaireCompleted":false,"consentSigned":false,"completedAt":null}
/// arrivalDeadline : null
/// qrUsed : true
/// qrUsedAt : "2026-06-24T17:59:59.682Z"
/// appointmentScheduleDeadline : "2026-07-08T17:59:39.770Z"
/// createdAt : "2026-06-24T17:59:39.770Z"
/// updatedAt : "2026-06-24T17:59:59.711Z"
/// pointsEarned : 0
/// hospitalName : null

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
    requestId = json['requestId'];
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
    verificationChecklist = json['verificationChecklist'];
    arrivalDeadline = json['arrivalDeadline'];
    qrUsed = json['qrUsed'];
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
  dynamic requestId;
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
    map['requestId'] = requestId;
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
    map['verificationChecklist'] = verificationChecklist;
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

/// idVerified : false
/// questionnaireCompleted : false
/// consentSigned : false
/// completedAt : null

class VerificationChecklist {
  VerificationChecklist({
      this.idVerified, 
      this.questionnaireCompleted, 
      this.consentSigned, 
      this.completedAt,});

  VerificationChecklist.fromJson(dynamic json) {
    idVerified = json['idVerified'];
    questionnaireCompleted = json['questionnaireCompleted'];
    consentSigned = json['consentSigned'];
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