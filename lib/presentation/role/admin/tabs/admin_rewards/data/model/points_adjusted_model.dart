/// success : true
/// message : "Points adjusted successfully"
/// data : {"email":"donor@example.com","newBalance":1450}

class PointsAdjustedModel {
  PointsAdjustedModel({
      this.success, 
      this.message, 
      this.data,});

  PointsAdjustedModel.fromJson(dynamic json) {
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

/// email : "donor@example.com"
/// newBalance : 1450

class Data {
  Data({
      this.email, 
      this.newBalance,});

  Data.fromJson(dynamic json) {
    email = json['email'];
    newBalance = json['newBalance'];
  }
  String? email;
  int? newBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['newBalance'] = newBalance;
    return map;
  }

}