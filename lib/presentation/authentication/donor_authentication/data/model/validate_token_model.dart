/// success : true
/// message : "Token is valid"
/// data : {"is_valid":true,"user_role":"donor","user_id":"6a130e810b339a45a51addb2","role":"donor","userId":"6a130e810b339a45a51addb2"}

class ValidateTokenModel {
  ValidateTokenModel({
      this.success, 
      this.message, 
      this.data,});

  ValidateTokenModel.fromJson(dynamic json) {
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

/// is_valid : true
/// user_role : "donor"
/// user_id : "6a130e810b339a45a51addb2"
/// role : "donor"
/// userId : "6a130e810b339a45a51addb2"

class Data {
  Data({
      this.isValid, 
      this.userRole, 
      this.userId, 
      this.role, 
      });

  Data.fromJson(dynamic json) {
    isValid = json['is_valid'];
    userRole = json['user_role'];
    userId = json['user_id'];
    role = json['role'];
    userId = json['userId'];
  }
  bool? isValid;
  String? userRole;
  String? userId;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_valid'] = isValid;
    map['user_role'] = userRole;
    map['user_id'] = userId;
    map['role'] = role;
    map['userId'] = userId;
    return map;
  }

}