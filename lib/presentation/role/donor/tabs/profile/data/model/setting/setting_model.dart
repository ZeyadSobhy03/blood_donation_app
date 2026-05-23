/// success : true
/// data : {"settings":{"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"}}

class SettingModel {
  SettingModel({
      this.success, 
      this.data,});

  SettingModel.fromJson(dynamic json) {
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

/// settings : {"pushNotifications":true,"emergencyAlerts":true,"privacyMode":false,"language":"en"}

class Data {
  Data({
      this.settings,});

  Data.fromJson(dynamic json) {
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }
  Settings? settings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    return map;
  }

}

/// pushNotifications : true
/// emergencyAlerts : true
/// privacyMode : false
/// language : "en"

class Settings {
  Settings({
      this.pushNotifications, 
      this.emergencyAlerts, 
      this.privacyMode, 
      this.language,});

  Settings.fromJson(dynamic json) {
    pushNotifications = json['pushNotifications'];
    emergencyAlerts = json['emergencyAlerts'];
    privacyMode = json['privacyMode'];
    language = json['language'];
  }
  bool? pushNotifications;
  bool? emergencyAlerts;
  bool? privacyMode;
  String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushNotifications'] = pushNotifications;
    map['emergencyAlerts'] = emergencyAlerts;
    map['privacyMode'] = privacyMode;
    map['language'] = language;
    return map;
  }

}