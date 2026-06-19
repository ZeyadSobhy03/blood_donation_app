/// success : true
/// message : "Request cancelled"
/// data : {"request":{"_id":"69fe540565ff7785a0313150","status":"cancelled","notes":"Transferred to another hospital\n[Admin cancelled]: Transferred to another hospital"}}

class AdminRequestCancel {
  AdminRequestCancel({
      this.success, 
      this.message, 
      this.data,});

  AdminRequestCancel.fromJson(dynamic json) {
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

/// request : {"_id":"69fe540565ff7785a0313150","status":"cancelled","notes":"Transferred to another hospital\n[Admin cancelled]: Transferred to another hospital"}

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

/// _id : "69fe540565ff7785a0313150"
/// status : "cancelled"
/// notes : "Transferred to another hospital\n[Admin cancelled]: Transferred to another hospital"

class Request {
  Request({
      this.id, 
      this.status, 
      this.notes,});

  Request.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    notes = json['notes'];
  }
  String? id;
  String? status;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['notes'] = notes;
    return map;
  }

}