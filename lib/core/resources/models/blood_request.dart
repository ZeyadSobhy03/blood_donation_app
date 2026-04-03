class BloodRequestModel {
  final String bloodType;
  final int unitsRequested;
  final String urgencyLevel;
  final int donorsContacted;
  final int donorsConfirmed;
  final bool isFulfilled;
  final DateTime requestDate;
  final int completionTimeInHours;

  BloodRequestModel({
    required this.bloodType,
    required this.unitsRequested,
    required this.urgencyLevel,
    required this.donorsContacted,
    required this.donorsConfirmed,
    required this.isFulfilled,
    required this.requestDate,
    required this.completionTimeInHours,
  });
}
