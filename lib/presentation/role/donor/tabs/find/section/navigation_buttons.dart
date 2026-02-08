import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: ColorManger.brightRed,
          foregroundColor: ColorManger.pureWhite,
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 4.w),
              CustomText(
                text: 'Contact',
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
        CustomElevatedButton(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: ColorManger.pureWhite,
          foregroundColor: ColorManger.black,
          onPressed: () {},
          child: Row(
            children: [
              Transform.rotate(
                angle: -0.785,
                child: Icon(
                  Icons.send_rounded,

                  color: ColorManger.black,
                ),
              ),
              SizedBox(width: 4.w),
              CustomText(
                text: 'Navigate',
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
