/// success : true
/// data : {"modifiedCount":1}

class NotificationAllReadModel {
  NotificationAllReadModel({
      this.success, 
      this.data,});

  NotificationAllReadModel.fromJson(dynamic json) {
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

/// modifiedCount : 1

class Data {
  Data({
      this.modifiedCount,});

  Data.fromJson(dynamic json) {
    modifiedCount = json['modifiedCount'];
  }
  int? modifiedCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['modifiedCount'] = modifiedCount;
    return map;
  }

}