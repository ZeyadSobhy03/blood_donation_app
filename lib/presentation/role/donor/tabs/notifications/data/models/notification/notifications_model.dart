/// success : true
/// message : "Notifications retrieved successfully"
/// data : {"notifications":[{"_id":"69fe540565ff7785a0313170","userId":"69f3df915f42685cbbbcbb18","type":"emergency","title":"Emergency blood request near you","message":"A hospital near you needs O+ blood for an urgent request. Tap to view details.","read":false,"relatedId":"69fe540565ff7785a031314f","relatedType":"Request","data":{"requestId":"69fe540565ff7785a031314f","hospitalName":"Cairo Care Hospital","requestType":"blood"},"createdAt":"2026-05-16T13:24:00.000Z","updatedAt":"2026-05-16T13:24:00.000Z"}],"unreadCount":3,"pagination":{"page":1,"limit":20,"total":42,"pages":3}}

class NotificationsModel {
  NotificationsModel({
      this.success, 
      this.message, 
      this.data,});

  NotificationsModel.fromJson(dynamic json) {
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

/// notifications : [{"_id":"69fe540565ff7785a0313170","userId":"69f3df915f42685cbbbcbb18","type":"emergency","title":"Emergency blood request near you","message":"A hospital near you needs O+ blood for an urgent request. Tap to view details.","read":false,"relatedId":"69fe540565ff7785a031314f","relatedType":"Request","data":{"requestId":"69fe540565ff7785a031314f","hospitalName":"Cairo Care Hospital","requestType":"blood"},"createdAt":"2026-05-16T13:24:00.000Z","updatedAt":"2026-05-16T13:24:00.000Z"}]
/// unreadCount : 3
/// pagination : {"page":1,"limit":20,"total":42,"pages":3}

class Data {
  Data({
      this.notifications, 
      this.unreadCount, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
    unreadCount = json['unreadCount'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Notifications>? notifications;
  int? unreadCount;
  Pagination? pagination;

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

/// page : 1
/// limit : 20
/// total : 42
/// pages : 3

class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
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

/// _id : "69fe540565ff7785a0313170"
/// userId : "69f3df915f42685cbbbcbb18"
/// type : "emergency"
/// title : "Emergency blood request near you"
/// message : "A hospital near you needs O+ blood for an urgent request. Tap to view details."
/// read : false
/// relatedId : "69fe540565ff7785a031314f"
/// relatedType : "Request"
/// data : {"requestId":"69fe540565ff7785a031314f","hospitalName":"Cairo Care Hospital","requestType":"blood"}
/// createdAt : "2026-05-16T13:24:00.000Z"
/// updatedAt : "2026-05-16T13:24:00.000Z"

class Notifications {
  Notifications({
      this.id, 
      this.userId, 
      this.type, 
      this.title, 
      this.message, 
      this.read, 
      this.relatedId, 
      this.relatedType, 
      this.data, 
      this.createdAt, 
      this.updatedAt,});

  Notifications.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    read = json['read'];
    relatedId = json['relatedId'];
    relatedType = json['relatedType'];
    data = json['data'] != null ? NotificationData .fromJson(json['data']) : null;
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
  NotificationData ? data;
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
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// requestId : "69fe540565ff7785a031314f"
/// hospitalName : "Cairo Care Hospital"
/// requestType : "blood"

class NotificationData  {
  NotificationData ({
      this.requestId, 
      this.hospitalName, 
      this.requestType,});

  NotificationData .fromJson(dynamic json) {
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