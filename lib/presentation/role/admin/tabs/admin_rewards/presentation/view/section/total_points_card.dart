import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class TotalPointsCard extends StatelessWidget {
  const TotalPointsCard({
    super.key,
    required this.totalPoints,
    required this.percentage,
  });

  final int totalPoints;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightPurple.withValues(
          alpha: 0.7,
        ), width: 1.1),
      ),
      elevation: 0,
      color: ColorManger.pureWhite,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.trending_up, color: ColorManger.brightPurple, size: 32),
              const SizedBox(height: 8),
              CustomText(
                text: '$totalPoints',
                textStyle: TextStyle(
                  color: ColorManger.brightPurple,
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                text: appLocalization.total_points,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              const SizedBox(height: 12),
              CustomText(
                text:
                    '${(percentage * 100).toStringAsFixed(1)}% ${appLocalization.increase_from_last_month}',
                textStyle: TextStyle(
                  color: percentage >= 0
                      ? ColorManger.green
                      : ColorManger.brightRed,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
