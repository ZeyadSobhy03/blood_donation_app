/// success : true
/// message : "Audit logs"
/// data : {"logs":[{"_id":"log_001","adminId":"66f200000000000000000001","adminName":"admin@lifelink.com","action":"Hospital Added","targetId":"60d5ec49f0322c2c20e28f36","targetType":"user","details":"Suspended user michael@gmail.com for policy violation","createdAt":"2026-06-12T10:00:00.000Z"}],"pagination":{"page":1,"limit":20,"total":1,"totalPages":1}}

class AuditLogsModel {
  AuditLogsModel({
      this.success, 
      this.message, 
      this.data,});

  AuditLogsModel.fromJson(dynamic json) {
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

/// logs : [{"_id":"log_001","adminId":"66f200000000000000000001","adminName":"admin@lifelink.com","action":"Hospital Added","targetId":"60d5ec49f0322c2c20e28f36","targetType":"user","details":"Suspended user michael@gmail.com for policy violation","createdAt":"2026-06-12T10:00:00.000Z"}]
/// pagination : {"page":1,"limit":20,"total":1,"totalPages":1}

class Data {
  Data({
      this.logs, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['logs'] != null) {
      logs = [];
      json['logs'].forEach((v) {
        logs?.add(Logs.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Logs>? logs;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (logs != null) {
      map['logs'] = logs?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// page : 1
/// limit : 20
/// total : 1
/// totalPages : 1

class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total, 
      this.totalPages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }

}

/// _id : "log_001"
/// adminId : "66f200000000000000000001"
/// adminName : "admin@lifelink.com"
/// action : "Hospital Added"
/// targetId : "60d5ec49f0322c2c20e28f36"
/// targetType : "user"
/// details : "Suspended user michael@gmail.com for policy violation"
/// createdAt : "2026-06-12T10:00:00.000Z"

class Logs {
  Logs({
      this.id, 
      this.adminId, 
      this.adminName, 
      this.action, 
      this.targetId, 
      this.targetType, 
      this.details, 
      this.createdAt,});

  Logs.fromJson(dynamic json) {
    id = json['_id'];
    adminId = json['adminId'];
    adminName = json['adminName'];
    action = json['action'];
    targetId = json['targetId'];
    targetType = json['targetType'];
    details = json['details'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? adminId;
  String? adminName;
  String? action;
  String? targetId;
  String? targetType;
  String? details;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['adminId'] = adminId;
    map['adminName'] = adminName;
    map['action'] = action;
    map['targetId'] = targetId;
    map['targetType'] = targetType;
    map['details'] = details;
    map['createdAt'] = createdAt;
    return map;
  }

}