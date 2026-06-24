import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/add_reward_catalog_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/reward_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

// Simple dummy model used until real data wiring (API/provider) is added.
class RewardCatalogItem {
  const RewardCatalogItem({
    required this.rewardName,
    required this.rewardCategory,
    required this.rewardPoints,
    required this.rewardRedeemed,
    this.status = RewardStatus.active,
  });

  final String rewardName;
  final String rewardCategory;
  final int rewardPoints;
  final int rewardRedeemed;
  final RewardStatus status;
}

// Dummy data — replace with real data from your repository/bloc/provider.
const List<RewardCatalogItem> dummyRewards = [
  RewardCatalogItem(
    rewardName: 'Coffee Voucher',
    rewardCategory: 'FOOD',
    rewardPoints: 150,
    rewardRedeemed: 342,
    status: RewardStatus.active,
  ),
  RewardCatalogItem(
    rewardName: 'Movie Ticket',
    rewardCategory: 'ENTERTAINMENT',
    rewardPoints: 300,
    rewardRedeemed: 196,
    status: RewardStatus.active,
  ),
  RewardCatalogItem(
    rewardName: 'Grocery Discount 10%',
    rewardCategory: 'GROCERY',
    rewardPoints: 200,
    rewardRedeemed: 88,
    status: RewardStatus.inactive,
  ),
  RewardCatalogItem(
    rewardName: 'Free Blood Pressure Check',
    rewardCategory: 'HEALTH',
    rewardPoints: 100,
    rewardRedeemed: 54,
    status: RewardStatus.active,
  ),
  RewardCatalogItem(
    rewardName: 'Gym Day Pass',
    rewardCategory: 'FITNESS',
    rewardPoints: 250,
    rewardRedeemed: 21,
    status: RewardStatus.inactive,
  ),
];

class RewardCatalogCard extends StatelessWidget {
  const RewardCatalogCard({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: loc.rewardCatalog,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorManger.lightGreyBorder,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 6,
                  ),
                  child: CustomText(
                    text: loc.itemsCount(dummyRewards.length),
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                CustomElevatedButton(
                  backgroundColor: ColorManger.brightPurple,
                  foregroundColor: ColorManger.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddRewardCatalogDialog();
                      },
                    );
                  },
                  child: CustomText(
                    text: loc.addReward,
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyRewards.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final reward = dummyRewards[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RewardItem(
                    rewardName: reward.rewardName,
                    rewardCategory: reward.rewardCategory,
                    rewardPoints: reward.rewardPoints,
                    rewardRedeemed: reward.rewardRedeemed,
                    initialStatus: reward.status,
                    onStatusChanged: (status) {
                    },
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