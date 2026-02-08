import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/widgets/custom_text.dart';

class TitleRole extends StatelessWidget {
  const TitleRole({super.key, required this.roleTitle, required this.roleSubTitle});

  final String roleTitle;
  final String roleSubTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: roleTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: roleSubTitle,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
