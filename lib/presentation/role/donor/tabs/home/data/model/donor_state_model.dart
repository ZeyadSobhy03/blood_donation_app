/// success : true
/// data : {"totalDonations":0,"points":0,"livesSaved":0}

class DonorStateModel {
  DonorStateModel({
      this.success, 
      this.data,});

  DonorStateModel.fromJson(dynamic json) {
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

/// totalDonations : 0
/// points : 0
/// livesSaved : 0

class Data {
  Data({
      this.totalDonations, 
      this.points, 
      this.livesSaved,});

  Data.fromJson(dynamic json) {
    totalDonations = json['totalDonations'];
    points = json['points'];
    livesSaved = json['livesSaved'];
  }
  int? totalDonations;
  int? points;
  int? livesSaved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalDonations'] = totalDonations;
    map['points'] = points;
    map['livesSaved'] = livesSaved;
    return map;
  }

}