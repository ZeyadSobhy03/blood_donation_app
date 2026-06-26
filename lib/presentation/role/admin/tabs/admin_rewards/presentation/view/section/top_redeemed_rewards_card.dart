
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/custom_reward_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/rewards_localizer.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class TopRedeemedRewardsCard extends StatelessWidget {
  const TopRedeemedRewardsCard({super.key, required this.topRedeemed});

  final List<TopRedeemed> topRedeemed;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Card(
      elevation: 0,
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.lightPurple.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.topRedeemedRewards,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: topRedeemed.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reward = topRedeemed[index];
                final localizedReward = localizeReward(
                  context,
                  rawTitle: reward.rewardName ?? '',
                  rawDescription: reward.rewardSubtitle ?? '',
                  rawStatus: '',
                  rawCategory: '',
                );
                final rank = index + 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CustomRewardTile(
                    rewardName: localizedReward.title,
                    rewardSubtitle: localizedReward.description,
                    pointsRedeemed: reward.pointsRedeemed ?? 0,
                    prefixWidget: _RankBadge(rank: rank),
                    label: loc.redeem,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorManger.brightPurple.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: CustomText(
        text: '$rank',
        textStyle: TextStyle(
          color: ColorManger.black,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    );
  }
}
