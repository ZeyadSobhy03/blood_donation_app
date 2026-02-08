import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BloodFilter extends StatelessWidget {
  const BloodFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: 'Blood Type',
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
