import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class CameraContainer extends StatelessWidget {
  const CameraContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.lightGrey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorManger.lightGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: ColorManger.slateGrey,
              size: 48,
            ),
            SizedBox(height: 8.h),

            CustomText(
              text: loc.camera_ready,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 4.h),

            CustomText(
              text: loc.tap_to_start,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
