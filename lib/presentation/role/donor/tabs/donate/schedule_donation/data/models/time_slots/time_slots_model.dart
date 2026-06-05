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

/// timeSlots : [{"time":"09:00 AM","remainingCapacity":5,"maxCapacity":5},{"time":"10:00 AM","remainingCapacity":3,"maxCapacity":5}]
/// or simple format: ["09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM"]
/// hospitalId : "69f3df915f42685cbbbcbb1b"
/// date : "2026-05-12T00:00:00.000Z"
/// slotsPerHour : 5

class Data {
  Data({
      this.timeSlots, 
      this.timeSlotDetails,
      this.hospitalId, 
      this.date, 
      this.slotsPerHour,});

  Data.fromJson(dynamic json) {
    timeSlotDetails = [];
    
    // Handle both simple string format and detailed object format
    if (json['timeSlots'] != null) {
      final slots = json['timeSlots'] as List<dynamic>;
      
      for (var slot in slots) {
        if (slot is String) {
          // Simple time format
          timeSlotDetails!.add(TimeSlotDetail(
            time: slot,
            remainingCapacity: null,
            maxCapacity: null,
          ));
        } else if (slot is Map<String, dynamic>) {
          // Detailed format with capacity
          timeSlotDetails!.add(TimeSlotDetail.fromJson(slot));
        }
      }
    }
    
    timeSlots = timeSlotDetails!.map((detail) => detail.time).toList();
    hospitalId = json['hospitalId'];
    date = json['date'];
    slotsPerHour = json['slotsPerHour'];
  }
  
  List<String>? timeSlots;
  List<TimeSlotDetail>? timeSlotDetails;
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

/// Time Slot Detail with capacity information
class TimeSlotDetail {
  TimeSlotDetail({
    required this.time,
    this.remainingCapacity,
    this.maxCapacity,
  });

  TimeSlotDetail.fromJson(dynamic json)
    : time = json['time'] ?? '',
      remainingCapacity = json['remainingCapacity'],
      maxCapacity = json['maxCapacity'];

  final String time;
  final int? remainingCapacity;
  final int? maxCapacity;

  bool get isAvailable => remainingCapacity == null || remainingCapacity! > 0;
  bool get isFull => remainingCapacity != null && remainingCapacity! <= 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    if (remainingCapacity != null) map['remainingCapacity'] = remainingCapacity;
    if (maxCapacity != null) map['maxCapacity'] = maxCapacity;
    return map;
  }
}