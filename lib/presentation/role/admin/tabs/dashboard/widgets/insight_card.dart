import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.confidence,
  });

  final String title;
  final String description;
  final double confidence;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      shadowColor: Colors.black.withValues(alpha: 0.05),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: ColorManger.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              textStyle: TextStyle(
                color: ColorManger.royalBlue,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
            SizedBox(height: 4),
            CustomText(
              text: description,
              textStyle: TextStyle(
                color: ColorManger.royalBlue,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 4),
            LinearProgressIndicator(
              minHeight: 8,

              color: ColorManger.darkBlue,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: ColorManger.lightGrey.withValues(alpha: 0.5),
              value: confidence / 100,
            ),
            SizedBox(height: 4),
            CustomText(
              text: appLocalization.confidencePercentage(confidence.toInt()),
              textStyle: TextStyle(
                color: ColorManger.royalBlue,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
