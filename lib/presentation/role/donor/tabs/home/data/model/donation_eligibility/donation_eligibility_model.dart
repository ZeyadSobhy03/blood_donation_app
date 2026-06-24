/// success : true
/// message : "Eligibility result"
/// data : {"isEligible":true,"reason":null,"nextEligibleDate":null,"participationEnabled":true,"lastDonationDate":"2026-05-10T00:00:00.000Z","cooldownDays":56,"daysRemaining":0}

class DonationEligibilityModel {
  DonationEligibilityModel({
      this.success, 
      this.message, 
      this.data,});

  DonationEligibilityModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  DonationEligibilityModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return DonationEligibilityModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

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

/// isEligible : true
/// reason : null
/// nextEligibleDate : null
/// participationEnabled : true
/// lastDonationDate : "2026-05-10T00:00:00.000Z"
/// cooldownDays : 56
/// daysRemaining : 0

class Data {
  Data({
      this.isEligible, 
      this.reason, 
      this.nextEligibleDate, 
      this.participationEnabled, 
      this.lastDonationDate, 
      this.cooldownDays, 
      this.daysRemaining,});

  Data.fromJson(dynamic json) {
    isEligible = json['isEligible'];
    reason = json['reason'];
    nextEligibleDate = json['nextEligibleDate'];
    participationEnabled = json['participationEnabled'];
    lastDonationDate = json['lastDonationDate'];
    cooldownDays = json['cooldownDays'];
    daysRemaining = json['daysRemaining'];
  }
  bool? isEligible;
  dynamic reason;
  dynamic nextEligibleDate;
  bool? participationEnabled;
  String? lastDonationDate;
  int? cooldownDays;
  int? daysRemaining;

  Data copyWith({
    bool? isEligible,
    dynamic reason,
    dynamic nextEligibleDate,
    bool? participationEnabled,
    String? lastDonationDate,
    int? cooldownDays,
    int? daysRemaining,
  }) {
    return Data(
      isEligible: isEligible ?? this.isEligible,
      reason: reason ?? this.reason,
      nextEligibleDate: nextEligibleDate ?? this.nextEligibleDate,
      participationEnabled: participationEnabled ?? this.participationEnabled,
      lastDonationDate: lastDonationDate ?? this.lastDonationDate,
      cooldownDays: cooldownDays ?? this.cooldownDays,
      daysRemaining: daysRemaining ?? this.daysRemaining,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isEligible'] = isEligible;
    map['reason'] = reason;
    map['nextEligibleDate'] = nextEligibleDate;
    map['participationEnabled'] = participationEnabled;
    map['lastDonationDate'] = lastDonationDate;
    map['cooldownDays'] = cooldownDays;
    map['daysRemaining'] = daysRemaining;
    return map;
  }

}