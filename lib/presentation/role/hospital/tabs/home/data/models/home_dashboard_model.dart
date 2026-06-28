class HomeDashboardModel {
  HomeDashboardModel({this.success, this.message, this.data});

  HomeDashboardModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeDashboardData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeDashboardData? data;
}

class HomeDashboardData {
  HomeDashboardData({
    this.month,
    this.totalRequests,
    this.activeRequests,
    this.totalCompleted,
    this.totalCancelled,
    this.emergencyRequests,
    this.totalDonations,
    this.totalResponses,
    this.responsesToday,
  });

  HomeDashboardData.fromJson(dynamic json) {
    month           = json['month'];
    totalRequests   = (json['totalRequests']   as num?)?.toInt();
    activeRequests  = (json['activeRequests']  as num?)?.toInt();
    totalCompleted  = (json['totalCompleted']  as num?)?.toInt();
    totalCancelled  = (json['totalCancelled']  as num?)?.toInt();
    emergencyRequests = (json['emergencyRequests'] as num?)?.toInt();
    totalDonations  = (json['totalDonations']  as num?)?.toInt();
    totalResponses  = (json['totalResponses']  as num?)?.toInt();
    responsesToday  = (json['responsesToday']  as num?)?.toInt();
  }

  String? month;
  int? totalRequests;
  int? activeRequests;
  int? totalCompleted;
  int? totalCancelled;
  int? emergencyRequests;
  int? totalDonations;
  int? totalResponses;
  int? responsesToday;
}
