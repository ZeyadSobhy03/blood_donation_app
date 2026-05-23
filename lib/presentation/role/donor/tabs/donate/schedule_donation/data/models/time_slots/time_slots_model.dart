/// success : true
/// data : {"timeSlots":["09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM"],"hospitalId":"69f3df915f42685cbbbcbb1b","date":"2026-05-12T00:00:00.000Z","slotsPerHour":5}

class TimeSlotsModel {
  TimeSlotsModel({
      this.success, 
      this.data,});

  TimeSlotsModel.fromJson(dynamic json) {
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

/// timeSlots : ["09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM"]
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// date : "2026-05-12T00:00:00.000Z"
/// slotsPerHour : 5

class Data {
  Data({
      this.timeSlots, 
      this.hospitalId, 
      this.date, 
      this.slotsPerHour,});

  Data.fromJson(dynamic json) {
    timeSlots = json['timeSlots'] != null ? json['timeSlots'].cast<String>() : [];
    hospitalId = json['hospitalId'];
    date = json['date'];
    slotsPerHour = json['slotsPerHour'];
  }
  List<String>? timeSlots;
  String? hospitalId;
  String? date;
  int? slotsPerHour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timeSlots'] = timeSlots;
    map['hospitalId'] = hospitalId;
    map['date'] = date;
    map['slotsPerHour'] = slotsPerHour;
    return map;
  }

}