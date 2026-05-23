/// success : true
/// data : {"redemptionId":"6a0208c4927870ffe66837f9","confirmationCode":"RWD-2026-2BD897","rewardName":"Coffee Voucher","pointsSpent":500,"remainingPoints":350,"redemptionStatus":"CONFIRMED","expiresAt":"2026-06-10T16:50:12.734Z"}

class RedeemReward {
  RedeemReward({
      this.success, 
      this.data,});

  RedeemReward.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// redemptionId : "6a0208c4927870ffe66837f9"
/// confirmationCode : "RWD-2026-2BD897"
/// rewardName : "Coffee Voucher"
/// pointsSpent : 500
/// remainingPoints : 350
/// redemptionStatus : "CONFIRMED"
/// expiresAt : "2026-06-10T16:50:12.734Z"

class Data {
  Data({
      this.redemptionId, 
      this.confirmationCode, 
      this.rewardName, 
      this.pointsSpent, 
      this.remainingPoints, 
      this.redemptionStatus, 
      this.expiresAt,});

  Data.fromJson(dynamic json) {
    redemptionId = json['redemptionId'];
    confirmationCode = json['confirmationCode'];
    rewardName = json['rewardName'];
    pointsSpent = json['pointsSpent'];
    remainingPoints = json['remainingPoints'];
    redemptionStatus = json['redemptionStatus'];
    expiresAt = json['expiresAt'];
  }
  String? redemptionId;
  String? confirmationCode;
  String? rewardName;
  int? pointsSpent;
  int? remainingPoints;
  String? redemptionStatus;
  String? expiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redemptionId'] = redemptionId;
    map['confirmationCode'] = confirmationCode;
    map['rewardName'] = rewardName;
    map['pointsSpent'] = pointsSpent;
    map['remainingPoints'] = remainingPoints;
    map['redemptionStatus'] = redemptionStatus;
    map['expiresAt'] = expiresAt;
    return map;
  }

}