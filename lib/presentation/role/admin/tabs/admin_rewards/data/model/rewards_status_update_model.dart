/// success : true
/// message : "Reward status updated successfully"
/// data : {"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","status":"INACTIVE"}

class RewardsStatusUpdateModel {
  RewardsStatusUpdateModel({
      this.success, 
      this.message, 
      this.data,});

  RewardsStatusUpdateModel.fromJson(dynamic json) {
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

/// id : "664a123456789abcdef12345"
/// rewardName : "Coffee Voucher"
/// status : "INACTIVE"

class Data {
  Data({
      this.id, 
      this.rewardName, 
      this.status,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    rewardName = json['rewardName'];
    status = json['status'];
  }
  String? id;
  String? rewardName;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardName'] = rewardName;
    map['status'] = status;
    return map;
  }

}