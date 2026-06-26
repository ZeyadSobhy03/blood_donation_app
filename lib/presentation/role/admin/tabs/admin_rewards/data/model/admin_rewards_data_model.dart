/// success : true
/// message : "Rewards data retrieved successfully"
/// data : {"totalPoints":48200,"percentageChange":12.5,"tiers":[{"tierName":"bronze","userCount":120},{"tierName":"silver","userCount":80},{"tierName":"gold","userCount":30},{"tierName":"platinum","userCount":10}],"topRedeemed":[{"rewardName":"Coffee Voucher","rewardSubtitle":"Free coffee at partner cafes","pointsRedeemed":17000},{"rewardName":"Movie Tickets","rewardSubtitle":"2 movie tickets at major cinemas","pointsRedeemed":18000}],"catalog":{"items":[{"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","category":"FOOD","pointsRequired":500,"redeemedCount":34,"status":"ACTIVE"},{"id":"664a123456789abcdef12346","rewardName":"Movie Tickets","category":"ENTERTAINMENT","pointsRequired":1000,"redeemedCount":18,"status":"ACTIVE"}],"totalCount":6},"adjustments":[{"userName":"John Doe","userId":"69f3df915f42685cbbbcbb18","reason":"Community engagement bonus","points":200,"date":"2026-06-20T14:30:00.000Z","adminName":"Admin User"},{"userName":"Jane Smith","userId":"69f3df915f42685cbbbcbb19","reason":"Correction for missed donation","points":-100,"date":"2026-06-19T10:15:00.000Z","adminName":"Admin User"}],"users":[{"id":"69f3df915f42685cbbbcbb18","name":"John Doe","email":"john@example.com","role":"donor","currentPoints":1250}]}

class AdminRewardsDataModel {
  AdminRewardsDataModel({
      this.success, 
      this.message, 
      this.data,});

  AdminRewardsDataModel.fromJson(dynamic json) {
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

/// totalPoints : 48200
/// percentageChange : 12.5
/// tiers : [{"tierName":"bronze","userCount":120},{"tierName":"silver","userCount":80},{"tierName":"gold","userCount":30},{"tierName":"platinum","userCount":10}]
/// topRedeemed : [{"rewardName":"Coffee Voucher","rewardSubtitle":"Free coffee at partner cafes","pointsRedeemed":17000},{"rewardName":"Movie Tickets","rewardSubtitle":"2 movie tickets at major cinemas","pointsRedeemed":18000}]
/// catalog : {"items":[{"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","category":"FOOD","pointsRequired":500,"redeemedCount":34,"status":"ACTIVE"},{"id":"664a123456789abcdef12346","rewardName":"Movie Tickets","category":"ENTERTAINMENT","pointsRequired":1000,"redeemedCount":18,"status":"ACTIVE"}],"totalCount":6}
/// adjustments : [{"userName":"John Doe","userId":"69f3df915f42685cbbbcbb18","reason":"Community engagement bonus","points":200,"date":"2026-06-20T14:30:00.000Z","adminName":"Admin User"},{"userName":"Jane Smith","userId":"69f3df915f42685cbbbcbb19","reason":"Correction for missed donation","points":-100,"date":"2026-06-19T10:15:00.000Z","adminName":"Admin User"}]
/// users : [{"id":"69f3df915f42685cbbbcbb18","name":"John Doe","email":"john@example.com","role":"donor","currentPoints":1250}]

class Data {
  Data({
      this.totalPoints, 
      this.percentageChange, 
      this.tiers, 
      this.topRedeemed, 
      this.catalog, 
      this.adjustments, 
      this.users,});

  Data.fromJson(dynamic json) {
    totalPoints = json['totalPoints'];
    percentageChange = json['percentageChange'];
    if (json['tiers'] != null) {
      tiers = [];
      json['tiers'].forEach((v) {
        tiers?.add(Tiers.fromJson(v));
      });
    }
    if (json['topRedeemed'] != null) {
      topRedeemed = [];
      json['topRedeemed'].forEach((v) {
        topRedeemed?.add(TopRedeemed.fromJson(v));
      });
    }
    catalog = json['catalog'] != null ? Catalog.fromJson(json['catalog']) : null;
    if (json['adjustments'] != null) {
      adjustments = [];
      json['adjustments'].forEach((v) {
        adjustments?.add(Adjustments.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
  }
  int? totalPoints;
  double? percentageChange;
  List<Tiers>? tiers;
  List<TopRedeemed>? topRedeemed;
  Catalog? catalog;
  List<Adjustments>? adjustments;
  List<Users>? users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalPoints'] = totalPoints;
    map['percentageChange'] = percentageChange;
    if (tiers != null) {
      map['tiers'] = tiers?.map((v) => v.toJson()).toList();
    }
    if (topRedeemed != null) {
      map['topRedeemed'] = topRedeemed?.map((v) => v.toJson()).toList();
    }
    if (catalog != null) {
      map['catalog'] = catalog?.toJson();
    }
    if (adjustments != null) {
      map['adjustments'] = adjustments?.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "69f3df915f42685cbbbcbb18"
/// name : "John Doe"
/// email : "john@example.com"
/// role : "donor"
/// currentPoints : 1250

class Users {
  Users({
      this.id, 
      this.name, 
      this.email, 
      this.role, 
      this.currentPoints,});

  Users.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    currentPoints = json['currentPoints'];
  }
  String? id;
  String? name;
  String? email;
  String? role;
  int? currentPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['currentPoints'] = currentPoints;
    return map;
  }

}

/// userName : "John Doe"
/// userId : "69f3df915f42685cbbbcbb18"
/// reason : "Community engagement bonus"
/// points : 200
/// date : "2026-06-20T14:30:00.000Z"
/// adminName : "Admin User"

class Adjustments {
  Adjustments({
      this.userName, 
      this.userId, 
      this.reason, 
      this.points, 
      this.date, 
      this.adminName,});

  Adjustments.fromJson(dynamic json) {
    userName = json['userName'];
    userId = json['userId'];
    reason = json['reason'];
    points = json['points'];
    date = json['date'];
    adminName = json['adminName'];
  }
  String? userName;
  String? userId;
  String? reason;
  int? points;
  String? date;
  String? adminName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['userId'] = userId;
    map['reason'] = reason;
    map['points'] = points;
    map['date'] = date;
    map['adminName'] = adminName;
    return map;
  }

}

/// items : [{"id":"664a123456789abcdef12345","rewardName":"Coffee Voucher","category":"FOOD","pointsRequired":500,"redeemedCount":34,"status":"ACTIVE"},{"id":"664a123456789abcdef12346","rewardName":"Movie Tickets","category":"ENTERTAINMENT","pointsRequired":1000,"redeemedCount":18,"status":"ACTIVE"}]
/// totalCount : 6

class Catalog {
  Catalog({
      this.items, 
      this.totalCount,});

  Catalog.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }
  List<Items>? items;
  int? totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = totalCount;
    return map;
  }
  Catalog copyWith({
    List<Items>? items,
    int? totalCount,
  }) {
    return Catalog(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }

}

/// id : "664a123456789abcdef12345"
/// rewardName : "Coffee Voucher"
/// category : "FOOD"
/// pointsRequired : 500
/// redeemedCount : 34
/// status : "ACTIVE"

class Items {
  Items({
      this.id, 
      this.rewardName, 
      this.category, 
      this.pointsRequired, 
      this.redeemedCount, 
      this.status,});

  Items.fromJson(dynamic json) {
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
  Items copyWith({
    String? id,
    String? rewardName,
    String? category,
    int? pointsRequired,
    int? redeemedCount,
    String? status,
  }) {
    return Items(
      id: id ?? this.id,
      rewardName: rewardName ?? this.rewardName,
      category: category ?? this.category,
      pointsRequired: pointsRequired ?? this.pointsRequired,
      redeemedCount: redeemedCount ?? this.redeemedCount,
      status: status ?? this.status,
    );
  }

}

/// rewardName : "Coffee Voucher"
/// rewardSubtitle : "Free coffee at partner cafes"
/// pointsRedeemed : 17000

class TopRedeemed {
  TopRedeemed({
      this.rewardName, 
      this.rewardSubtitle, 
      this.pointsRedeemed,});

  TopRedeemed.fromJson(dynamic json) {
    rewardName = json['rewardName'];
    rewardSubtitle = json['rewardSubtitle'];
    pointsRedeemed = json['pointsRedeemed'];
  }
  String? rewardName;
  String? rewardSubtitle;
  int? pointsRedeemed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rewardName'] = rewardName;
    map['rewardSubtitle'] = rewardSubtitle;
    map['pointsRedeemed'] = pointsRedeemed;
    return map;
  }

}

/// tierName : "bronze"
/// userCount : 120

class Tiers {
  Tiers({
      this.tierName, 
      this.userCount,});

  Tiers.fromJson(dynamic json) {
    tierName = json['tierName'];
    userCount = json['userCount'];
  }
  String? tierName;
  int? userCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tierName'] = tierName;
    map['userCount'] = userCount;
    return map;
  }

}