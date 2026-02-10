import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;


  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(
          icon,
          color: ColorManger.slateGrey,
          size: 18,
        ),
        SizedBox(width: 4.w,),
        CustomText(text: text,textStyle: TextStyle(
          color: ColorManger.slateGrey,
          fontWeight: FontWeightManager.regular,
          fontSize: FontSize.s14,
          height: 1.4,
        ),)
      ],
    );
  }
}
