/// success : true
/// data : "Password reset email sent"

class ForgetPasswordModel {
  ForgetPasswordModel({
      this.success, 
      this.data,});

  ForgetPasswordModel.fromJson(dynamic json) {
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