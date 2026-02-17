import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SecurityTile extends StatelessWidget {
  const SecurityTile({
    super.key,
    required this.icon,
    this.subtitle,
    this.subtitleColor,
    required this.title, this.onTap,
  });

  final IconData icon;
  final String? subtitle;
  final String title;
  final Color? subtitleColor;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorManger.slateGrey, size: 20),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,

                  textStyle:  TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s14,
                  ),
                ),
                if (subtitle != null)
                  CustomText(
                    text: subtitle!,

                    textStyle: TextStyle(
                      color: subtitleColor ?? Colors.grey,
                      fontSize: 13,
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
