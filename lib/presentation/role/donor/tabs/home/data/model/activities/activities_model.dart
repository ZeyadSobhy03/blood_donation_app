/// success : true
/// data : {"activities":[{"id":"69fe540765ff7785a031316b","title":"Blood Donation Completed","hospital":"Cairo Care Hospital","points":200,"createdAt":"2026-05-08T21:22:16.519Z","relativeTime":"2 days ago","type":"donation","status":"success","icon":"heart"},{"id":"69fde7d0d6844d06c2b258c7","title":"Blood Donation Completed","hospital":"Cairo Care Hospital","points":200,"createdAt":"2026-05-08T13:40:33.327Z","relativeTime":"3 days ago","type":"donation","status":"success","icon":"heart"}],"pagination":{"total":2,"page":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class ActivitiesModel {
  ActivitiesModel({
      this.success, 
      this.data,});

  ActivitiesModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// activities : [{"id":"69fe540765ff7785a031316b","title":"Blood Donation Completed","hospital":"Cairo Care Hospital","points":200,"createdAt":"2026-05-08T21:22:16.519Z","relativeTime":"2 days ago","type":"donation","status":"success","icon":"heart"},{"id":"69fde7d0d6844d06c2b258c7","title":"Blood Donation Completed","hospital":"Cairo Care Hospital","points":200,"createdAt":"2026-05-08T13:40:33.327Z","relativeTime":"3 days ago","type":"donation","status":"success","icon":"heart"}]
/// pagination : {"total":2,"page":1,"limit":10,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

class Data {
  Data({
      this.activities, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities?.add(Activities.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Activities>? activities;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (activities != null) {
      map['activities'] = activities?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 2
/// page : 1
/// limit : 10
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

/// id : "69fe540765ff7785a031316b"
/// title : "Blood Donation Completed"
/// hospital : "Cairo Care Hospital"
/// points : 200
/// createdAt : "2026-05-08T21:22:16.519Z"
/// relativeTime : "2 days ago"
/// type : "donation"
/// status : "success"
/// icon : "heart"

class Activities {
  Activities({
      this.id, 
      this.title, 
      this.hospital, 
      this.points, 
      this.createdAt, 
      this.relativeTime, 
      this.type, 
      this.status, 
      this.icon,});

  Activities.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    hospital = json['hospital'];
    points = json['points'];
    createdAt = json['createdAt'];
    relativeTime = json['relativeTime'];
    type = json['type'];
    status = json['status'];
    icon = json['icon'];
  }
  String? id;
  String? title;
  String? hospital;
  int? points;
  String? createdAt;
  String? relativeTime;
  String? type;
  String? status;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['hospital'] = hospital;
    map['points'] = points;
    map['createdAt'] = createdAt;
    map['relativeTime'] = relativeTime;
    map['type'] = type;
    map['status'] = status;
    map['icon'] = icon;
    return map;
  }

}