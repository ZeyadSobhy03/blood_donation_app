import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRewardTile extends StatelessWidget {
  const CustomRewardTile({
    super.key,
    required this.rewardName,
    required this.rewardSubtitle,
    required this.pointsRedeemed,
    required this.prefixWidget,
    required this.label,
    this.isEditing = false,
    this.pointsController,
  });

  final String rewardName;
  final String rewardSubtitle;
  final int pointsRedeemed;
  final Widget prefixWidget;
  final String label;
  final bool isEditing;
  final TextEditingController? pointsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefixWidget,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: rewardName,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
              const SizedBox(height: 2),
              CustomText(
                text: rewardSubtitle,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
        if (isEditing)
          SizedBox(
            width: 90,
            height: 40,
            child: TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.medium,
              ),
              decoration: InputDecoration(
                suffixText: label,
                suffixStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManger.lightPurple.withValues(alpha: 0.7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManger.lightPurple.withValues(alpha: 0.7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManger.brightPurple, width: 1.5),
                ),
              ),
            ),
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: '$pointsRedeemed',
                textStyle: TextStyle(
                  color: ColorManger.brightPurple,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: label,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
      ],
    );
  }
}