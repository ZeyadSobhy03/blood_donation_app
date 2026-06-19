/// success : true
/// message : "Analytics overview retrieved"
/// data : {"growthRate":"-50%","successRate":"28.2%","monthlyTrend":{"values":[0,0,0,0,0,23,16],"labels":["Dec","Jan","Feb","Mar","Apr","May","Jun"]},"aiPredictions":["Blood demand expected to increase 20% next month based on historical trends — consider scheduling additional donation drives and sending proactive alerts to O+ and A+ donors.","Sunday shows 367% higher donation activity — schedule more mobile drives and staff on this day to maximize collections.","Weekend donation drives show 4525% higher success rates compared to weekdays. Prioritize weekend scheduling for upcoming emergency campaigns."]}

class AnalyticsOverviewModel {
  AnalyticsOverviewModel({
      this.success, 
      this.message, 
      this.data,});

  AnalyticsOverviewModel.fromJson(dynamic json) {
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

/// growthRate : "-50%"
/// successRate : "28.2%"
/// monthlyTrend : {"values":[0,0,0,0,0,23,16],"labels":["Dec","Jan","Feb","Mar","Apr","May","Jun"]}
/// aiPredictions : ["Blood demand expected to increase 20% next month based on historical trends — consider scheduling additional donation drives and sending proactive alerts to O+ and A+ donors.","Sunday shows 367% higher donation activity — schedule more mobile drives and staff on this day to maximize collections.","Weekend donation drives show 4525% higher success rates compared to weekdays. Prioritize weekend scheduling for upcoming emergency campaigns."]

class Data {
  Data({
      this.growthRate, 
      this.successRate, 
      this.monthlyTrend, 
      this.aiPredictions,});

  Data.fromJson(dynamic json) {
    growthRate = json['growthRate'];
    successRate = json['successRate'];
    monthlyTrend = json['monthlyTrend'] != null ? MonthlyTrend.fromJson(json['monthlyTrend']) : null;
    aiPredictions = json['aiPredictions'] != null ? json['aiPredictions'].cast<String>() : [];
  }
  String? growthRate;
  String? successRate;
  MonthlyTrend? monthlyTrend;
  List<String>? aiPredictions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['growthRate'] = growthRate;
    map['successRate'] = successRate;
    if (monthlyTrend != null) {
      map['monthlyTrend'] = monthlyTrend?.toJson();
    }
    map['aiPredictions'] = aiPredictions;
    return map;
  }

}

/// values : [0,0,0,0,0,23,16]
/// labels : ["Dec","Jan","Feb","Mar","Apr","May","Jun"]

class MonthlyTrend {
  MonthlyTrend({
      this.values, 
      this.labels,});

  MonthlyTrend.fromJson(dynamic json) {
    values = json['values'] != null ? json['values'].cast<int>() : [];
    labels = json['labels'] != null ? json['labels'].cast<String>() : [];
  }
  List<int>? values;
  List<String>? labels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = values;
    map['labels'] = labels;
    return map;
  }

}