/// success : true
/// data : {"pointsBalance":350,"lifetimePointsEarned":950,"currentTier":"bronze","nextTier":"silver","pointsToNextTier":50,"tierBenefits":{"bronze":["Access to basic rewards"],"silver":["10% more points per donation","Early access to limited rewards"],"gold":["15% more points per donation","Exclusive gold rewards"],"platinum":["20% more points per donation","VIP support","All exclusive rewards"]}}

class PointsModel {
  PointsModel({
      this.success, 
      this.data,});

  PointsModel.fromJson(dynamic json) {
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

/// pointsBalance : 350
/// lifetimePointsEarned : 950
/// currentTier : "bronze"
/// nextTier : "silver"
/// pointsToNextTier : 50
/// tierBenefits : {"bronze":["Access to basic rewards"],"silver":["10% more points per donation","Early access to limited rewards"],"gold":["15% more points per donation","Exclusive gold rewards"],"platinum":["20% more points per donation","VIP support","All exclusive rewards"]}

class Data {
  Data({
      this.pointsBalance, 
      this.lifetimePointsEarned, 
      this.currentTier, 
      this.nextTier, 
      this.pointsToNextTier, 
      this.tierBenefits,});

  Data.fromJson(dynamic json) {
    pointsBalance = json['pointsBalance'];
    lifetimePointsEarned = json['lifetimePointsEarned'];
    currentTier = json['currentTier'];
    nextTier = json['nextTier'];
    pointsToNextTier = json['pointsToNextTier'];
    tierBenefits = json['tierBenefits'] != null ? TierBenefits.fromJson(json['tierBenefits']) : null;
  }
  int? pointsBalance;
  int? lifetimePointsEarned;
  String? currentTier;
  String? nextTier;
  int? pointsToNextTier;
  TierBenefits? tierBenefits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pointsBalance'] = pointsBalance;
    map['lifetimePointsEarned'] = lifetimePointsEarned;
    map['currentTier'] = currentTier;
    map['nextTier'] = nextTier;
    map['pointsToNextTier'] = pointsToNextTier;
    if (tierBenefits != null) {
      map['tierBenefits'] = tierBenefits?.toJson();
    }
    return map;
  }

}

/// bronze : ["Access to basic rewards"]
/// silver : ["10% more points per donation","Early access to limited rewards"]
/// gold : ["15% more points per donation","Exclusive gold rewards"]
/// platinum : ["20% more points per donation","VIP support","All exclusive rewards"]

class TierBenefits {
  TierBenefits({
      this.bronze, 
      this.silver, 
      this.gold, 
      this.platinum,});

  TierBenefits.fromJson(dynamic json) {
    bronze = json['bronze'] != null ? json['bronze'].cast<String>() : [];
    silver = json['silver'] != null ? json['silver'].cast<String>() : [];
    gold = json['gold'] != null ? json['gold'].cast<String>() : [];
    platinum = json['platinum'] != null ? json['platinum'].cast<String>() : [];
  }
  List<String>? bronze;
  List<String>? silver;
  List<String>? gold;
  List<String>? platinum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bronze'] = bronze;
    map['silver'] = silver;
    map['gold'] = gold;
    map['platinum'] = platinum;
    return map;
  }

}