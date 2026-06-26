/// success : true
/// message : "Broadcast sent"
/// data : {"donorsNotified":9,"pushTokenCount":0,"governorate":"South Sinai","bloodType":["O+","A+","O-","B-","AB-"],"bloodTypeLabel":"O+, A+, O-, B-, AB-","radiusKm":60}

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

/// donorsNotified : 9
/// pushTokenCount : 0
/// governorate : "South Sinai"
/// bloodType : ["O+","A+","O-","B-","AB-"]
/// bloodTypeLabel : "O+, A+, O-, B-, AB-"
/// radiusKm : 60

class Data {
  Data({
      this.donorsNotified, 
      this.pushTokenCount, 
      this.governorate, 
      this.bloodType, 
      this.bloodTypeLabel, 
      this.radiusKm,});

  Data.fromJson(dynamic json) {
    donorsNotified = json['donorsNotified'];
    pushTokenCount = json['pushTokenCount'];
    governorate = json['governorate'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    bloodTypeLabel = json['bloodTypeLabel'];
    radiusKm = json['radiusKm'];
  }
  int? donorsNotified;
  int? pushTokenCount;
  String? governorate;
  List<String>? bloodType;
  String? bloodTypeLabel;
  int? radiusKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donorsNotified'] = donorsNotified;
    map['pushTokenCount'] = pushTokenCount;
    map['governorate'] = governorate;
    map['bloodType'] = bloodType;
    map['bloodTypeLabel'] = bloodTypeLabel;
    map['radiusKm'] = radiusKm;
    return map;
  }

}