/// success : true
/// message : "Request cancelled successfully"
/// data : {"requestId":"69fe540565ff7785a031314f","status":"cancelled"}

class RequestCancelModel {
  RequestCancelModel({
      this.success, 
      this.message, 
      this.data,});

  RequestCancelModel.fromJson(dynamic json) {
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

/// requestId : "69fe540565ff7785a031314f"
/// status : "cancelled"

class Data {
  Data({
      this.requestId, 
      this.status,});

  Data.fromJson(dynamic json) {
    requestId = json['requestId'];
    status = json['status'];
  }
  String? requestId;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['status'] = status;
    return map;
  }

}