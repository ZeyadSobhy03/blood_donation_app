/// success : true
/// message : "Earning rules retrieved"
/// data : [{"_id":"664a123456789abcdef12399","type":"bloodDonation","title":"Blood Donation","points":200,"category":"donation","isActive":true},{"_id":"664a123456789abcdef123aa","type":"plasmaDonation","title":"Plasma Donation","points":150,"category":"donation","isActive":true}]

class EarningRuleModel {
  EarningRuleModel({
      this.success, 
      this.message, 
      this.data,});

  EarningRuleModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "664a123456789abcdef12399"
/// type : "bloodDonation"
/// title : "Blood Donation"
/// points : 200
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