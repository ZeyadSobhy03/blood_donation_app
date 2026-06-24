import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class ManualPointsAdjustmentHeader extends StatelessWidget {
  const ManualPointsAdjustmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.electric_bolt,
          color: ColorManger.brightPurple,
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: loc.manualPointsAdjustment,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: loc.manualPointsAdjustmentDescription,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}