/// success : true
/// message : "Inbound email marked as read"
/// data : {"inboundEmail":{"_id":"66f700000000000000000001","isRead":true,"readAt":"2026-05-18T09:00:00.000Z"}}

class MarkAsReadInboundModel {
  MarkAsReadInboundModel({
      this.success, 
      this.message, 
      this.data,});

  MarkAsReadInboundModel.fromJson(dynamic json) {
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

/// inboundEmail : {"_id":"66f700000000000000000001","isRead":true,"readAt":"2026-05-18T09:00:00.000Z"}

class Data {
  Data({
      this.inboundEmail,});

  Data.fromJson(dynamic json) {
    inboundEmail = json['inboundEmail'] != null ? InboundEmail.fromJson(json['inboundEmail']) : null;
  }
  InboundEmail? inboundEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (inboundEmail != null) {
      map['inboundEmail'] = inboundEmail?.toJson();
    }
    return map;
  }

}

/// _id : "66f700000000000000000001"
/// isRead : true
/// readAt : "2026-05-18T09:00:00.000Z"

class InboundEmail {
  InboundEmail({
      this.id, 
      this.isRead, 
      this.readAt,});

  InboundEmail.fromJson(dynamic json) {
    id = json['_id'];
    isRead = json['isRead'];
    readAt = json['readAt'];
  }
  String? id;
  bool? isRead;
  String? readAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['isRead'] = isRead;
    map['readAt'] = readAt;
    return map;
  }

}