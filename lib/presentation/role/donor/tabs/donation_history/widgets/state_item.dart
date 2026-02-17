import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class StateItem extends StatelessWidget {
  const StateItem({super.key, required this.label, required this.value, required this.subLabel});
  final String label;
  final int value;
  final String subLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: label,
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManger.pureWhite,
            ),
          ),
          CustomText(
            text: '$value',
            textStyle: TextStyle(
              fontSize: FontSize.s24,
              fontWeight: FontWeightManager.extraBold,
              color: ColorManger.pureWhite,
            ),
          ),
          CustomText(
            text: subLabel,
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManger.pureWhite,
            ),
          ),

        ],
      ),
    );
  }
}
