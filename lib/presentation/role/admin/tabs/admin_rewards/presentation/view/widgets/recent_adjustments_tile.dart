import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RecentAdjustmentsTile extends StatelessWidget {
  const RecentAdjustmentsTile({
    super.key,
    required this.points,
    required this.reason,
    required this.date,
    required this.userName,
  });

  final int points;
  final String reason;
  final String date;
  final String userName;

  bool get _isPositive => points >= 0;

  @override
  Widget build(BuildContext context) {
    final adjustmentColor = _isPositive ? ColorManger.green : ColorManger.brightRed;
    final pointsText = _isPositive ? '+$points pts' : '$points pts';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: adjustmentColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isPositive ? Icons.add : Icons.remove,
              color: adjustmentColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: userName,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: reason,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: pointsText,
                textStyle: TextStyle(
                  color: adjustmentColor,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              const SizedBox(height: 2),
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
        ],
      ),
    );
  }
}