/// success : true
/// message : "Response submitted successfully"
/// data : {"donorId":"6a135b739b8ee66bb0201e26","appointmentId":null,"requestId":"6a130e83f9830f9b4aeb149d","status":"pending","quantity":3,"unitsCollected":null,"hemoglobinLevel":null,"weight":null,"verifiedAt":null,"qrToken":null,"qrExpires":null,"_id":"6a1b1f26b61716677456fc66","createdAt":"2026-05-30T17:32:22.080Z","updatedAt":"2026-05-30T17:32:22.080Z","__v":0}

class RequestAcceptModel {
  RequestAcceptModel({
      this.success, 
      this.message, 
      this.data,});

  RequestAcceptModel.fromJson(dynamic json) {
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

/// donorId : "6a135b739b8ee66bb0201e26"
/// appointmentId : null
/// requestId : "6a130e83f9830f9b4aeb149d"
/// status : "pending"
/// quantity : 3
/// unitsCollected : null
/// hemoglobinLevel : null
/// weight : null
/// verifiedAt : null
/// qrToken : null
/// qrExpires : null
/// _id : "6a1b1f26b61716677456fc66"
/// createdAt : "2026-05-30T17:32:22.080Z"
/// updatedAt : "2026-05-30T17:32:22.080Z"
/// __v : 0

class Data {
  Data({
      this.donorId, 
      this.appointmentId, 
      this.requestId, 
      this.status, 
      this.quantity, 
      this.unitsCollected, 
      this.hemoglobinLevel, 
      this.weight, 
      this.verifiedAt, 
      this.qrToken, 
      this.qrExpires, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    donorId = json['donorId'];
    appointmentId = json['appointmentId'];
    requestId = json['requestId'];
    status = json['status'];
    quantity = json['quantity'];
    unitsCollected = json['unitsCollected'];
    hemoglobinLevel = json['hemoglobinLevel'];
    weight = json['weight'];
    verifiedAt = json['verifiedAt'];
    qrToken = json['qrToken'];
    qrExpires = json['qrExpires'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? donorId;
  dynamic appointmentId;
  String? requestId;
  String? status;
  int? quantity;
  dynamic unitsCollected;
  dynamic hemoglobinLevel;
  dynamic weight;
  dynamic verifiedAt;
  dynamic qrToken;
  dynamic qrExpires;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donorId'] = donorId;
    map['appointmentId'] = appointmentId;
    map['requestId'] = requestId;
    map['status'] = status;
    map['quantity'] = quantity;
    map['unitsCollected'] = unitsCollected;
    map['hemoglobinLevel'] = hemoglobinLevel;
    map['weight'] = weight;
    map['verifiedAt'] = verifiedAt;
    map['qrToken'] = qrToken;
    map['qrExpires'] = qrExpires;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}