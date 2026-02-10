import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class StepInstructionTile extends StatelessWidget {
  const StepInstructionTile({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.subtitle,
  });

  final String stepNumber;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: CustomText(
            text: stepNumber,
            textStyle: TextStyle(
              color: ColorManger.brightRed,
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: subtitle,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
