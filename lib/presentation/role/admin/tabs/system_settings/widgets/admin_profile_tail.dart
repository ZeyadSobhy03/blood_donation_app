import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AdminProfileTail extends StatelessWidget {
  const AdminProfileTail({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,

        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.grey300),
        boxShadow: [
          BoxShadow(
            color: ColorManger.grey300.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            textStyle: TextStyle(
              color: ColorManger.grey700,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
             overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: ColorManger.green),
                SizedBox(width: 4),
              ],
              Expanded(
                child: CustomText(
                  text: value,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,

                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
