/// success : true
/// message : "System health"
/// data : {"status":"healthy","uptime":"0d 0h 27m","lastChecked":"2026-06-25T23:27:15.363Z","services":{"database":"online"},"memory":"36MB / 40MB","nodeVersion":"v24.14.1","platform":"linux"}

class SystemHealthModel {
  SystemHealthModel({this.success, this.message, this.data});

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
/// uptime : "0d 0h 27m"
/// lastChecked : "2026-06-25T23:27:15.363Z"
/// services : {"database":"online"}
/// memory : "36MB / 40MB"
/// nodeVersion : "v24.14.1"
/// platform : "linux"

class Data {
  Data({
    this.status,
    this.uptime,
    this.lastChecked,
    this.services,
    this.memory,
    this.nodeVersion,
    this.platform,
  });

  Data.fromJson(dynamic json) {
    status = json['status'];
    uptime = json['uptime'];
    lastChecked = json['lastChecked'];
    services = json['services'] != null
        ? Services.fromJson(json['services'])
        : null;
    memory = json['memory'];
    nodeVersion = json['nodeVersion'];
    platform = json['platform'];
  }
  String? status;
  String? uptime;
  String? lastChecked;
  Services? services;
  String? memory;
  String? nodeVersion;
  String? platform;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['uptime'] = uptime;
    map['lastChecked'] = lastChecked;
    if (services != null) {
      map['services'] = services?.toJson();
    }
    map['memory'] = memory;
    map['nodeVersion'] = nodeVersion;
    map['platform'] = platform;
    return map;
  }
}

/// database : "online"

class Services {
  Services({this.database});

  Services.fromJson(dynamic json) {
    database = json['database'];
  }
  String? database;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['database'] = database;
    return map;
  }
}
