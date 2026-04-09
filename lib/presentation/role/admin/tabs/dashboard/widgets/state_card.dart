import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.icon,
    required this.percentage,
    required this.totalDonor,
    required this.text,
  });

  final Color backgroundColor;
  final Color color;
  final IconData icon;
  final String percentage;
  final int totalDonor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: backgroundColor.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 22),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManger.lightGrey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: CustomText(
                      text: percentage,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomText(
              text: '$totalDonor',
              textStyle: TextStyle(
                color: color,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            CustomText(
              text: text,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
