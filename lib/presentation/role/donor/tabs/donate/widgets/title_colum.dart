import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleColum extends StatelessWidget {
  const TitleColum({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textStyle: TextStyle(
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.s16,
              color: ColorManger.pureWhite,
              height: 1.4,
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: subTitle,
            textStyle: TextStyle(
              fontWeight: FontWeightManager.regular,
              fontSize: FontSize.s15,
              color: ColorManger.pureWhite,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
