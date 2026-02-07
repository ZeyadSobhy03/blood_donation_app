import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class BloodNeedCard extends StatelessWidget {
  const BloodNeedCard({
    super.key,
    required this.bloodType,
    required this.background,
  });

  final String bloodType;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      color: background,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.pureWhite.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        child: Column(
          children: [
            Icon(
              Icons.favorite_border,
              color: ColorManger.pureWhite,
              size: 30.sp,
            ),

            SizedBox(height: 12.h),

            CustomText(
              text: bloodType,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s22,
                fontWeight: FontWeightManager.bold,
              ),
            ),

            SizedBox(height: 8.h),

            CustomText(
              text: appLocalizations.bloodTypeNeeded,
              textStyle: TextStyle(
                color: ColorManger.pureWhite.withValues(alpha: 0.9),
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.medium,
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 7.h,
                  width: 7.h,
                  decoration: const BoxDecoration(
                    color: ColorManger.pureWhite,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                CustomText(
                  text: appLocalizations.urgentRequestActive,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
