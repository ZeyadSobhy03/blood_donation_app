import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/manual_points_adjustment_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/recent_adjustments_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdjustPointsTab extends StatefulWidget {
  const AdjustPointsTab({super.key});

  @override
  State<AdjustPointsTab> createState() => _AdjustPointsTabState();
}

class _AdjustPointsTabState extends State<AdjustPointsTab> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AdminRewardsCubit>();
    if (cubit.currentData == null) {
      cubit.getAdminRewardsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminRewardsCubit, AdminRewardsState>(
      buildWhen: (previous, current) =>
          current is AdminRewardsSuccessState ||
          current is AdminRewardsLoadingState ||
          current is AdminRewardsErrorState,
      builder: (context, state) {
        // Extract adjustments from the current data
        final cubit = context.read<AdminRewardsCubit>();
        final adjustments = cubit.currentData?.data?.adjustments ?? [];

        return SingleChildScrollView(
          child: Column(
            children: [
              ManualPointsAdjustmentCard(),
              SizedBox(height: 12),
              RecentAdjustmentsCard(adjustments: adjustments),
            ],
          ),
        );
      },
    );
  }
}

