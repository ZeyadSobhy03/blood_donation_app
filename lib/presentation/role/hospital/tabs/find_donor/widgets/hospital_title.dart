import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../core/widgets/language_toggle.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title, required this.subTitle, this.hasIcon = false});
  final String title;
  final String subTitle;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: hasIcon ?Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                textStyle: TextStyle(
                  fontWeight: FontWeightManager.extraBold,
                  fontSize: FontSize.s20,
                  color: ColorManger.black,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: subTitle,
                textStyle: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s15,
                  color: ColorManger.slateGrey,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.h),
              LanguageToggle(
                activeColor: ColorManger.brightPurple,

              )
            ],
          ),


        ],
      ) :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textStyle: TextStyle(
              fontWeight: FontWeightManager.extraBold,
              fontSize: FontSize.s20,
              color: ColorManger.black,
              height: 1.4,
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: subTitle,
            textStyle: TextStyle(
              fontWeight: FontWeightManager.regular,
              fontSize: FontSize.s15,
              color: ColorManger.slateGrey,
              height: 1.4,
            ),
          ),

        ],
      ),
    );
  }
}
