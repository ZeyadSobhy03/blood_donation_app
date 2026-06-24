/// success : true
/// message : "Participation preference updated successfully"
/// data : {"_id":"66f100000000000000000002","fullName":"Aya Hassan","isOptedIn":false}

class ParticipationPreferenceModel {
  ParticipationPreferenceModel({
      this.success, 
      this.message, 
      this.data,});

  ParticipationPreferenceModel.fromJson(dynamic json) {
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

/// _id : "66f100000000000000000002"
/// fullName : "Aya Hassan"
/// isOptedIn : false

class Data {
  Data({
      this.id, 
      this.fullName, 
      this.isOptedIn,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    isOptedIn = json['isOptedIn'];
  }
  String? id;
  String? fullName;
  bool? isOptedIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['isOptedIn'] = isOptedIn;
    return map;
  }

}