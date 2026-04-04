import 'blood_request.dart';

class BloodRequestHistoryModel {
  final String bloodType;
  final int units;
  final DateTime date;
  final String priority;
  final String status;
  final bool isFulfilled;
  final BloodRequestModel bloodRequestModel;

  BloodRequestHistoryModel({

    required this.bloodType,
    required this.units,
    required this.date,
    required this.priority,
    required this.status,
    required this.isFulfilled, required this.bloodRequestModel,
  });
}
