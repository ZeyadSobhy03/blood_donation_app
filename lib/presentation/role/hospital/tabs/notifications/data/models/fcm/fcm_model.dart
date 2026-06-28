class FcmModel {
  FcmModel({this.success, this.data});

  FcmModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? FcmData.fromJson(json['data']) : null;
  }
  bool? success;
  FcmData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class FcmData {
  FcmData({this.fcmToken, this.tokenCount});

  FcmData.fromJson(dynamic json) {
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
