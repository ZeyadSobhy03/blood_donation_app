/// success : true
/// message : "Password reset OTP verified successfully"
/// data : {"verified":true,"email":"aya.hassan@lifelink.demo","otp":"123456"}

class VerifyOtpModel {
  VerifyOtpModel({
      this.success, 
      this.message, 
      this.data,});

  VerifyOtpModel.fromJson(dynamic json) {
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

/// verified : true
/// email : "aya.hassan@lifelink.demo"
/// otp : "123456"

class Data {
  Data({
      this.verified, 
      this.email, 
      this.otp,});

  Data.fromJson(dynamic json) {
    verified = json['verified'];
    email = json['email'];
    otp = json['otp'];
  }
  bool? verified;
  String? email;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verified'] = verified;
    map['email'] = email;
    map['otp'] = otp;
    return map;
  }

}