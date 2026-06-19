import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SystemStatusCard extends StatelessWidget {
  const SystemStatusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.bgColor,
    required this.statusColor,
  });

  final String title;
  final String subtitle;
  final String status;
  final Color bgColor;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: 4),
                CustomText(
                  text: subtitle,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12),
              ),

              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CustomText(
                text: status,
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
