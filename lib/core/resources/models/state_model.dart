import 'package:flutter/cupertino.dart';

class StateModel {
  final String text;
  final int totalDonor;
  final String percentage;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  StateModel({
    required this.text,
    required this.totalDonor,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}
