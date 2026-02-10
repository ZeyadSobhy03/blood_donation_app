import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/step_instruction_tile.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization =  AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.whatToExpect,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 16.h),
            StepInstructionTile(
              stepNumber: '1',
              title: appLocalization.instructionStep1Title,
              subtitle: appLocalization.instructionStep1Subtitle,
            ),
            SizedBox(height: 16.h),
            StepInstructionTile(
              stepNumber: '2',
              title: appLocalization.instructionStep2Title,
              subtitle: appLocalization.instructionStep2Subtitle,
            ),
            SizedBox(height: 16.h),
            StepInstructionTile(
              stepNumber: '3',
              title: appLocalization.instructionStep3Title,
              subtitle: appLocalization.instructionStep3Subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
