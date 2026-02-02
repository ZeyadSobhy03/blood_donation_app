import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/fonts/font_manger.dart';

class RoleCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String cardTitle;
  final String cardDesc;
  final String text;
  final void Function()? onPressed;
  final Color borderColor;

  const RoleCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.cardTitle,
    required this.cardDesc,
    required this.text,
    this.onPressed,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: ColorManger.pureWhite,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 28.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: cardTitle,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomText(
                        text: cardDesc,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            CustomElevatedButton(
              onPressed: onPressed,
              backgroundColor: iconColor,
              elevation: 2,
              foregroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Center(
                child: CustomText(
                  text: text,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    color: ColorManger.pureWhite,
                    fontWeight: FontWeightManager.medium,
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
