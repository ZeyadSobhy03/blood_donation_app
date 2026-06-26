/// success : true
/// message : "Inbound emails retrieved successfully"
/// data : {"inboundEmails":[{"_id":"66f700000000000000000001","provider":"resend","from":"donor.followup@lifelink.demo","to":["support@lifelink.demo"],"subject":"Donation follow-up","isRead":false,"isArchived":false,"receivedAt":"2026-05-18T08:30:00.000Z"}],"supportTickets":[{"_id":"670000000000000000000001","userId":"670000000000000000000000","fullName":"Mohamed Yaser","email":"donor@example.com","role":"donor","subject":"Need help with reward redemption","category":"REWARDS","status":"OPEN","adminReply":null,"createdAt":"2026-05-24T16:24:00.000Z"}],"pagination":{"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class InboundedEmailModel {
  InboundedEmailModel({
      this.success, 
      this.message, 
      this.data,});

  InboundedEmailModel.fromJson(dynamic json) {
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

/// inboundEmails : [{"_id":"66f700000000000000000001","provider":"resend","from":"donor.followup@lifelink.demo","to":["support@lifelink.demo"],"subject":"Donation follow-up","isRead":false,"isArchived":false,"receivedAt":"2026-05-18T08:30:00.000Z"}]
/// supportTickets : [{"_id":"670000000000000000000001","userId":"670000000000000000000000","fullName":"Mohamed Yaser","email":"donor@example.com","role":"donor","subject":"Need help with reward redemption","category":"REWARDS","status":"OPEN","adminReply":null,"createdAt":"2026-05-24T16:24:00.000Z"}]
/// pagination : {"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

class Data {
  Data({
      this.inboundEmails, 
      this.supportTickets, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['inboundEmails'] != null) {
      inboundEmails = [];
      json['inboundEmails'].forEach((v) {
        inboundEmails?.add(InboundEmails.fromJson(v));
      });
    }
    if (json['supportTickets'] != null) {
      supportTickets = [];
      json['supportTickets'].forEach((v) {
        supportTickets?.add(SupportTickets.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<InboundEmails>? inboundEmails;
  List<SupportTickets>? supportTickets;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (inboundEmails != null) {
      map['inboundEmails'] = inboundEmails?.map((v) => v.toJson()).toList();
    }
    if (supportTickets != null) {
      map['supportTickets'] = supportTickets?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 1
/// page : 1
/// limit : 20
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

/// _id : "670000000000000000000001"
/// userId : "670000000000000000000000"
/// fullName : "Mohamed Yaser"
/// email : "donor@example.com"
/// role : "donor"
/// subject : "Need help with reward redemption"
/// category : "REWARDS"
/// status : "OPEN"
/// adminReply : null
/// createdAt : "2026-05-24T16:24:00.000Z"

class SupportTickets {
  SupportTickets({
      this.id, 
      this.userId, 
      this.fullName, 
      this.email, 
      this.role, 
      this.subject, 
      this.category, 
      this.status, 
      this.adminReply, 
      this.createdAt,});

  SupportTickets.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    subject = json['subject'];
    category = json['category'];
    status = json['status'];
    adminReply = json['adminReply'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? userId;
  String? fullName;
  String? email;
  String? role;
  String? subject;
  String? category;
  String? status;
  dynamic adminReply;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['subject'] = subject;
    map['category'] = category;
    map['status'] = status;
    map['adminReply'] = adminReply;
    map['createdAt'] = createdAt;
    return map;
  }

}

/// _id : "66f700000000000000000001"
/// provider : "resend"
/// from : "donor.followup@lifelink.demo"
/// to : ["support@lifelink.demo"]
/// subject : "Donation follow-up"
/// isRead : false
/// isArchived : false
/// receivedAt : "2026-05-18T08:30:00.000Z"

class InboundEmails {
  InboundEmails({
      this.id, 
      this.provider, 
      this.from, 
      this.to, 
      this.subject, 
      this.isRead, 
      this.isArchived, 
      this.receivedAt,});

  InboundEmails.fromJson(dynamic json) {
    id = json['_id'];
    provider = json['provider'];
    from = json['from'];
    to = json['to'] != null ? json['to'].cast<String>() : [];
    subject = json['subject'];
    isRead = json['isRead'];
    isArchived = json['isArchived'];
    receivedAt = json['receivedAt'];
  }
  String? id;
  String? provider;
  String? from;
  List<String>? to;
  String? subject;
  bool? isRead;
  bool? isArchived;
  String? receivedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['provider'] = provider;
    map['from'] = from;
    map['to'] = to;
    map['subject'] = subject;
    map['isRead'] = isRead;
    map['isArchived'] = isArchived;
    map['receivedAt'] = receivedAt;
    return map;
  }

}