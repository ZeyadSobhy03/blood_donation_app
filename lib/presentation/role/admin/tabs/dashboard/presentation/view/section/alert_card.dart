import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.type,
    required this.date,
    required this.title,
    required this.description,
  });

  final Color backgroundColor;
  final Color color;
  final String type;
  final String date;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: color.withValues(alpha: 0.45),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CustomText(
                      text: type,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  text: date,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            CustomText(
              text: title,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.bold,
                height: 1.4,
                letterSpacing: 0.9,
              ),
            ),
            SizedBox(height: 4),
            CustomText(
              text: description,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
                height: 1.4,
                letterSpacing: 0.9,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
