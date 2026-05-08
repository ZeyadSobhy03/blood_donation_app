import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({
    super.key,
    required this.text,
    required this.time,
  });

  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: ColorManger.brightRed,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CustomText(
              text: text,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: time,
            textStyle: TextStyle(
              color: ColorManger.slateGrey.withValues(alpha: 0.6),
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}
