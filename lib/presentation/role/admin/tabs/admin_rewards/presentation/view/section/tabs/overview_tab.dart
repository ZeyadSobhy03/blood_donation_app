import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/active_tier_distribution_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/reward_catalog_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/top_redeemed_rewards_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/total_points_card.dart';
import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),

      child: Column(
        children: [
          TotalPointsCard(totalPoints: 10, percentage: 0.6),
          SizedBox(height: 8,),
          ActiveTierDistributionCard(),
          SizedBox(height: 8,),
          TopRedeemedRewardsCard(),
          SizedBox(height: 8,),
          RewardCatalogCard()


        ],
      ),
    );
  }
}
