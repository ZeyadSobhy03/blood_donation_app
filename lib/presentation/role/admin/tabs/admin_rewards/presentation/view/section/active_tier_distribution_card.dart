import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/tier_data.dart';
import 'package:blood_donation_app/core/utils/tier_utils.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/custom_tier_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class ActiveTierDistributionCard extends StatelessWidget {
  const ActiveTierDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final Map<String, dynamic> tierData = {
      'Bronze': {'points': 150},
      'Silver': {'points': 300},
      'Gold': {'points': 50},
      "Platinum": {'points': 20},
    };
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.lightPurple.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: GridView.builder(
          itemCount: tierData.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final tierName = tierData.keys.elementAt(index);
            final totalPoints = tierData[tierName]['points'] as int;

            return CustomTierCard(
              mainColor: TierUtils.getColorForTier(tierName),
              totalPoints: totalPoints,
              tierName: localizeTier(tierName, loc),
            );
          },
        ),
      ),
    );
  }
}
