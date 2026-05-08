/// success : true
/// data : "Verification code sent"

class VerifyEmailModel {
  VerifyEmailModel({
      this.success, 
      this.data,});

  VerifyEmailModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
  }
  bool? success;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    return map;
  }

}