import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTierCard extends StatelessWidget {
  const CustomTierCard({
    super.key,
    required this.mainColor,
    required this.totalPoints,
    required this.tierName,
  });

  final Color mainColor;

  final int totalPoints;

  final String tierName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: mainColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: mainColor.withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            Icon(Icons.star_border, color: mainColor, size: 32),
            SizedBox(height: 14),
            CustomText(
              text: '$totalPoints',
              textStyle: TextStyle(
                color: mainColor,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            SizedBox(height: 14),
            CustomText(
              text: tierName,
              textStyle: TextStyle(color: ColorManger.slateGrey),
            ),
          ],
        ),
      ),
    );
  }
}
