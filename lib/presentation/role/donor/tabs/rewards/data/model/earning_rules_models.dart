/// success : true
/// data : [{"type":"blood_donation","title":"Blood Donation","points":200},{"type":"emergency_response","title":"Emergency Response","points":100},{"type":"profile_completion","title":"Profile Completion","points":50},{"type":"referral","title":"Referral","points":150}]

class EarningRulesModels {
  EarningRulesModels({
      this.success, 
      this.data,});

  EarningRulesModels.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "blood_donation"
/// title : "Blood Donation"
/// points : 200

class Data {
  Data({
      this.type, 
      this.title, 
      this.points,});

  Data.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    points = json['points'];
  }
  String? type;
  String? title;
  int? points;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['points'] = points;
    return map;
  }

}