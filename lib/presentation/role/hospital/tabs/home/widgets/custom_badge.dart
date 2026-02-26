import 'package:flutter/material.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.fontColor, required this.borderColor,
  });

  final String text;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        border: Border.all(
          color:borderColor,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: CustomText(
        text: text,
        textStyle: TextStyle(
          color: fontColor,
          fontSize: FontSize.s14,
          height: 1.4,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    );
  }
}
