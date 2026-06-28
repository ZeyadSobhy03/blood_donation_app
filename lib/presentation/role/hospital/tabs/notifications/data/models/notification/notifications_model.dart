class NotificationsModel {
  NotificationsModel({this.success, this.message, this.data});

  NotificationsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? NotificationListData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  NotificationListData? data;

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

class NotificationListData {
  NotificationListData({this.notifications, this.unreadCount, this.pagination});

  NotificationListData.fromJson(dynamic json) {
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(NotificationItem.fromJson(v));
      });
    }
    unreadCount = json['unreadCount'];
    pagination = json['pagination'] != null
        ? PaginationInfo.fromJson(json['pagination'])
        : null;
  }
  List<NotificationItem>? notifications;
  int? unreadCount;
  PaginationInfo? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notifications != null) {
      map['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    map['unreadCount'] = unreadCount;
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}

class PaginationInfo {
  PaginationInfo({this.page, this.limit, this.total, this.pages});

  PaginationInfo.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
  }
  int? page;
  int? limit;
  int? total;
  int? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['pages'] = pages;
    return map;
  }
}

class NotificationItem {
  NotificationItem({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.message,
    this.read,
    this.relatedId,
    this.relatedType,
    this.data,
    this.dataRaw,
    this.createdAt,
    this.updatedAt,
  });

  NotificationItem.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    read = json['read'];
    relatedId = json['relatedId'];
    relatedType = json['relatedType'];
    data = json['data'] != null ? NotificationExtraData.fromJson(json['data']) : null;
    dataRaw = json['data'] as Map<String, dynamic>?;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? userId;
  String? type;
  String? title;
  String? message;
  bool? read;
  String? relatedId;
  String? relatedType;
  NotificationExtraData? data;
  Map<String, dynamic>? dataRaw;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    map['type'] = type;
    map['title'] = title;
    map['message'] = message;
    map['read'] = read;
    map['relatedId'] = relatedId;
    map['relatedType'] = relatedType;
    if (dataRaw != null) {
      map['data'] = dataRaw;
    } else if (data != null) {
      map['data'] = data?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class NotificationExtraData {
  NotificationExtraData({this.requestId, this.hospitalName, this.requestType});

  NotificationExtraData.fromJson(dynamic json) {
    requestId = json['requestId'];
    hospitalName = json['hospitalName'];
    requestType = json['requestType'];
  }
  String? requestId;
  String? hospitalName;
  String? requestType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['hospitalName'] = hospitalName;
    map['requestType'] = requestType;
    return map;
  }
}
