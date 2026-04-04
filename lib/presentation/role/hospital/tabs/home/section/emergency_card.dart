import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.brightRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  size: 28.sp.clamp(24, 32),
                  color: ColorManger.pureWhite,
                ),
                SizedBox(width: 12),
                CustomText(
                  text: appLocalizations.emergency_request,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.pureWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: appLocalizations.emergency_description,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.pureWhite,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              elevation: 4,
              backgroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              foregroundColor: ColorManger.brightRed,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RequestDialog(),
                );
              },
              child: CustomText(
                text: appLocalizations.create_emergency_request,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.brightRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
