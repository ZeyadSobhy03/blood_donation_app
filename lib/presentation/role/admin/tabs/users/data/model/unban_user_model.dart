/// success : true
/// message : "User unbanned successfully"
/// data : {"user":{"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","role":"donor","isSuspended":false,"suspendedReason":null,"suspendedAt":null}}

class UnbanUserModel {
  UnbanUserModel({
      this.success, 
      this.message, 
      this.data,});

  UnbanUserModel.fromJson(dynamic json) {
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

/// user : {"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","role":"donor","isSuspended":false,"suspendedReason":null,"suspendedAt":null}

class Data {
  Data({
      this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// _id : "69f3df915f42685cbbbcbb18"
/// fullName : "Aya Hassan"
/// role : "donor"
/// isSuspended : false
/// suspendedReason : null
/// suspendedAt : null

class User {
  User({
      this.id, 
      this.fullName, 
      this.role, 
      this.isSuspended, 
      this.suspendedReason, 
      this.suspendedAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    role = json['role'];
    isSuspended = json['isSuspended'];
    suspendedReason = json['suspendedReason'];
    suspendedAt = json['suspendedAt'];
  }
  String? id;
  String? fullName;
  String? role;
  bool? isSuspended;
  dynamic suspendedReason;
  dynamic suspendedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['role'] = role;
    map['isSuspended'] = isSuspended;
    map['suspendedReason'] = suspendedReason;
    map['suspendedAt'] = suspendedAt;
    return map;
  }

}