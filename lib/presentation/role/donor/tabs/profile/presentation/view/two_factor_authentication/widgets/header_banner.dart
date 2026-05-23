import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorManger.primaryRedDark, ColorManger.primaryRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManger.black.withAlpha(100),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w.clamp(8, 12)),
            decoration: BoxDecoration(
              color: ColorManger.pureWhite.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: ColorManger.pureWhite,
              size: 28,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: appLocalization.protectYourAccount,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s15,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: appLocalization.twoFactorDescription,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite.withValues(alpha: 0.85),
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
