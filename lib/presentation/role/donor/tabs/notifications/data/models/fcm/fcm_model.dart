/// success : true
/// data : {"fcmToken":"111111111111111111","tokenCount":1}

class FcmModel {
  FcmModel({
      this.success, 
      this.data,});

  FcmModel.fromJson(dynamic json) {
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

/// fcmToken : "111111111111111111"
/// tokenCount : 1

class Data {
  Data({
      this.fcmToken, 
      this.tokenCount,});

  Data.fromJson(dynamic json) {
    fcmToken = json['fcmToken'];
    tokenCount = json['tokenCount'];
  }
  String? fcmToken;
  int? tokenCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fcmToken'] = fcmToken;
    map['tokenCount'] = tokenCount;
    return map;
  }

}