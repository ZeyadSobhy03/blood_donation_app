import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequirementRow extends StatelessWidget {
  const RequirementRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, color: ColorManger.green,size: 20),
          SizedBox(width: 10.w),
          CustomText(
            text: text,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
