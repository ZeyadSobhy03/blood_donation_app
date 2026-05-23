/// success : true
/// data : {"transactions":[{"_id":"6a0208c5927870ffe66837fa","donorId":"69f3df915f42685cbbbcbb18","pointsAmount":-500,"transactionType":"REWARD_REDEEMED","description":"Reward Redeemed: Coffee Voucher","referenceId":"6a0208c4927870ffe66837f9","balanceAfter":350,"adminId":null,"createdAt":"2026-05-11T16:50:13.050Z","updatedAt":"2026-05-11T16:50:13.050Z","__v":0}],"pagination":{"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}}

class PointsHistory {
  PointsHistory({
      this.success, 
      this.data,});

  PointsHistory.fromJson(dynamic json) {
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

/// transactions : [{"_id":"6a0208c5927870ffe66837fa","donorId":"69f3df915f42685cbbbcbb18","pointsAmount":-500,"transactionType":"REWARD_REDEEMED","description":"Reward Redeemed: Coffee Voucher","referenceId":"6a0208c4927870ffe66837f9","balanceAfter":350,"adminId":null,"createdAt":"2026-05-11T16:50:13.050Z","updatedAt":"2026-05-11T16:50:13.050Z","__v":0}]
/// pagination : {"total":1,"page":1,"limit":20,"totalPages":1,"hasNextPage":false,"hasPrevPage":false}

class Data {
  Data({
      this.transactions, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transactions.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Transactions>? transactions;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// total : 1
/// page : 1
/// limit : 20
/// totalPages : 1
/// hasNextPage : false
/// hasPrevPage : false

class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.hasNextPage, 
      this.hasPrevPage,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }

}

/// _id : "6a0208c5927870ffe66837fa"
/// donorId : "69f3df915f42685cbbbcbb18"
/// pointsAmount : -500
/// transactionType : "REWARD_REDEEMED"
/// description : "Reward Redeemed: Coffee Voucher"
/// referenceId : "6a0208c4927870ffe66837f9"
/// balanceAfter : 350
/// adminId : null
/// createdAt : "2026-05-11T16:50:13.050Z"
/// updatedAt : "2026-05-11T16:50:13.050Z"
/// __v : 0

class Transactions {
  Transactions({
      this.id, 
      this.donorId, 
      this.pointsAmount, 
      this.transactionType, 
      this.description, 
      this.referenceId, 
      this.balanceAfter, 
      this.adminId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Transactions.fromJson(dynamic json) {
    id = json['_id'];
    donorId = json['donorId'];
    pointsAmount = json['pointsAmount'];
    transactionType = json['transactionType'];
    description = json['description'];
    referenceId = json['referenceId'];
    balanceAfter = json['balanceAfter'];
    adminId = json['adminId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? donorId;
  int? pointsAmount;
  String? transactionType;
  String? description;
  String? referenceId;
  int? balanceAfter;
  dynamic adminId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['donorId'] = donorId;
    map['pointsAmount'] = pointsAmount;
    map['transactionType'] = transactionType;
    map['description'] = description;
    map['referenceId'] = referenceId;
    map['balanceAfter'] = balanceAfter;
    map['adminId'] = adminId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}