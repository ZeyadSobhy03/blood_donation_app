import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CustomText(
                  text: label,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(height: 4),
                CustomText(
                  text: value,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
