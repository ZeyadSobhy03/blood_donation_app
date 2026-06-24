/// success : true
/// message : "Support request submitted successfully"
/// data : {"ticket":{"id":"670000000000000000000001","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","subject":"Need help with reward redemption","category":"REWARDS","message":"I can see my points balance but I want to confirm when the Coffee Voucher becomes available.","createdAt":"2026-05-24T16:24:00.000Z"}}

class SupportContactModel {
  SupportContactModel({
      this.success, 
      this.message, 
      this.data,});

  SupportContactModel.fromJson(dynamic json) {
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

/// ticket : {"id":"670000000000000000000001","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","subject":"Need help with reward redemption","category":"REWARDS","message":"I can see my points balance but I want to confirm when the Coffee Voucher becomes available.","createdAt":"2026-05-24T16:24:00.000Z"}

class Data {
  Data({
      this.ticket,});

  Data.fromJson(dynamic json) {
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }
  Ticket? ticket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ticket != null) {
      map['ticket'] = ticket?.toJson();
    }
    return map;
  }

}

/// id : "670000000000000000000001"
/// fullName : "Aya Hassan"
/// email : "aya.hassan@lifelink.demo"
/// role : "donor"
/// subject : "Need help with reward redemption"
/// category : "REWARDS"
/// message : "I can see my points balance but I want to confirm when the Coffee Voucher becomes available."
/// createdAt : "2026-05-24T16:24:00.000Z"

class Ticket {
  Ticket({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.subject, 
      this.category, 
      this.message, 
      this.createdAt,});

  Ticket.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    subject = json['subject'];
    category = json['category'];
    message = json['message'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? subject;
  String? category;
  String? message;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['subject'] = subject;
    map['category'] = category;
    map['message'] = message;
    map['createdAt'] = createdAt;
    return map;
  }

}