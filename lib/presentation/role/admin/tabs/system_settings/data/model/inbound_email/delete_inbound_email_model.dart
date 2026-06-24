/// success : true
/// message : "Inbound email deleted successfully"
/// data : {"inboundEmail":{"_id":"66f700000000000000000001"}}

class DeleteInboundEmailModel {
  DeleteInboundEmailModel({
      this.success, 
      this.message, 
      this.data,});

  DeleteInboundEmailModel.fromJson(dynamic json) {
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

/// inboundEmail : {"_id":"66f700000000000000000001"}

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

class InboundEmail {
  InboundEmail({
      this.id,});

  InboundEmail.fromJson(dynamic json) {
    id = json['_id'];
  }
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    return map;
  }

}