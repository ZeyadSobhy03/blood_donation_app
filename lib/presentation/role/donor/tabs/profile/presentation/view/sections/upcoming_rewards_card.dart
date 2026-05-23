import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class UpcomingRewardsCard extends StatelessWidget {
  const UpcomingRewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),

       side: BorderSide(color: ColorManger.royalBlue, width: 1)
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(
              text: appLocalization.upcoming_rewards,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManger.royalBlue,
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              text: appLocalization.gold_badge_reward,
              textStyle: TextStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.royalBlue,
              ),
            ),
            const SizedBox(height: 4),
            CustomText(
              text: appLocalization.platinum_badge_reward,
              textStyle: TextStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.royalBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
