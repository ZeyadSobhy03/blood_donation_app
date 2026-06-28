class HospitalProfileModel {
  HospitalProfileModel({this.success, this.message, this.data});

  HospitalProfileModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? HospitalProfileData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  HospitalProfileData? data;
}

class HospitalProfileData {
  HospitalProfileData({
    this.hospitalName,
    this.department,
    this.contactNumber,
    this.email,
    this.address,
    this.workingHours,
    this.notifications,
    this.statistics,
    this.location,
  });

  HospitalProfileData.fromJson(dynamic json) {
    hospitalName = json['hospitalName'];
    department   = json['department'];
    contactNumber = json['contactNumber'];
    email        = json['email'];
    address      = json['address'];
    workingHours = json['workingHours'] != null
        ? WorkingHoursData.fromJson(json['workingHours'])
        : null;
    notifications = json['notifications'] != null
        ? NotificationPreferencesData.fromJson(json['notifications'])
        : null;
    statistics = json['statistics'] != null
        ? StatisticsData.fromJson(json['statistics'])
        : null;
    location = json['location'] != null
        ? LocationData.fromJson(json['location'])
        : null;
  }

  String? hospitalName;
  String? department;
  String? contactNumber;
  String? email;
  dynamic address;
  WorkingHoursData? workingHours;
  NotificationPreferencesData? notifications;
  StatisticsData? statistics;
  LocationData? location;
}

class LocationData {
  LocationData({this.lat, this.lng});

  LocationData.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  double? lat;
  double? lng;
}

String formatAddress(dynamic address) {
  if (address == null) return '';
  if (address is String) return address;
  if (address is Map) {
    final city = address['city']?.toString() ?? '';
    final district = address['district']?.toString() ?? '';
    if (city.isNotEmpty && district.isNotEmpty) return '$city, $district';
    if (city.isNotEmpty) return city;
  }
  return '';
}

class WorkingHoursData {
  WorkingHoursData({this.openingHour, this.closingHour, this.slotsPerHour});

  WorkingHoursData.fromJson(dynamic json) {
    openingHour  = json['openingHour'];
    closingHour  = json['closingHour'];
    slotsPerHour = json['slotsPerHour'];
  }

  int? openingHour;
  int? closingHour;
  int? slotsPerHour;
}

class NotificationPreferencesData {
  NotificationPreferencesData({
    this.pushNotifications,
    this.emergencyAlerts,
    this.emailNotifications,
    this.smsAlerts,
  });

  NotificationPreferencesData.fromJson(dynamic json) {
    pushNotifications   = json['pushNotifications'];
    emergencyAlerts     = json['emergencyAlerts'];
    emailNotifications  = json['emailNotifications'];
    smsAlerts           = json['smsAlerts'];
  }

  bool? pushNotifications;
  bool? emergencyAlerts;
  bool? emailNotifications;
  bool? smsAlerts;
}

class StatisticsData {
  StatisticsData({
    this.totalRequests,
    this.fulfilled,
    this.active,
    this.successRate,
  });

  StatisticsData.fromJson(dynamic json) {
    totalRequests = json['totalRequests'];
    fulfilled     = json['fulfilled'];
    active        = json['active'];
    successRate   = json['successRate'];
  }

  int? totalRequests;
  int? fulfilled;
  int? active;
  int? successRate;
}
