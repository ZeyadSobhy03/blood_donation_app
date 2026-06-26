
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/add_reward_catalog_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/reward_item.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/utils/rewards_localizer.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class RewardCatalogCard extends StatelessWidget {
  const RewardCatalogCard({super.key, required this.catalog});

  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final items = catalog.items ?? [];

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
                const SizedBox(width: 4),
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
                    text: loc.itemsCount(catalog.totalCount ?? items.length),
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
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
                        return const AddRewardCatalogDialog();
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
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final reward = items[index];
                final localizedReward = localizeReward(
                  context,
                  rawTitle: reward.rewardName ?? '',
                  rawDescription: '',
                  rawStatus: reward.status,
                  rawCategory: reward.category,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RewardItem(
                    rewardId: reward.id ?? '',
                    rewardName: localizedReward.title,
                    rewardCategory: localizedReward.category,
                    rewardPoints: reward.pointsRequired ?? 0,
                    rewardRedeemed: reward.redeemedCount ?? 0,
                    initialStatus: reward.status == 'ACTIVE'
                        ? RewardStatus.active
                        : RewardStatus.inactive,
                    onStatusChanged: (status) {
                      final statusStr = status == RewardStatus.active
                          ? 'ACTIVE'
                          : 'INACTIVE';
                      context.read<AdminRewardsCubit>().updateRewardStatus(
                        rewardId: reward.id ?? '',
                        status: statusStr,
                      );
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
