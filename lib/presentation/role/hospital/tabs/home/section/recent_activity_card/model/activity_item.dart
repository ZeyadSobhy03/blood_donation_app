import 'dart:ui';

enum ActivityStatus { complete, contact, active }

class ActivityItemModel {
  final String title;
  final String subtitle;
  final String time;
  final Color dotColor;
  final ActivityStatus status;
  final String contactNumber; // Optional field for contact number

  ActivityItemModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.dotColor,
    required this.status, required this.contactNumber,
  });
}
