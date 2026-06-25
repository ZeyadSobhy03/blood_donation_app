class HomeActivityModel {
  HomeActivityModel({this.success, this.message, this.data});

  HomeActivityModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeActivityData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeActivityData? data;
}

class HomeActivityData {
  HomeActivityData({this.activities});

  HomeActivityData.fromJson(dynamic json) {
    if (json['activities'] is List) {
      activities = (json['activities'] as List)
          .map((e) => ActivityItem.fromJson(e))
          .toList();
    }
  }

  List<ActivityItem>? activities;
}

class ActivityItem {
  ActivityItem({
    this.type,
    this.title,
    this.subtitle,
    this.status,
    this.timestamp,
    this.donorPhone,
  });

  ActivityItem.fromJson(dynamic json) {
    type      = json['type'];
    title     = json['title'];
    subtitle  = json['subtitle'];
    status    = json['status'];
    timestamp = json['timestamp'] != null
        ? DateTime.tryParse(json['timestamp'])
        : null;
    donorPhone = json['donorPhone'];
  }

  String? type;
  String? title;
  String? subtitle;
  String? status;
  DateTime? timestamp;
  String? donorPhone;
}
