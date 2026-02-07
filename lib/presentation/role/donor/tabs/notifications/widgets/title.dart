import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class TitleOfNotification extends StatelessWidget {
  const TitleOfNotification({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title,textStyle: TextStyle(
          height: 1.4,
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.bold,

        ),)
        ,SizedBox(height: 4.h,),
        CustomText(text:subTitle,textStyle: TextStyle(
          height: 1.4,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.regular,

        ),)


      ],
    );
  }
}
