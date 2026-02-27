import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.isActive,
    required this.activeLabel,
    required this.inactiveLabel,
  });

  final bool isActive;
  final String activeLabel;
  final String inactiveLabel;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? ColorManger.green : ColorManger.slateGrey;
    final bgColor = isActive ? ColorManger.lightGreen : ColorManger.lightGrey;
    final dotColor = isActive
        ? ColorManger.green
        : ColorManger.slateGrey.withValues(alpha: 0.6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          CustomText(
            text: isActive ? activeLabel : inactiveLabel,
            textStyle: TextStyle(
              fontSize: FontSize.s10,
              color: color,
              fontWeight: FontWeightManager.semiBold,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
