import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCustomCard extends StatelessWidget {
  const HomeCustomCard({
    super.key,
    required this.number,
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  final int number;
  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width:  screenWidth * 0.25,
      child: Card(
        elevation: 6,
        color: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 30),
                SizedBox(height: 8.h),
                CustomText(
                  text: '$number',
                  textStyle: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    height: 1.4,
                    fontSize: FontSize.s16,
                    color: ColorManger.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: text,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.slateGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
