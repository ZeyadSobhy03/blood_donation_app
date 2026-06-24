import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/custom_reward_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class TopRedeemedRewardsCard extends StatelessWidget {
  const TopRedeemedRewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> rewardsData = [
      {
        'rewardName': 'Free Health Checkup',
        'rewardSubtitle': 'Voucher',
        'pointsRedeemed': 120,
      },
      {
        'rewardName': 'Blood Donor T-Shirt',
        'rewardSubtitle': 'Merchandise',
        'pointsRedeemed': 95,
      },
      {
        'rewardName': 'Pharmacy Discount',
        'rewardSubtitle': '15% Off',
        'pointsRedeemed': 80,
      },
      {
        'rewardName': 'Gym Membership',
        'rewardSubtitle': '1 Month',
        'pointsRedeemed': 60,
      },
      {
        'rewardName': 'Coffee Shop Voucher',
        'rewardSubtitle': 'Free Drink',
        'pointsRedeemed': 45,
      },
    ];

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
              itemCount: rewardsData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reward = rewardsData[index];
                final rank = index + 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CustomRewardTile(
                    rewardName: reward['rewardName'] as String,
                    rewardSubtitle: reward['rewardSubtitle'] as String,
                    pointsRedeemed: reward['pointsRedeemed'] as int,
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
