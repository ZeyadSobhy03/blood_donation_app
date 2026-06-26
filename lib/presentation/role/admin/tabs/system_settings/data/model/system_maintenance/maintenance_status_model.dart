/// success : true
/// message : "Maintenance status"
/// data : {"enabled":false,"message":"Demo mode active"}

class MaintenanceStatusModel {
  MaintenanceStatusModel({
      this.success, 
      this.message, 
      this.data,});

  MaintenanceStatusModel.fromJson(dynamic json) {
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

/// enabled : false
/// message : "Demo mode active"

class Data {
  Data({
      this.enabled, 
      this.message,});

  Data.fromJson(dynamic json) {
    enabled = json['enabled'];
    message = json['message'];
  }
  bool? enabled;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    map['message'] = message;
    return map;
  }

}