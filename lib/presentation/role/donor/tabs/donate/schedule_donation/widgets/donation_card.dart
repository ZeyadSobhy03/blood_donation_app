import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationCard extends StatelessWidget {
  const DonationCard({
    super.key,
    required this.title,
    required this.items,
    this.cardColor,
    this.borderColor,
    this.textColor,
    this.bulletColor,
  });

  final String title;
  final List<String> items;

  final Color? cardColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? bulletColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? ColorManger.lightCream,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: borderColor ?? ColorManger.goldBorder,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              textStyle: TextStyle(
                color: textColor ?? ColorManger.textGold,
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            SizedBox(height: 20.h),

            ...items.map(
                  (item) => _buildListItem(
                item,
                textColor ?? ColorManger.textGold,
                bulletColor ?? ColorManger.bulletBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text, Color textColor, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: '• ',
            textStyle: TextStyle(
              color: bulletColor,
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Expanded(
            child: CustomText(
              text: text,
              textStyle: TextStyle(
                color: textColor,
                fontSize: FontSize.s16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

