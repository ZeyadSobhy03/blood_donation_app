import 'package:flutter/material.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        CustomText(
          text: label,
          textStyle: TextStyle(
            fontSize: FontSize.s13,
            color: ColorManger.grey600,
          ),
        ),
        CustomText(
          text: value,
          textStyle: TextStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.medium,
            color: ColorManger.black,
          ),
        ),
      ],
    );
  }
}
