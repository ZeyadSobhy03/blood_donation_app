import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class SecurityNoticeCard extends StatelessWidget {
  const SecurityNoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.yellow.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  color: ColorManger.orange,
                  size: 24,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: loc.security_notice,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManger.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: loc.security_notice_message,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
