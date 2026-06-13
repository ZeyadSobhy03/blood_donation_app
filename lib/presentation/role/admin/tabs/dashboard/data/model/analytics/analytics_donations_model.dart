/// success : true
/// message : "Donation trends"
/// data : {"trends":[{"year":2026,"month":3,"total":41,"completed":35,"cancelled":6,"totalUnits":39,"successRate":"85.4%"},{"year":2026,"month":4,"total":52,"completed":46,"cancelled":6,"totalUnits":51,"successRate":"88.5%"},{"year":2026,"month":5,"total":38,"completed":32,"cancelled":6,"totalUnits":35,"successRate":"84.2%"}],"dailyTrends":[{"date":"2026-05-16","completed":3,"pending":2,"cancelled":0,"totalUnits":3},{"date":"2026-05-17","completed":5,"pending":1,"cancelled":1,"totalUnits":6}],"regionalBreakdown":[{"governorate":"Cairo","completed":28,"activeRequests":6,"donorsAvailable":120},{"governorate":"Giza","completed":9,"activeRequests":3,"donorsAvailable":45}]}

class AnalyticsDonationsModel {
  AnalyticsDonationsModel({
      this.success, 
      this.message, 
      this.data,});

  AnalyticsDonationsModel.fromJson(dynamic json) {
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

/// trends : [{"year":2026,"month":3,"total":41,"completed":35,"cancelled":6,"totalUnits":39,"successRate":"85.4%"},{"year":2026,"month":4,"total":52,"completed":46,"cancelled":6,"totalUnits":51,"successRate":"88.5%"},{"year":2026,"month":5,"total":38,"completed":32,"cancelled":6,"totalUnits":35,"successRate":"84.2%"}]
/// dailyTrends : [{"date":"2026-05-16","completed":3,"pending":2,"cancelled":0,"totalUnits":3},{"date":"2026-05-17","completed":5,"pending":1,"cancelled":1,"totalUnits":6}]
/// regionalBreakdown : [{"governorate":"Cairo","completed":28,"activeRequests":6,"donorsAvailable":120},{"governorate":"Giza","completed":9,"activeRequests":3,"donorsAvailable":45}]

class Data {
  Data({
      this.trends, 
      this.dailyTrends, 
      this.regionalBreakdown,});

  Data.fromJson(dynamic json) {
    if (json['trends'] != null) {
      trends = [];
      json['trends'].forEach((v) {
        trends?.add(Trends.fromJson(v));
      });
    }
    if (json['dailyTrends'] != null) {
      dailyTrends = [];
      json['dailyTrends'].forEach((v) {
        dailyTrends?.add(DailyTrends.fromJson(v));
      });
    }
    if (json['regionalBreakdown'] != null) {
      regionalBreakdown = [];
      json['regionalBreakdown'].forEach((v) {
        regionalBreakdown?.add(RegionalBreakdown.fromJson(v));
      });
    }
  }
  List<Trends>? trends;
  List<DailyTrends>? dailyTrends;
  List<RegionalBreakdown>? regionalBreakdown;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (trends != null) {
      map['trends'] = trends?.map((v) => v.toJson()).toList();
    }
    if (dailyTrends != null) {
      map['dailyTrends'] = dailyTrends?.map((v) => v.toJson()).toList();
    }
    if (regionalBreakdown != null) {
      map['regionalBreakdown'] = regionalBreakdown?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// governorate : "Cairo"
/// completed : 28
/// activeRequests : 6
/// donorsAvailable : 120

class RegionalBreakdown {
  RegionalBreakdown({
      this.governorate, 
      this.completed, 
      this.activeRequests, 
      this.donorsAvailable,});

  RegionalBreakdown.fromJson(dynamic json) {
    governorate = json['governorate'];
    completed = json['completed'];
    activeRequests = json['activeRequests'];
    donorsAvailable = json['donorsAvailable'];
  }
  String? governorate;
  int? completed;
  int? activeRequests;
  int? donorsAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['governorate'] = governorate;
    map['completed'] = completed;
    map['activeRequests'] = activeRequests;
    map['donorsAvailable'] = donorsAvailable;
    return map;
  }

}

/// date : "2026-05-16"
/// completed : 3
/// pending : 2
/// cancelled : 0
/// totalUnits : 3

class DailyTrends {
  DailyTrends({
      this.date, 
      this.completed, 
      this.pending, 
      this.cancelled, 
      this.totalUnits,});

  DailyTrends.fromJson(dynamic json) {
    date = json['date'];
    completed = json['completed'];
    pending = json['pending'];
    cancelled = json['cancelled'];
    totalUnits = json['totalUnits'];
  }
  String? date;
  int? completed;
  int? pending;
  int? cancelled;
  int? totalUnits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['completed'] = completed;
    map['pending'] = pending;
    map['cancelled'] = cancelled;
    map['totalUnits'] = totalUnits;
    return map;
  }

}

/// year : 2026
/// month : 3
/// total : 41
/// completed : 35
/// cancelled : 6
/// totalUnits : 39
/// successRate : "85.4%"

class Trends {
  Trends({
      this.year, 
      this.month, 
      this.total, 
      this.completed, 
      this.cancelled, 
      this.totalUnits, 
      this.successRate,});

  Trends.fromJson(dynamic json) {
    year = json['year'];
    month = json['month'];
    total = json['total'];
    completed = json['completed'];
    cancelled = json['cancelled'];
    totalUnits = json['totalUnits'];
    successRate = json['successRate'];
  }
  int? year;
  int? month;
  int? total;
  int? completed;
  int? cancelled;
  int? totalUnits;
  String? successRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['month'] = month;
    map['total'] = total;
    map['completed'] = completed;
    map['cancelled'] = cancelled;
    map['totalUnits'] = totalUnits;
    map['successRate'] = successRate;
    return map;
  }

}