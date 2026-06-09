import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.edit_outlined,
          size: 16, color: ColorManger.pureWhite),
      label: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.bold,
          color: ColorManger.pureWhite,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        backgroundColor: const Color(0xFFE67E22), // orange
        foregroundColor: ColorManger.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}