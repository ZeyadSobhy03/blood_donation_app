import 'package:flutter/material.dart';

enum BadgeStatus { earned, locked }

class BadgeData {
  final String label;
  final int points;
  final BadgeStatus status;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;

  const BadgeData({
    required this.label,
    required this.points,
    required this.status,
    required this.backgroundColor,
    required this.iconColor,
    required this.borderColor,
  });

  bool get isEarned => status == BadgeStatus.earned;
  bool get isLocked => status == BadgeStatus.locked;
}
