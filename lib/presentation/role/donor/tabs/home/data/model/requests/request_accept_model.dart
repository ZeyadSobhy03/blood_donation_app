/// success : true
/// message : "Response submitted"
/// data : {"requestId":"69fe540565ff7785a031314f","donationId":"69fe540565ff7785a031314a","status":"accepted","qrToken":"a18df3083c83f3a8c1d90a61d6c70a0f5316897f4feefdc9611b32ad7dd114e2","qrExpiresAt":"2026-05-18T11:45:00.000Z","acceptedAt":"2026-05-18T09:45:00.000Z","arrivalDeadline":"2026-05-18T11:45:00.000Z","unitsAccepted":3,"unitsNeeded":3,"fullyAccepted":true,"missedDonationCount":0,"missedDonationRemaining":3}

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

/// requestId : "69fe540565ff7785a031314f"
/// donationId : "69fe540565ff7785a031314a"
/// status : "accepted"
/// qrToken : "a18df3083c83f3a8c1d90a61d6c70a0f5316897f4feefdc9611b32ad7dd114e2"
/// qrExpiresAt : "2026-05-18T11:45:00.000Z"
/// acceptedAt : "2026-05-18T09:45:00.000Z"
/// arrivalDeadline : "2026-05-18T11:45:00.000Z"
/// unitsAccepted : 3
/// unitsNeeded : 3
/// fullyAccepted : true
/// missedDonationCount : 0
/// missedDonationRemaining : 3

class Data {
  Data({
      this.requestId, 
      this.donationId, 
      this.status, 
      this.qrToken, 
      this.qrExpiresAt, 
      this.acceptedAt, 
      this.arrivalDeadline, 
      this.unitsAccepted, 
      this.unitsNeeded, 
      this.fullyAccepted, 
      this.missedDonationCount, 
      this.missedDonationRemaining,});

  Data.fromJson(dynamic json) {
    requestId = json['requestId'];
    donationId = json['donationId'];
    status = json['status'];
    qrToken = json['qrToken'];
    qrExpiresAt = json['qrExpiresAt'];
    acceptedAt = json['acceptedAt'];
    arrivalDeadline = json['arrivalDeadline'];
    unitsAccepted = json['unitsAccepted'];
    unitsNeeded = json['unitsNeeded'];
    fullyAccepted = json['fullyAccepted'];
    missedDonationCount = json['missedDonationCount'];
    missedDonationRemaining = json['missedDonationRemaining'];
  }
  String? requestId;
  String? donationId;
  String? status;
  String? qrToken;
  String? qrExpiresAt;
  String? acceptedAt;
  String? arrivalDeadline;
  int? unitsAccepted;
  int? unitsNeeded;
  bool? fullyAccepted;
  int? missedDonationCount;
  int? missedDonationRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['donationId'] = donationId;
    map['status'] = status;
    map['qrToken'] = qrToken;
    map['qrExpiresAt'] = qrExpiresAt;
    map['acceptedAt'] = acceptedAt;
    map['arrivalDeadline'] = arrivalDeadline;
    map['unitsAccepted'] = unitsAccepted;
    map['unitsNeeded'] = unitsNeeded;
    map['fullyAccepted'] = fullyAccepted;
    map['missedDonationCount'] = missedDonationCount;
    map['missedDonationRemaining'] = missedDonationRemaining;
    return map;
  }

}