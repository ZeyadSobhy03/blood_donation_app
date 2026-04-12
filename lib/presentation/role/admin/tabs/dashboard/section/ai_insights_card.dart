import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/insight_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final aiInsights = [
      InsightCard(
        title: appLocalization.predictedHighDemand,
        description: appLocalization.predictedHighDemandDesc,
        confidence: 40,
      ),
      InsightCard(
        title: appLocalization.shortageRisk,
        description: appLocalization.shortageRiskDesc,
        confidence: 92,
      ),
    ];
    return Card(
      color: ColorManger.lightBlue,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.royalBlue.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.safety_check_outlined,
                  color: ColorManger.royalBlue,
                  size: 22,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: appLocalization.aiInsights,
                  textStyle: TextStyle(
                    color: ColorManger.royalBlue,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            ListView.builder(
              itemCount: aiInsights.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: aiInsights[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
