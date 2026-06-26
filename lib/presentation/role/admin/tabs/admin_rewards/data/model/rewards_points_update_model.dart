/// success : true
/// message : "Reward points updated successfully"
/// data : {"updated":[{"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","pointsRequired":600},{"id":"664a123456789abcdef12346","rewardName":"Movie Tickets","pointsRequired":1100}]}

class RewardsPointsUpdateModel {
  RewardsPointsUpdateModel({
      this.success, 
      this.message, 
      this.data,});

  RewardsPointsUpdateModel.fromJson(dynamic json) {
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

/// updated : [{"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","pointsRequired":600},{"id":"664a123456789abcdef12346","rewardName":"Movie Tickets","pointsRequired":1100}]

class Data {
  Data({
      this.updated,});

  Data.fromJson(dynamic json) {
    if (json['updated'] != null) {
      updated = [];
      json['updated'].forEach((v) {
        updated?.add(Updated.fromJson(v));
      });
    }
  }
  List<Updated>? updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (updated != null) {
      map['updated'] = updated?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "664a123456789abcdef12345"
/// rewardName : "Coffee Voucher"
/// pointsRequired : 600

class Updated {
  Updated({
      this.id, 
      this.rewardName, 
      this.pointsRequired,});

  Updated.fromJson(dynamic json) {
    id = json['id'];
    rewardName = json['rewardName'];
    pointsRequired = json['pointsRequired'];
  }
  String? id;
  String? rewardName;
  int? pointsRequired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rewardName'] = rewardName;
    map['pointsRequired'] = pointsRequired;
    return map;
  }

}