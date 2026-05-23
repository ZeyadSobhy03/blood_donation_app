import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../../../../core/widgets/custom_text.dart';




class ProfileRow extends StatelessWidget {
  const ProfileRow({super.key, required this.label, required this.widget});

  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: CustomText(
              text: label,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
              ),
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(child: widget),
        ],
      ),
    );
  }
}
