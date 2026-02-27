import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      onPressed: onPressed,
      backgroundColor: ColorManger.skyBlue,
      foregroundColor: ColorManger.pureWhite,
      child: CustomText(
        text: label,
        textStyle: TextStyle(
          color: ColorManger.pureWhite,
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
