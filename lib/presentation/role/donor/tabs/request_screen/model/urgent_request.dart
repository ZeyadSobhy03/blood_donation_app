class UrgentRequestModel {
  final String id;

  final String title;
  final String location;
  final String time;
  final bool isEmergency;
  final String bloodType;
  final int unitsNeeded;

  /// Hospital
  final String hospitalName;
  final String hospitalDistance;

  /// Details
  final String patientType;
  final String contactNumber;

  UrgentRequestModel({
    required this.title,
    required this.location,
    required this.time,
    required this.isEmergency,
    required this.hospitalName,
    required this.patientType,
    required this.contactNumber,
    required this.unitsNeeded,
    required this.hospitalDistance,
    required this.bloodType,
    required this.id,
  });
}
