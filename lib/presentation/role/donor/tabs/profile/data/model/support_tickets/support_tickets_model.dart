class SupportTicketsModel {
  SupportTicketsModel({this.success, this.message, this.data});

  SupportTicketsModel.fromJson(dynamic json) {
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
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class Data {
  Data({this.tickets, this.pagination});

  Data.fromJson(dynamic json) {
    if (json['tickets'] != null) {
      tickets = [];
      json['tickets'].forEach((v) {
        tickets?.add(Ticket.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  List<Ticket>? tickets;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tickets != null) map['tickets'] = tickets?.map((v) => v.toJson()).toList();
    if (pagination != null) map['pagination'] = pagination?.toJson();
    return map;
  }
}

class Ticket {
  Ticket({
    this.id,
    this.subject,
    this.category,
    this.message,
    this.status,
    this.adminReply,
    this.adminReplyAt,
    this.donorReply,
    this.donorReplyAt,
    this.createdAt,
  });

  Ticket.fromJson(dynamic json) {
    id = json['id'] ?? json['_id'];
    subject = json['subject'];
    category = json['category'];
    message = json['message'];
    status = json['status'];
    adminReply = json['adminReply'];
    adminReplyAt = json['adminReplyAt'];
    donorReply = json['donorReply'];
    donorReplyAt = json['donorReplyAt'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? subject;
  String? category;
  String? message;
  String? status;
  String? adminReply;
  String? adminReplyAt;
  String? donorReply;
  String? donorReplyAt;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subject'] = subject;
    map['category'] = category;
    map['message'] = message;
    map['status'] = status;
    map['adminReply'] = adminReply;
    map['adminReplyAt'] = adminReplyAt;
    map['donorReply'] = donorReply;
    map['donorReplyAt'] = donorReplyAt;
    map['createdAt'] = createdAt;
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
    this.hasPrevPage,
  });

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

class SupportTicketDetailModel {
  SupportTicketDetailModel({this.success, this.message, this.data});

  SupportTicketDetailModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DetailData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  DetailData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class DetailData {
  DetailData({this.ticket});

  DetailData.fromJson(dynamic json) {
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  Ticket? ticket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ticket != null) map['ticket'] = ticket?.toJson();
    return map;
  }
}

class SupportTicketReplyModel {
  SupportTicketReplyModel({this.success, this.message, this.data});

  SupportTicketReplyModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ReplyData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  ReplyData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class ReplyData {
  ReplyData({this.ticket});

  ReplyData.fromJson(dynamic json) {
    ticket = json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
  }

  Ticket? ticket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ticket != null) map['ticket'] = ticket?.toJson();
    return map;
  }
}
