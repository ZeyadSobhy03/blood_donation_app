import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        text: label,
        textStyle: TextStyle(
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.semiBold,
          height: 1.4,
          color: ColorManger.black,
        ),
      ),
    );
  }
}
