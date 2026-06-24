import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/tier_data.dart';
import 'package:blood_donation_app/core/utils/tier_utils.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/custom_tier_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class ActiveTierDistributionCard extends StatelessWidget {
  const ActiveTierDistributionCard({super.key, required this.tiers});

  final List<Tiers> tiers;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
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
          itemCount: tiers.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final tier = tiers[index];
            final tierName = tier.tierName ?? '';
            final userCount = tier.userCount ?? 0;

            return CustomTierCard(
              mainColor: TierUtils.getColorForTier(tierName),
              totalPoints: userCount,
              tierName: localizeTier(tierName, loc),
            );
          },
        ),
      ),
    );
  }
}
