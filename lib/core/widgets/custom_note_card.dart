import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNoteCard extends StatelessWidget {
  const CustomNoteCard({
    super.key,
    required this.title,
    required this.items,
    this.cardColor,
    this.borderColor,
    this.textColor,
    this.bulletColor,
    this.needIcon = false,
    this.icon,
  });

  final String title;
  final List<String> items;

  final Color? cardColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? bulletColor;
  final bool needIcon;

  final IconData? icon;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? ColorManger.lightCream,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: borderColor ?? ColorManger.goldBorder.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                needIcon
                    ? Icon(icon, color: textColor ?? cardColor, )
                    : SizedBox(),
                SizedBox(width: 8),
                CustomText(
                  text: title,
                  textStyle: TextStyle(
                    color: textColor ?? ColorManger.textGold,
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: '• ',
            textStyle: TextStyle(
              color: bulletColor,
              fontSize: FontSize.s22,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Expanded(
            child: CustomText(
              text: text,
              textStyle: TextStyle(color: textColor, fontSize: FontSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}
