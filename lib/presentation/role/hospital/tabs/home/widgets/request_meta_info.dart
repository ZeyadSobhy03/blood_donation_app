import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class RequestMetaInfo extends StatelessWidget {
  const RequestMetaInfo({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: ColorManger.slateGrey,
        ),
        SizedBox(width: 4.w),
        CustomText(
          text: label,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s14,
            height: 1.4,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
