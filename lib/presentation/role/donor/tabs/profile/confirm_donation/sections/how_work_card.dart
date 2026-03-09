import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class HowWorkCard extends StatelessWidget {
  const HowWorkCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    List<String> steps = [
      loc.step_visit_hospital,
      loc.step_request_qr,
      loc.step_start_scanning,
      loc.step_point_camera,
      loc.step_wait_confirmation,
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.royalBlue.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      color: ColorManger.lightBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.how_it_works,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.royalBlue,
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              children: List.generate(
                steps.length,
                    (index) {
                  final step = steps[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '${index + 1}.',
                          textStyle: TextStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManger.royalBlue,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: CustomText(
                            text: step,
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManger.royalBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
