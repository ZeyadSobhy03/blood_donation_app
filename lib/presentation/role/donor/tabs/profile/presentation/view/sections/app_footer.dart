import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';




class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: 'LifeLink v1.0.0',
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: '© 2025 Smart Blood Donation App',
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}
