class HomeRequestDetailModel {
  HomeRequestDetailModel({this.success, this.message, this.data});

  HomeRequestDetailModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeRequestDetailData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeRequestDetailData? data;
}

class HomeRequestDetailData {
  HomeRequestDetailData({
    this.bloodTypes,
    this.unitsNeeded,
    this.urgency,
    this.timeRemaining,
    this.responded,
    this.confirmed,
    this.requiredBy,
    this.status,
    this.patientType,
    this.contactNumber,
    this.patientDetails,
  });

  HomeRequestDetailData.fromJson(dynamic json) {
    if (json['bloodTypes'] is List) {
      bloodTypes = (json['bloodTypes'] as List).cast<String>();
    } else if (json['bloodTypes'] is String) {
      bloodTypes = [json['bloodTypes']];
    }
    unitsNeeded   = (json['unitsNeeded'] as num?)?.toInt();
    urgency       = json['urgency'];
    timeRemaining = json['timeRemaining'];
    responded     = (json['responded']   as num?)?.toInt();
    confirmed     = (json['confirmed']   as num?)?.toInt();
    requiredBy    = json['requiredBy'] != null
        ? DateTime.tryParse(json['requiredBy'])
        : null;
    status         = json['status'];
    patientType    = json['patientType'];
    contactNumber  = json['contactNumber'];
    patientDetails = json['patientDetails'];
  }

  List<String>? bloodTypes;
  int? unitsNeeded;
  String? urgency;
  String? timeRemaining;
  int? responded;
  int? confirmed;
  DateTime? requiredBy;
  String? status;
  String? patientType;
  String? contactNumber;
  String? patientDetails;

  String get bloodTypeDisplay => bloodTypes?.join(', ') ?? '';
}
