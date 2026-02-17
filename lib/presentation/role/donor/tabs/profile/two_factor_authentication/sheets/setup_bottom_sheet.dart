import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const SetupBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManger.lightGrey,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 24.h),
        
            // Icon
            Container(
              padding: EdgeInsets.all(16.w),
              decoration:  BoxDecoration(
                color: ColorManger.errorLightBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: ColorManger.brightRed, size: 32.sp),
            ),
            SizedBox(height: 16.h),
        
            // Title
            CustomText(
              text: '${appLocalization.setupTitle} $title',
              textStyle: TextStyle(
                color: ColorManger.darkBlue,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 8.h),
        
            // Description
            CustomText(
              text: description,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s13,
                height: 1.6,
              ),
            ),
            SizedBox(height: 28.h),
        
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: CustomElevatedButton(
                backgroundColor:ColorManger.brightRed,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 4,
        
        
                onPressed: () => Navigator.pop(context),
                child: CustomText(
                  text: appLocalization.continueStep,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
        
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 4,
                onPressed: () => Navigator.pop(context),
                child: CustomText(
                  text: appLocalization.cancel,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}