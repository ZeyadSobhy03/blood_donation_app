import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';

class CustomHospitalButton extends StatelessWidget {
  const CustomHospitalButton({super.key,  this.onPressed, required this.widget});
  final void Function()? onPressed;
  final Widget widget;


  @override
  Widget build(BuildContext context) {
    return  CustomElevatedButton(
      backgroundColor: ColorManger.pureWhite,
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      onPressed: onPressed,

      foregroundColor: ColorManger.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(
              color: ColorManger.slateGrey.withValues(alpha: 0.1)
          )

      ),
      child: widget,
    );
  }
}
