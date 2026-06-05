/// success : true
/// data : "Password changed successfully"

class ChangePasswordModel {
  ChangePasswordModel({
      this.success, 
      this.data,});

  ChangePasswordModel.fromJson(dynamic json) {
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