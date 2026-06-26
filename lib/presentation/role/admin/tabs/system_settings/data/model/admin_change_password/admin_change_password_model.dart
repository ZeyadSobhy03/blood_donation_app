/// success : true
/// data : "Password changed successfully"

class AdminChangePasswordModel {
  AdminChangePasswordModel({
    this.success,
    this.data,});

  AdminChangePasswordModel.fromJson(dynamic json) {
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