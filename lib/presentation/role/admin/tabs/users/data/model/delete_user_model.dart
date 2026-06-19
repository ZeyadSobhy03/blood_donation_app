/// success : true
/// message : "User deleted successfully"

class DeleteUserModel {
  DeleteUserModel({
      this.success, 
      this.message,});

  DeleteUserModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}