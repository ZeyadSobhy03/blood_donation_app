class HomeUpdateRequestModel {
  HomeUpdateRequestModel({this.success, this.message, this.data});

  HomeUpdateRequestModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeUpdateRequestData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeUpdateRequestData? data;
}

class HomeUpdateRequestData {
  HomeUpdateRequestData({
    this.requiredBy,
    this.bloodTypes,
    this.unitsNeeded,
    this.urgency,
    this.timeRemaining,
    this.responded,
    this.confirmed,
  });

  HomeUpdateRequestData.fromJson(dynamic json) {
    requiredBy = json['requiredBy'] != null
        ? DateTime.tryParse(json['requiredBy'])
        : null;
    if (json['bloodTypes'] is List) {
      bloodTypes = (json['bloodTypes'] as List).cast<String>();
    }
    unitsNeeded   = (json['unitsNeeded'] as num?)?.toInt();
    urgency       = json['urgency'];
    timeRemaining = json['timeRemaining'];
    responded     = (json['responded'] as num?)?.toInt();
    confirmed     = (json['confirmed'] as num?)?.toInt();
  }

  DateTime? requiredBy;
  List<String>? bloodTypes;
  int? unitsNeeded;
  String? urgency;
  String? timeRemaining;
  int? responded;
  int? confirmed;
}
