class InboundedEmailModel {
  InboundedEmailModel({
    this.success,
    this.message,
    this.data,
  });

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

class Data {
  Data({
    this.items,
    this.pagination,
  });

  Data.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Items>? items;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
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

class Items {
  Items({
    this.id,
    this.userId,
    this.fullName,
    this.email,
    this.role,
    this.category,
    this.subject,
    this.message,
    this.attachmentUrls,
    this.status,
    this.adminReply,
    this.adminReplyAt,
    this.adminReplyBy,
    this.donorReply,
    this.donorReplyAt,
    this.replies,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isRead,
    this.isArchived,
    this.type,
  });

  Items.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    category = json['category'];
    subject = json['subject'];
    message = json['message'];
    if (json['attachmentUrls'] != null) {
      attachmentUrls = [];
      json['attachmentUrls'].forEach((v) {
        attachmentUrls?.add(v.toString());
      });
    }
    status = json['status'];
    adminReply = json['adminReply'];
    adminReplyAt = json['adminReplyAt'];
    adminReplyBy = json['adminReplyBy'];
    donorReply = json['donorReply'];
    donorReplyAt = json['donorReplyAt'];
    if (json['replies'] != null) {
      replies = [];
      json['replies'].forEach((v) {
        replies?.add(TicketReply.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    isRead = json['isRead'];
    isArchived = json['isArchived'];
    type = json['type'];
  }
  String? id;
  String? userId;
  String? fullName;
  String? email;
  String? role;
  String? category;
  String? subject;
  String? message;
  List<dynamic>? attachmentUrls;
  String? status;
  dynamic adminReply;
  dynamic adminReplyAt;
  dynamic adminReplyBy;
  dynamic donorReply;
  dynamic donorReplyAt;
  List<TicketReply>? replies;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? isRead;
  bool? isArchived;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['category'] = category;
    map['subject'] = subject;
    map['message'] = message;
    if (attachmentUrls != null) {
      map['attachmentUrls'] = attachmentUrls?.map((v) => v).toList();
    }
    map['status'] = status;
    map['adminReply'] = adminReply;
    map['adminReplyAt'] = adminReplyAt;
    map['adminReplyBy'] = adminReplyBy;
    map['donorReply'] = donorReply;
    map['donorReplyAt'] = donorReplyAt;
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['isRead'] = isRead;
    map['isArchived'] = isArchived;
    map['type'] = type;
    return map;
  }
}

class TicketReply {
  TicketReply({
    this.sender,
    this.senderId,
    this.text,
    this.createdAt,
  });

  TicketReply.fromJson(dynamic json) {
    sender = json['sender'];
    senderId = json['senderId'];
    text = json['text'];
    createdAt = json['createdAt'];
  }
  String? sender;
  String? senderId;
  String? text;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = sender;
    map['senderId'] = senderId;
    map['text'] = text;
    map['createdAt'] = createdAt;
    return map;
  }
}