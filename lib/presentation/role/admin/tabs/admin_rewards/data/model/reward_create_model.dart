/// success : true
/// message : "Reward created successfully"
/// data : {"id":"664a123456789abcdef12347","rewardName":"Coffee Voucher","category":"FOOD","pointsRequired":500,"redeemedCount":0,"status":"ACTIVE"}

class RewardCreateModel {
  RewardCreateModel({
      this.success, 
      this.message, 
      this.data,});

  RewardCreateModel.fromJson(dynamic json) {
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

/// id : "664a123456789abcdef12347"
/// rewardName : "Coffee Voucher"
/// category : "FOOD"
/// pointsRequired : 500
/// redeemedCount : 0
/// status : "ACTIVE"

class Data {
  Data({
      this.id, 
      this.rewardName, 
      this.category, 
      this.pointsRequired, 
      this.redeemedCount, 
      this.status,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    rewardName = json['rewardName'];
    category = json['category'];
    pointsRequired = json['pointsRequired'];
    redeemedCount = json['redeemedCount'];
    status = json['status'];
  }
  String? id;
  String? rewardName;
  String? category;
  int? pointsRequired;
  int? redeemedCount;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardName'] = rewardName;
    map['category'] = category;
    map['pointsRequired'] = pointsRequired;
    map['redeemedCount'] = redeemedCount;
    map['status'] = status;
    return map;
  }

}