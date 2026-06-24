/// success : true
/// message : "Donor updated successfully"
/// data : {"user":{"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","bloodType":"O+","phoneNumber":"01011111111","updatedAt":"2026-05-18T09:05:00.000Z"}}

class AdminUpdateDonorModel {
  AdminUpdateDonorModel({
      this.success, 
      this.message, 
      this.data,});

  AdminUpdateDonorModel.fromJson(dynamic json) {
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

/// user : {"_id":"69f3df915f42685cbbbcbb18","fullName":"Aya Hassan","email":"aya.hassan@lifelink.demo","role":"donor","bloodType":"O+","phoneNumber":"01011111111","updatedAt":"2026-05-18T09:05:00.000Z"}

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
/// email : "aya.hassan@lifelink.demo"
/// role : "donor"
/// bloodType : "O+"
/// phoneNumber : "01011111111"
/// updatedAt : "2026-05-18T09:05:00.000Z"

class User {
  User({
      this.id, 
      this.fullName, 
      this.email, 
      this.role, 
      this.bloodType, 
      this.phoneNumber, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    bloodType = json['bloodType'];
    phoneNumber = json['phoneNumber'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? bloodType;
  String? phoneNumber;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['role'] = role;
    map['bloodType'] = bloodType;
    map['phoneNumber'] = phoneNumber;
    map['updatedAt'] = updatedAt;
    return map;
  }

}