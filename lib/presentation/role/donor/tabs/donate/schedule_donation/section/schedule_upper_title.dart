import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class ScheduleUpperTitle extends StatelessWidget {
  const ScheduleUpperTitle({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: appLocalization.scheduleDonationTitle,
          textStyle: TextStyle(
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s16,
            color: ColorManger.black,
            height: 1.4,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalization.scheduleStepCounter(
            currentStep + 1,
            totalSteps,
          ),
          textStyle: TextStyle(
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s14,
            color: ColorManger.slateGrey,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
