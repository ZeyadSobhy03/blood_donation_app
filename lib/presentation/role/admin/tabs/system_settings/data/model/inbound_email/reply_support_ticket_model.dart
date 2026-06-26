/// success : true
/// message : "Reply sent successfully"
/// data : {"ticket":{"_id":"670000000000000000000001","status":"CLOSED","adminReply":"Thank you for your feedback."}}

class ReplySupportTicketModel {
  ReplySupportTicketModel({
    this.success,
    this.message,
    this.data,
  });

  ReplySupportTicketModel.fromJson(dynamic json) {
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

/// ticket : {"_id":"670000000000000000000001","status":"CLOSED","adminReply":"Thank you for your feedback."}

class Data {
  Data({this.ticket});

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

/// _id : "670000000000000000000001"
/// status : "CLOSED"
/// adminReply : "Thank you for your feedback."

class Ticket {
  Ticket({
    this.id,
    this.status,
    this.adminReply,
  });

  Ticket.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    adminReply = json['adminReply'];
  }
  String? id;
  String? status;
  String? adminReply;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['adminReply'] = adminReply;
    return map;
  }
}
