import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.delete_outline,
          size: 16, color: ColorManger.brightRed),
      label: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.bold,
          color: ColorManger.brightRed,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}