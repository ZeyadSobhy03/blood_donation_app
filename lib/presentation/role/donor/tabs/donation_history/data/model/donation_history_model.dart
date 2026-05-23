/// success : true
/// data : {"donations":[{"_id":"6a089dc87696fa4f13219a99","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07107034afd013dea938b8","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"pending","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T16:39:36.046Z","updatedAt":"2026-05-16T16:39:36.046Z","__v":0,"pointsEarned":0},{"_id":"6a089bd67696fa4f13219a98","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07116434afd013dea938b9","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"cancelled","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T16:31:18.612Z","updatedAt":"2026-05-16T16:31:26.817Z","__v":0,"pointsEarned":0},{"_id":"6a0892ea7696fa4f13219a97","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07117934afd013dea938ba","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"pending","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T15:53:14.537Z","updatedAt":"2026-05-16T15:53:14.537Z","__v":0,"pointsEarned":0},{"_id":"6a0711ff65ff7785a03189fe","status":"pending","requestId":{"_id":"6a0711fe65ff7785a03189fc","hospitalId":{"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}},"bloodType":"O+","type":"blood","urgency":"critical"},"donorId":"6a06ea9888988a725cb260f0","__v":0,"createdAt":"2026-05-15T12:30:56.649Z","notes":"Emergency responder Yasmine Farouk - matched O+ emergency request for Cairo Care Hospital.","qrExpires":null,"qrToken":null,"quantity":1,"updatedAt":"2026-05-15T19:33:05.461Z","pointsEarned":0},{"_id":"6a06ea9965ff7785a031893d","status":"pending","requestId":{"_id":"69fe540565ff7785a031314f","hospitalId":{"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}},"bloodType":"O+","type":"blood","urgency":"critical"},"donorId":"6a06ea9888988a725cb260f0","__v":0,"createdAt":"2026-05-15T09:42:50.746Z","notes":"Nearby responder accepted urgent O+ request for Cairo Care Hospital.","qrExpires":null,"qrToken":null,"quantity":1,"updatedAt":"2026-05-15T19:33:04.940Z","pointsEarned":0}],"pagination":{"total":5,"page":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class DonationHistoryModel {
  DonationHistoryModel({
      this.success, 
      this.data,});

  DonationHistoryModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// donations : [{"_id":"6a089dc87696fa4f13219a99","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07107034afd013dea938b8","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"pending","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T16:39:36.046Z","updatedAt":"2026-05-16T16:39:36.046Z","__v":0,"pointsEarned":0},{"_id":"6a089bd67696fa4f13219a98","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07116434afd013dea938b9","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"cancelled","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T16:31:18.612Z","updatedAt":"2026-05-16T16:31:26.817Z","__v":0,"pointsEarned":0},{"_id":"6a0892ea7696fa4f13219a97","donorId":"6a06ea9888988a725cb260f0","requestId":{"_id":"6a07117934afd013dea938ba","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"},"status":"pending","quantity":3,"qrToken":null,"qrExpires":null,"createdAt":"2026-05-16T15:53:14.537Z","updatedAt":"2026-05-16T15:53:14.537Z","__v":0,"pointsEarned":0},{"_id":"6a0711ff65ff7785a03189fe","status":"pending","requestId":{"_id":"6a0711fe65ff7785a03189fc","hospitalId":{"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}},"bloodType":"O+","type":"blood","urgency":"critical"},"donorId":"6a06ea9888988a725cb260f0","__v":0,"createdAt":"2026-05-15T12:30:56.649Z","notes":"Emergency responder Yasmine Farouk - matched O+ emergency request for Cairo Care Hospital.","qrExpires":null,"qrToken":null,"quantity":1,"updatedAt":"2026-05-15T19:33:05.461Z","pointsEarned":0},{"_id":"6a06ea9965ff7785a031893d","status":"pending","requestId":{"_id":"69fe540565ff7785a031314f","hospitalId":{"_id":"69f3df915f42685cbbbcbb1b","fullName":"Cairo Care Operations","__t":"hospital","hospitalName":"Cairo Care Hospital","address":{"city":"Cairo","governorate":"Cairo","district":"Garden City"}},"bloodType":"O+","type":"blood","urgency":"critical"},"donorId":"6a06ea9888988a725cb260f0","__v":0,"createdAt":"2026-05-15T09:42:50.746Z","notes":"Nearby responder accepted urgent O+ request for Cairo Care Hospital.","qrExpires":null,"qrToken":null,"quantity":1,"updatedAt":"2026-05-15T19:33:04.940Z","pointsEarned":0}]
/// pagination : {"total":5,"page":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

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

/// total : 5
/// page : 1
/// limit : 10
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.hasNextPage, 
      this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }

}

/// _id : "6a089dc87696fa4f13219a99"
/// donorId : "6a06ea9888988a725cb260f0"
/// requestId : {"_id":"6a07107034afd013dea938b8","hospitalId":null,"type":"blood","bloodType":"O+","urgency":"critical"}
/// status : "pending"
/// quantity : 3
/// qrToken : null
/// qrExpires : null
/// createdAt : "2026-05-16T16:39:36.046Z"
/// updatedAt : "2026-05-16T16:39:36.046Z"
/// __v : 0
/// pointsEarned : 0

class Donations {
  Donations({
      this.id, 
      this.donorId, 
      this.requestId, 
      this.status, 
      this.quantity, 
      this.qrToken, 
      this.qrExpires, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.pointsEarned,});

  Donations.fromJson(dynamic json) {
    id = json['_id'];
    donorId = json['donorId'];
    requestId = json['requestId'] != null ? RequestId.fromJson(json['requestId']) : null;
    status = json['status'];
    quantity = json['quantity'];
    qrToken = json['qrToken'];
    qrExpires = json['qrExpires'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    pointsEarned = json['pointsEarned'];
  }
  String? id;
  String? donorId;
  RequestId? requestId;
  String? status;
  int? quantity;
  dynamic qrToken;
  dynamic qrExpires;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? pointsEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['donorId'] = donorId;
    if (requestId != null) {
      map['requestId'] = requestId?.toJson();
    }
    map['status'] = status;
    map['quantity'] = quantity;
    map['qrToken'] = qrToken;
    map['qrExpires'] = qrExpires;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['pointsEarned'] = pointsEarned;
    return map;
  }

}

/// _id : "6a07107034afd013dea938b8"
/// hospitalId : null
/// type : "blood"
/// bloodType : "O+"
/// urgency : "critical"

class RequestId {
  RequestId({
      this.id, 
      this.hospitalId, 
      this.type, 
      this.bloodType, 
      this.urgency,});

  RequestId.fromJson(dynamic json) {
    id = json['_id'];
    hospitalId = json['hospitalId'];
    type = json['type'];
    bloodType = json['bloodType'];
    urgency = json['urgency'];
  }
  String? id;
  dynamic hospitalId;
  String? type;
  String? bloodType;
  String? urgency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hospitalId'] = hospitalId;
    map['type'] = type;
    map['bloodType'] = bloodType;
    map['urgency'] = urgency;
    return map;
  }

}