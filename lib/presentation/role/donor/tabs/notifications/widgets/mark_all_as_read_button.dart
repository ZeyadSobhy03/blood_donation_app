import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class MarkAllAsReadButton extends StatelessWidget {
  const MarkAllAsReadButton({super.key, this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomElevatedButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(
                color: ColorManger.lightGrey
            )

        ),
        backgroundColor: ColorManger.pureWhite,
        foregroundColor: ColorManger.black,
        child: CustomText(text: text),


      ),
    );
  }
}
