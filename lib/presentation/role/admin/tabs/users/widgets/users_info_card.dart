import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UsersInfoCard extends StatelessWidget {
  const UsersInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 32, color: iconColor),
            SizedBox(height: 8),
            CustomText(
              text: value,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManger.black,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 8),
            CustomText(
              text: label,
              textStyle: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManger.slateGrey,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
