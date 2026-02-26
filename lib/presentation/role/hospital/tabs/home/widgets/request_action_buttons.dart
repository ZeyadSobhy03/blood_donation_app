import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.onPressed,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      elevation: 4,
      foregroundColor: foregroundColor,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: 1),
      ),
      backgroundColor: backgroundColor,
      child: CustomText(
        text: text,
        textStyle: TextStyle(
          color: foregroundColor,
          fontSize: FontSize.s14,
          height: 1.4,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    );
  }
}
