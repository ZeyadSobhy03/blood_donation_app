import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';

class RewardsHeader extends StatelessWidget {
  const RewardsHeader({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    debugPrint('RewardsHeader direction = ${Directionality.of(context)}');

    return Container(
      color: ColorManger.pureWhite,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textStyle: TextStyle(
              color: ColorManger.brightPurple,
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.s18,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: description,
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}
