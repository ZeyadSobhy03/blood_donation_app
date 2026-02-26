import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDashboardCard extends StatelessWidget {
  const CustomDashboardCard({
    super.key,
    required this.borderColor,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.activeRequest,
    required this.title,
  });

  final Color borderColor;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final int activeRequest;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, size: 32.sp, color: iconColor,),
              SizedBox(height: 12.h),
            CustomText(
              text: '$activeRequest',
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                height: 1.4,
                color: iconColor,
              ),
            ),
              SizedBox(height: 12.h),
            CustomText(
              text: title,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                height: 1.4,
                color: ColorManger.slateGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
