import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';

class TitleStep extends StatelessWidget {
  const TitleStep({
    super.key,
    required this.title,
    required this.subTitle,
    this.textAlign,
    this.isCenter = false,
  });

  final String title;
  final String subTitle;
  final TextAlign? textAlign;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          textStyle: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: 8.h),
        CustomText(
          textAlign: textAlign,
          text: subTitle,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            color: ColorManger.slateGrey,
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
