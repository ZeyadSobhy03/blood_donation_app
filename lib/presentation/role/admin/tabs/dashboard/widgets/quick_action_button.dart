import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.onPressed,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 20,
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: onPressed,
      child: CustomText(
        text: text,
        textStyle: TextStyle(
          color: foregroundColor,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.semiBold,
        ),
      ),
    );
  }
}
