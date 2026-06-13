/// success : true
/// data : {"users":{"total":284,"donors":231,"hospitals":41},"requests":{"active":19,"critical":4},"donations":{"pending":13,"completed":428},"alerts":{"unverifiedUsers":7,"suspendedUsers":3,"criticalRequests":4}}

class AnalyticsModel {
  AnalyticsModel({
      this.success, 
      this.data,});

  AnalyticsModel.fromJson(dynamic json) {
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

/// users : {"total":284,"donors":231,"hospitals":41}
/// requests : {"active":19,"critical":4}
/// donations : {"pending":13,"completed":428}
/// alerts : {"unverifiedUsers":7,"suspendedUsers":3,"criticalRequests":4}

class Data {
  Data({
      this.users, 
      this.requests, 
      this.donations, 
      this.alerts,});

  Data.fromJson(dynamic json) {
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    requests = json['requests'] != null ? Requests.fromJson(json['requests']) : null;
    donations = json['donations'] != null ? Donations.fromJson(json['donations']) : null;
    alerts = json['alerts'] != null ? Alerts.fromJson(json['alerts']) : null;
  }
  Users? users;
  Requests? requests;
  Donations? donations;
  Alerts? alerts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (users != null) {
      map['users'] = users?.toJson();
    }
    if (requests != null) {
      map['requests'] = requests?.toJson();
    }
    if (donations != null) {
      map['donations'] = donations?.toJson();
    }
    if (alerts != null) {
      map['alerts'] = alerts?.toJson();
    }
    return map;
  }

}

/// unverifiedUsers : 7
/// suspendedUsers : 3
/// criticalRequests : 4

class Alerts {
  Alerts({
      this.unverifiedUsers, 
      this.suspendedUsers, 
      this.criticalRequests,});

  Alerts.fromJson(dynamic json) {
    unverifiedUsers = json['unverifiedUsers'];
    suspendedUsers = json['suspendedUsers'];
    criticalRequests = json['criticalRequests'];
  }
  int? unverifiedUsers;
  int? suspendedUsers;
  int? criticalRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unverifiedUsers'] = unverifiedUsers;
    map['suspendedUsers'] = suspendedUsers;
    map['criticalRequests'] = criticalRequests;
    return map;
  }

}

/// pending : 13
/// completed : 428

class Donations {
  Donations({
      this.pending, 
      this.completed,});

  Donations.fromJson(dynamic json) {
    pending = json['pending'];
    completed = json['completed'];
  }
  int? pending;
  int? completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pending'] = pending;
    map['completed'] = completed;
    return map;
  }

}

/// active : 19
/// critical : 4

class Requests {
  Requests({
      this.active, 
      this.critical,});

  Requests.fromJson(dynamic json) {
    active = json['active'];
    critical = json['critical'];
  }
  int? active;
  int? critical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = active;
    map['critical'] = critical;
    return map;
  }

}

/// total : 284
/// donors : 231
/// hospitals : 41

class Users {
  Users({
      this.total, 
      this.donors, 
      this.hospitals,});

  Users.fromJson(dynamic json) {
    total = json['total'];
    donors = json['donors'];
    hospitals = json['hospitals'];
  }
  int? total;
  int? donors;
  int? hospitals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['donors'] = donors;
    map['hospitals'] = hospitals;
    return map;
  }

}