/// success : true
/// data : {"rewards":[{"_id":"69f26028dc1ddc888014fcf9","name":"Coffee Voucher","__v":0,"category":"FOOD","colorCode":"#8B4513","createdAt":"2026-04-29T19:46:48.671Z","dailyLimit":null,"description":"Free coffee at partner cafes","iconType":"coffee","monthlyLimit":null,"pointsCost":500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.791Z","available":true},{"_id":"69f26029dc1ddc888014fcfa","name":"Movie Tickets","__v":0,"category":"ENTERTAINMENT","colorCode":"#6A0DAD","createdAt":"2026-04-29T19:46:48.977Z","dailyLimit":5,"description":"2 movie tickets at major cinemas","iconType":"movie","monthlyLimit":50,"pointsCost":1000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.806Z","available":true},{"_id":"69f26029dc1ddc888014fcfb","name":"Restaurant Gift Card","__v":0,"category":"FOOD","colorCode":"#E53935","createdAt":"2026-04-29T19:46:49.183Z","dailyLimit":null,"description":"Gift card for partner restaurants","iconType":"restaurant","monthlyLimit":null,"pointsCost":1500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.820Z","available":true},{"_id":"69f26029dc1ddc888014fcfc","name":"Health Check-up","__v":0,"category":"HEALTH","colorCode":"#2E7D32","createdAt":"2026-04-29T19:46:49.388Z","dailyLimit":null,"description":"Full health check-up at partner clinics","iconType":"medical","monthlyLimit":null,"pointsCost":2000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.835Z","available":true},{"_id":"69f26029dc1ddc888014fcfd","name":"Premium Badge","__v":0,"category":"STATUS","colorCode":"#F9A825","createdAt":"2026-04-29T19:46:49.592Z","dailyLimit":null,"description":"Exclusive premium badge on your profile","iconType":"premium","monthlyLimit":null,"pointsCost":2500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.849Z","available":true},{"_id":"69f26029dc1ddc888014fcfe","name":"Gym Membership","__v":0,"category":"HEALTH","colorCode":"#1565C0","createdAt":"2026-04-29T19:46:49.797Z","dailyLimit":null,"description":"One-month gym membership at partner gyms","iconType":"gym","monthlyLimit":null,"pointsCost":3000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.862Z","available":true}],"filterOptions":{"categories":["FOOD","ENTERTAINMENT","HEALTH","STATUS"]}}

class RewardsModel {
  RewardsModel({
      this.success, 
      this.data,});

  RewardsModel.fromJson(dynamic json) {
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

/// rewards : [{"_id":"69f26028dc1ddc888014fcf9","name":"Coffee Voucher","__v":0,"category":"FOOD","colorCode":"#8B4513","createdAt":"2026-04-29T19:46:48.671Z","dailyLimit":null,"description":"Free coffee at partner cafes","iconType":"coffee","monthlyLimit":null,"pointsCost":500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.791Z","available":true},{"_id":"69f26029dc1ddc888014fcfa","name":"Movie Tickets","__v":0,"category":"ENTERTAINMENT","colorCode":"#6A0DAD","createdAt":"2026-04-29T19:46:48.977Z","dailyLimit":5,"description":"2 movie tickets at major cinemas","iconType":"movie","monthlyLimit":50,"pointsCost":1000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.806Z","available":true},{"_id":"69f26029dc1ddc888014fcfb","name":"Restaurant Gift Card","__v":0,"category":"FOOD","colorCode":"#E53935","createdAt":"2026-04-29T19:46:49.183Z","dailyLimit":null,"description":"Gift card for partner restaurants","iconType":"restaurant","monthlyLimit":null,"pointsCost":1500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.820Z","available":true},{"_id":"69f26029dc1ddc888014fcfc","name":"Health Check-up","__v":0,"category":"HEALTH","colorCode":"#2E7D32","createdAt":"2026-04-29T19:46:49.388Z","dailyLimit":null,"description":"Full health check-up at partner clinics","iconType":"medical","monthlyLimit":null,"pointsCost":2000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.835Z","available":true},{"_id":"69f26029dc1ddc888014fcfd","name":"Premium Badge","__v":0,"category":"STATUS","colorCode":"#F9A825","createdAt":"2026-04-29T19:46:49.592Z","dailyLimit":null,"description":"Exclusive premium badge on your profile","iconType":"premium","monthlyLimit":null,"pointsCost":2500,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.849Z","available":true},{"_id":"69f26029dc1ddc888014fcfe","name":"Gym Membership","__v":0,"category":"HEALTH","colorCode":"#1565C0","createdAt":"2026-04-29T19:46:49.797Z","dailyLimit":null,"description":"One-month gym membership at partner gyms","iconType":"gym","monthlyLimit":null,"pointsCost":3000,"redemptionCount":0,"status":"ACTIVE","updatedAt":"2026-05-11T16:28:47.862Z","available":true}]
/// filterOptions : {"categories":["FOOD","ENTERTAINMENT","HEALTH","STATUS"]}

class Data {
  Data({
      this.rewards, 
      this.filterOptions,});

  Data.fromJson(dynamic json) {
    if (json['rewards'] != null) {
      rewards = [];
      json['rewards'].forEach((v) {
        rewards?.add(Rewards.fromJson(v));
      });
    }
    filterOptions = json['filterOptions'] != null ? FilterOptions.fromJson(json['filterOptions']) : null;
  }
  List<Rewards>? rewards;
  FilterOptions? filterOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rewards != null) {
      map['rewards'] = rewards?.map((v) => v.toJson()).toList();
    }
    if (filterOptions != null) {
      map['filterOptions'] = filterOptions?.toJson();
    }
    return map;
  }

}

/// categories : ["FOOD","ENTERTAINMENT","HEALTH","STATUS"]

class FilterOptions {
  FilterOptions({
      this.categories,});

  FilterOptions.fromJson(dynamic json) {
    categories = json['categories'] != null ? json['categories'].cast<String>() : [];
  }
  List<String>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categories'] = categories;
    return map;
  }

}

/// _id : "69f26028dc1ddc888014fcf9"
/// name : "Coffee Voucher"
/// __v : 0
/// category : "FOOD"
/// colorCode : "#8B4513"
/// createdAt : "2026-04-29T19:46:48.671Z"
/// dailyLimit : null
/// description : "Free coffee at partner cafes"
/// iconType : "coffee"
/// monthlyLimit : null
/// pointsCost : 500
/// redemptionCount : 0
/// status : "ACTIVE"
/// updatedAt : "2026-05-11T16:28:47.791Z"
/// available : true

class Rewards {
  Rewards({
      this.id, 
      this.name, 
      this.v, 
      this.category, 
      this.colorCode, 
      this.createdAt, 
      this.dailyLimit, 
      this.description, 
      this.iconType, 
      this.monthlyLimit, 
      this.pointsCost, 
      this.redemptionCount, 
      this.status, 
      this.updatedAt, 
      this.available,});

  Rewards.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    v = json['__v'];
    category = json['category'];
    colorCode = json['colorCode'];
    createdAt = json['createdAt'];
    dailyLimit = json['dailyLimit'];
    description = json['description'];
    iconType = json['iconType'];
    monthlyLimit = json['monthlyLimit'];
    pointsCost = json['pointsCost'];
    redemptionCount = json['redemptionCount'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    available = json['available'];
  }
  String? id;
  String? name;
  int? v;
  String? category;
  String? colorCode;
  String? createdAt;
  dynamic dailyLimit;
  String? description;
  String? iconType;
  dynamic monthlyLimit;
  int? pointsCost;
  int? redemptionCount;
  String? status;
  String? updatedAt;
  bool? available;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['__v'] = v;
    map['category'] = category;
    map['colorCode'] = colorCode;
    map['createdAt'] = createdAt;
    map['dailyLimit'] = dailyLimit;
    map['description'] = description;
    map['iconType'] = iconType;
    map['monthlyLimit'] = monthlyLimit;
    map['pointsCost'] = pointsCost;
    map['redemptionCount'] = redemptionCount;
    map['status'] = status;
    map['updatedAt'] = updatedAt;
    map['available'] = available;
    return map;
  }

}