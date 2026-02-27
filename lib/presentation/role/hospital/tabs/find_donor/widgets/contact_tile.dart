import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.buttonText,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final String value;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManger.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: ColorManger.royalBlue, size: 20),
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManger.lightGrey, width: 1),
            ),
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.black,
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: CustomText(
              text: buttonText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}