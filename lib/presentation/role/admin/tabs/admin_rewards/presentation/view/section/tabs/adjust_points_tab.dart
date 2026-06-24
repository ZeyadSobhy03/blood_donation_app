import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/manual_points_adjustment_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/recent_adjustments_card.dart';
import 'package:flutter/material.dart';

class AdjustPointsTab extends StatelessWidget {
  const AdjustPointsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ManualPointsAdjustmentCard(),
          SizedBox(height: 12,),
          RecentAdjustmentsCard()

        ],
      ),
    );
  }
}
