import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManger.warningBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManger.warningBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: ColorManger.warningAccent,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              text: appLocalization.twoFactorSecurityInfo,
              textStyle: TextStyle(
                color: ColorManger.warningText,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
