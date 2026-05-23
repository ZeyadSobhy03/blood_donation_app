/// success : true
/// data : {"unlockedCount":0,"totalCount":7,"completionPercentage":0,"badges":[{"badgeId":"69f26027dc1ddc888014fcf2","badgeName":"First Timer","badgeDescription":"Completed your first blood donation","badgeIcon":"heart","category":"DONATION","rarity":"COMMON","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":1,"progressPercentage":0},{"badgeId":"69f26027dc1ddc888014fcf3","badgeName":"Regular Donor","badgeDescription":"Completed 5 blood donations","badgeIcon":"trophy","category":"DONATION","rarity":"COMMON","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":5,"progressPercentage":0},{"badgeId":"69f26027dc1ddc888014fcf4","badgeName":"Life Saver","badgeDescription":"Completed 10 blood donations","badgeIcon":"star","category":"DONATION","rarity":"RARE","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":10,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf5","badgeName":"Hero","badgeDescription":"Completed 20 blood donations","badgeIcon":"badge","category":"DONATION","rarity":"EPIC","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":20,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf6","badgeName":"Legend","badgeDescription":"Completed 50 blood donations","badgeIcon":"crown","category":"DONATION","rarity":"LEGENDARY","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":50,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf7","badgeName":"Emergency Responder","badgeDescription":"Responded to 10 emergency requests","badgeIcon":"flash","category":"EMERGENCY","rarity":"EPIC","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":10,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf8","badgeName":"Community Helper","badgeDescription":"Responded to 25 emergency requests","badgeIcon":"shield","category":"EMERGENCY","rarity":"LEGENDARY","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":25,"progressPercentage":0}],"stats":{"totalDonations":0,"totalEmergencyResponses":0,"daysAsDonor":0}}

class BadgesModel {
  BadgesModel({
      this.success, 
      this.data,});

  BadgesModel.fromJson(dynamic json) {
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

/// unlockedCount : 0
/// totalCount : 7
/// completionPercentage : 0
/// badges : [{"badgeId":"69f26027dc1ddc888014fcf2","badgeName":"First Timer","badgeDescription":"Completed your first blood donation","badgeIcon":"heart","category":"DONATION","rarity":"COMMON","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":1,"progressPercentage":0},{"badgeId":"69f26027dc1ddc888014fcf3","badgeName":"Regular Donor","badgeDescription":"Completed 5 blood donations","badgeIcon":"trophy","category":"DONATION","rarity":"COMMON","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":5,"progressPercentage":0},{"badgeId":"69f26027dc1ddc888014fcf4","badgeName":"Life Saver","badgeDescription":"Completed 10 blood donations","badgeIcon":"star","category":"DONATION","rarity":"RARE","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":10,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf5","badgeName":"Hero","badgeDescription":"Completed 20 blood donations","badgeIcon":"badge","category":"DONATION","rarity":"EPIC","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":20,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf6","badgeName":"Legend","badgeDescription":"Completed 50 blood donations","badgeIcon":"crown","category":"DONATION","rarity":"LEGENDARY","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":50,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf7","badgeName":"Emergency Responder","badgeDescription":"Responded to 10 emergency requests","badgeIcon":"flash","category":"EMERGENCY","rarity":"EPIC","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":10,"progressPercentage":0},{"badgeId":"69f26028dc1ddc888014fcf8","badgeName":"Community Helper","badgeDescription":"Responded to 25 emergency requests","badgeIcon":"shield","category":"EMERGENCY","rarity":"LEGENDARY","unlockStatus":"LOCKED","unlockedAt":null,"progressCurrent":0,"progressTarget":25,"progressPercentage":0}]
/// stats : {"totalDonations":0,"totalEmergencyResponses":0,"daysAsDonor":0}

class Data {
  Data({
      this.unlockedCount, 
      this.totalCount, 
      this.completionPercentage, 
      this.badges, 
      this.stats,});

  Data.fromJson(dynamic json) {
    unlockedCount = json['unlockedCount'];
    totalCount = json['totalCount'];
    completionPercentage = json['completionPercentage'];
    if (json['badges'] != null) {
      badges = [];
      json['badges'].forEach((v) {
        badges?.add(Badges.fromJson(v));
      });
    }
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }
  int? unlockedCount;
  int? totalCount;
  int? completionPercentage;
  List<Badges>? badges;
  Stats? stats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unlockedCount'] = unlockedCount;
    map['totalCount'] = totalCount;
    map['completionPercentage'] = completionPercentage;
    if (badges != null) {
      map['badges'] = badges?.map((v) => v.toJson()).toList();
    }
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    return map;
  }

}

/// totalDonations : 0
/// totalEmergencyResponses : 0
/// daysAsDonor : 0

class Stats {
  Stats({
      this.totalDonations, 
      this.totalEmergencyResponses, 
      this.daysAsDonor,});

  Stats.fromJson(dynamic json) {
    totalDonations = json['totalDonations'];
    totalEmergencyResponses = json['totalEmergencyResponses'];
    daysAsDonor = json['daysAsDonor'];
  }
  int? totalDonations;
  int? totalEmergencyResponses;
  int? daysAsDonor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalDonations'] = totalDonations;
    map['totalEmergencyResponses'] = totalEmergencyResponses;
    map['daysAsDonor'] = daysAsDonor;
    return map;
  }

}

/// badgeId : "69f26027dc1ddc888014fcf2"
/// badgeName : "First Timer"
/// badgeDescription : "Completed your first blood donation"
/// badgeIcon : "heart"
/// category : "DONATION"
/// rarity : "COMMON"
/// unlockStatus : "LOCKED"
/// unlockedAt : null
/// progressCurrent : 0
/// progressTarget : 1
/// progressPercentage : 0

class Badges {
  Badges({
      this.badgeId, 
      this.badgeName, 
      this.badgeDescription, 
      this.badgeIcon, 
      this.category, 
      this.rarity, 
      this.unlockStatus, 
      this.unlockedAt, 
      this.progressCurrent, 
      this.progressTarget, 
      this.progressPercentage,});

  Badges.fromJson(dynamic json) {
    badgeId = json['badgeId'];
    badgeName = json['badgeName'];
    badgeDescription = json['badgeDescription'];
    badgeIcon = json['badgeIcon'];
    category = json['category'];
    rarity = json['rarity'];
    unlockStatus = json['unlockStatus'];
    unlockedAt = json['unlockedAt'];
    progressCurrent = json['progressCurrent'];
    progressTarget = json['progressTarget'];
    progressPercentage = json['progressPercentage'];
  }
  String? badgeId;
  String? badgeName;
  String? badgeDescription;
  String? badgeIcon;
  String? category;
  String? rarity;
  String? unlockStatus;
  dynamic unlockedAt;
  int? progressCurrent;
  int? progressTarget;
  int? progressPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['badgeId'] = badgeId;
    map['badgeName'] = badgeName;
    map['badgeDescription'] = badgeDescription;
    map['badgeIcon'] = badgeIcon;
    map['category'] = category;
    map['rarity'] = rarity;
    map['unlockStatus'] = unlockStatus;
    map['unlockedAt'] = unlockedAt;
    map['progressCurrent'] = progressCurrent;
    map['progressTarget'] = progressTarget;
    map['progressPercentage'] = progressPercentage;
    return map;
  }

}