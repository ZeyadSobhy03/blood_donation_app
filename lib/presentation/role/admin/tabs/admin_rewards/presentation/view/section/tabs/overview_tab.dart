import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/active_tier_distribution_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/reward_catalog_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/top_redeemed_rewards_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/total_points_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../l10n/app_localizations.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  void initState() {
    super.initState();
    context.read<AdminRewardsCubit>().getAdminRewardsData();
  }

  Widget _buildContent(BuildContext context, Data data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TotalPointsCard(
            totalPoints: data.totalPoints ?? 0,
            percentage: data.percentageChange ?? 0,
          ),
          const SizedBox(height: 8),
          ActiveTierDistributionCard(tiers: data.tiers ?? []),
          const SizedBox(height: 8),
          TopRedeemedRewardsCard(topRedeemed: data.topRedeemed ?? []),
          const SizedBox(height: 8),
          RewardCatalogCard(catalog: data.catalog ?? Catalog()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;
    return BlocBuilder<AdminRewardsCubit, AdminRewardsState>(
      buildWhen: (previous, current) =>
          current is AdminRewardsSuccessState ||
          current is AdminRewardsLoadingState ||
          current is AdminRewardsErrorState,
      builder: (context, state) {
        final cubit = context.read<AdminRewardsCubit>();

        if (state is AdminRewardsLoadingState) {
          if (cubit.currentData == null) {
            return CustomLoadingWidget(
              indicatorColor: ColorManger.brightPurple,
            );
          }
          final data = cubit.currentData!.data;
          if (data == null) return const SizedBox.shrink();
          return _buildContent(context, data);
        } else if (state is AdminRewardsSuccessState) {
          final data = state.adminRewardsDataModel.data;
          if (data == null) return const SizedBox.shrink();
          return _buildContent(context, data);
        } else if (state is AdminRewardsErrorState) {
          return CustomErrorWidget(
            message: localizeError(state.error, app),
            onRetry: () {
              context.read<AdminRewardsCubit>().getAdminRewardsData();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}