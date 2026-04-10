import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserStatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const UserStatChip({
    super.key,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: CustomText(
        text: '$count $label',
        textStyle: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: color,
        ),
      ),
    );
  }
}
