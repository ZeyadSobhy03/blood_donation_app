class RequestModel {
  RequestModel({this.success, this.message, this.data});

  RequestModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CreatedRequestData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  CreatedRequestData? data;
}

class CreatedRequestData {
  CreatedRequestData({
    this.id,
    this.type,
    this.bloodType,
    this.urgency,
    this.requiredBy,
    this.quantity,
    this.unitsNeeded,
    this.patientType,
    this.contactNumber,
    this.isEmergency,
    this.notes,
    this.hospitalName,
    this.status,
  });

  CreatedRequestData.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    final rawBloodType = json['bloodType'];
    if (rawBloodType is List) {
      bloodType = rawBloodType.cast<String>();
    } else if (rawBloodType is String) {
      bloodType = [rawBloodType];
    }

    urgency = json['urgency'];
    requiredBy = json['requiredBy'] != null
        ? DateTime.tryParse(json['requiredBy'])
        : null;
    quantity = (json['quantity'] as num?)?.toInt();
    unitsNeeded = (json['unitsNeeded'] as num?)?.toInt();
    patientType = json['patientType'];
    contactNumber = json['contactNumber'];
    isEmergency = json['isEmergency'];
    notes = json['notes'];
    status = json['status'] ?? json['requestStatus'];

    final rawHospital = json['hospitalId'];
    if (rawHospital is Map) {
      hospitalName = rawHospital['hospitalName'];
    }
  }

  String? id;
  String? type;
  List<String>? bloodType;
  String? urgency;
  DateTime? requiredBy;
  int? quantity;
  int? unitsNeeded;
  String? patientType;
  String? contactNumber;
  bool? isEmergency;
  String? notes;
  String? hospitalName;
  String? status;

  String get bloodTypeDisplay => bloodType?.join(', ') ?? '';
}