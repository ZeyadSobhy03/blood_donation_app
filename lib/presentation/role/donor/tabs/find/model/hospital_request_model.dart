import '../../../../../../core/resources/models/coordinates.dart';

class HospitalRequestModel {
  final String id;
  final String hospitalName;
  final String hospitalType;
  final String phoneNumber;

  final String bloodTypes;
  final bool isAvailable;

  final double distanceKm;
  final int urgentNeedsCount;

  final Coordinates location;

  const HospitalRequestModel({
    required this.id,
    required this.hospitalName,
    required this.hospitalType,
    required this.phoneNumber,
    required this.bloodTypes,
    required this.isAvailable,
    required this.distanceKm,
    required this.urgentNeedsCount,
    required this.location,
  });
}
