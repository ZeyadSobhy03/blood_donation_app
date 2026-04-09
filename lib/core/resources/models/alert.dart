class AlertModel {
  final String title;
  final String type;
  final DateTime date;
  final String description;
  final String id;
  final String hospitalId;
  final String? hospitalName;
  final String location;
  final double? latitude;
  final double? longitude;
  final int unitsNeeded;
  final List<String> bloodTypesNeeded;
  final String hospitalContact;
  final DateTime createdAt;
  final double? predictMatchPercentage;

  AlertModel({
    required this.title,
    required this.type,
    required this.date,
    required this.description,
    required this.id,
    required this.hospitalId,
    this.hospitalName,
    required this.location,
    this.latitude,
    this.longitude,
    required this.unitsNeeded,
    required this.bloodTypesNeeded,
    required this.hospitalContact,
    required this.createdAt,
    this.predictMatchPercentage,
  });
}
