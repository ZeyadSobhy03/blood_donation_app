import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class UpperTitle extends StatelessWidget {
  const UpperTitle({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: title,
          textStyle: TextStyle(
            color: ColorManger.brightRed,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s20,
            height: 1.6,
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: CustomText(
            text: subTitle,
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: ColorManger.slateGrey,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
