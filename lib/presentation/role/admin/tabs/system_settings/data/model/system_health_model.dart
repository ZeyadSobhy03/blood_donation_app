/// success : true
/// message : "System health"
/// data : {"status":"healthy","uptime":86423.51,"database":"connected","memory":{"used":"96 MB","total":"128 MB"},"timestamp":"2026-05-18T09:15:00.000Z"}

class SystemHealthModel {
  SystemHealthModel({
      this.success, 
      this.message, 
      this.data,});

  SystemHealthModel.fromJson(dynamic json) {
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

/// status : "healthy"
/// uptime : 86423.51
/// database : "connected"
/// memory : {"used":"96 MB","total":"128 MB"}
/// timestamp : "2026-05-18T09:15:00.000Z"

class Data {
  Data({
      this.status, 
      this.uptime, 
      this.database, 
      this.memory, 
      this.timestamp,});

  Data.fromJson(dynamic json) {
    status = json['status'];
    uptime = json['uptime'];
    database = json['database'];
    memory = json['memory'] != null ? Memory.fromJson(json['memory']) : null;
    timestamp = json['timestamp'];
  }
  String? status;
  double? uptime;
  String? database;
  Memory? memory;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['uptime'] = uptime;
    map['database'] = database;
    if (memory != null) {
      map['memory'] = memory?.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }

}

/// used : "96 MB"
/// total : "128 MB"

class Memory {
  Memory({
      this.used, 
      this.total,});

  Memory.fromJson(dynamic json) {
    used = json['used'];
    total = json['total'];
  }
  String? used;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['used'] = used;
    map['total'] = total;
    return map;
  }

}