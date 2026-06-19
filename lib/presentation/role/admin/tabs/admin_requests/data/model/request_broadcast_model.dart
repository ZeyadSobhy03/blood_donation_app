/// success : true
/// message : "Broadcast sent"
/// data : {"donorsNotified":14,"pushTokenCount":11,"governorate":"Cairo","bloodType":"O-"}

class RequestBroadcastModel {
  RequestBroadcastModel({
      this.success, 
      this.message, 
      this.data,});

  RequestBroadcastModel.fromJson(dynamic json) {
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

/// donorsNotified : 14
/// pushTokenCount : 11
/// governorate : "Cairo"
/// bloodType : "O-"

class Data {
  Data({
      this.donorsNotified, 
      this.pushTokenCount, 
      this.governorate, 
      this.bloodType,});

  Data.fromJson(dynamic json) {
    donorsNotified = json['donorsNotified'];
    pushTokenCount = json['pushTokenCount'];
    governorate = json['governorate'];
    bloodType = json['bloodType'];
  }
  int? donorsNotified;
  int? pushTokenCount;
  String? governorate;
  String? bloodType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donorsNotified'] = donorsNotified;
    map['pushTokenCount'] = pushTokenCount;
    map['governorate'] = governorate;
    map['bloodType'] = bloodType;
    return map;
  }

}