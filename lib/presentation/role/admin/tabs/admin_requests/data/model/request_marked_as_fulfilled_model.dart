/// success : true
/// message : "Request marked as fulfilled"
/// data : {"request":{"_id":"69fe540565ff7785a031314f","status":"completed","bloodType":["O-","A+"],"urgency":"critical","updatedAt":"2026-05-18T09:28:00.000Z"}}

class RequestMarkedAsFulfilledModel {
  RequestMarkedAsFulfilledModel({
      this.success, 
      this.message, 
      this.data,});

  RequestMarkedAsFulfilledModel.fromJson(dynamic json) {
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

/// request : {"_id":"69fe540565ff7785a031314f","status":"completed","bloodType":["O-","A+"],"urgency":"critical","updatedAt":"2026-05-18T09:28:00.000Z"}

class Data {
  Data({
      this.request,});

  Data.fromJson(dynamic json) {
    request = json['request'] != null ? Request.fromJson(json['request']) : null;
  }
  Request? request;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (request != null) {
      map['request'] = request?.toJson();
    }
    return map;
  }

}

/// _id : "69fe540565ff7785a031314f"
/// status : "completed"
/// bloodType : ["O-","A+"]
/// urgency : "critical"
/// updatedAt : "2026-05-18T09:28:00.000Z"

class Request {
  Request({
      this.id, 
      this.status, 
      this.bloodType, 
      this.urgency, 
      this.updatedAt,});

  Request.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    bloodType = json['bloodType'] != null ? json['bloodType'].cast<String>() : [];
    urgency = json['urgency'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? status;
  List<String>? bloodType;
  String? urgency;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['bloodType'] = bloodType;
    map['urgency'] = urgency;
    map['updatedAt'] = updatedAt;
    return map;
  }

}