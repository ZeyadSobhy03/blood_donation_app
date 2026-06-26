/// success : true
/// message : "Maintenance mode updated"
/// data : {"maintenanceMode":false,"message":"Demo mode active"}

class SystemMaintenanceModel {
  SystemMaintenanceModel({
      this.success, 
      this.message, 
      this.data,});

  SystemMaintenanceModel.fromJson(dynamic json) {
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

/// maintenanceMode : false
/// message : "Demo mode active"

class Data {
  Data({
      this.maintenanceMode, 
      this.message,});

  Data.fromJson(dynamic json) {
    maintenanceMode = json['maintenanceMode'];
    message = json['message'];
  }
  bool? maintenanceMode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maintenanceMode'] = maintenanceMode;
    map['message'] = message;
    return map;
  }

}