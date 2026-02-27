import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';

class DonorAvatar extends StatelessWidget {
  const DonorAvatar({super.key, required this.bloodType});

  final String bloodType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite_border,
            color: ColorManger.brightRed,
            size: 24,
          ),
        ),
        // Blood type chip overlapping bottom-right
        Positioned(
          bottom: -4,
          right: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: ColorManger.brightRed,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: CustomText(
              text: bloodType,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: 9,
                fontWeight: FontWeightManager.extraBold,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
