/// success : true
/// message : "Earning rule updated"
/// data : {"_id":"664a123456789abcdef12399","type":"bloodDonation","title":"Blood Donation","points":250,"category":"donation","isActive":true}

class EarningRuleUpdatedModel {
  EarningRuleUpdatedModel({
      this.success, 
      this.message, 
      this.data,});

  EarningRuleUpdatedModel.fromJson(dynamic json) {
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

/// _id : "664a123456789abcdef12399"
/// type : "bloodDonation"
/// title : "Blood Donation"
/// points : 250
/// category : "donation"
/// isActive : true

class Data {
  Data({
      this.id, 
      this.type, 
      this.title, 
      this.points, 
      this.category, 
      this.isActive,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    title = json['title'];
    points = json['points'];
    category = json['category'];
    isActive = json['isActive'];
  }
  String? id;
  String? type;
  String? title;
  int? points;
  String? category;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['type'] = type;
    map['title'] = title;
    map['points'] = points;
    map['category'] = category;
    map['isActive'] = isActive;
    return map;
  }

}