import 'package:flutter/material.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';

class ScheduleLinearProgressIndicator extends StatelessWidget {
  const ScheduleLinearProgressIndicator({super.key, required this.currentStep, required this.totalSteps});
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearProgressIndicator(
        minHeight: 8,
        backgroundColor: ColorManger.lightGrey,
        value: (currentStep + 1) / totalSteps,
        valueColor: AlwaysStoppedAnimation<Color>(ColorManger.brightRed),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
