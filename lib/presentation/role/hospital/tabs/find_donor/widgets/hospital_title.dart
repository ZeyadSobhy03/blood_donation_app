import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class HospitalTitle extends StatelessWidget {
  const HospitalTitle({super.key, required this.title, required this.subTitle});
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
