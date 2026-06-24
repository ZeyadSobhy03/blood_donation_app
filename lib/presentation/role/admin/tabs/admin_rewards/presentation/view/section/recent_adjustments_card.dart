import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/widgets/recent_adjustments_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class RecentAdjustmentsCard extends StatelessWidget {
  const RecentAdjustmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> recentAdjustments = [
      {
        'userName': 'usr_482',
        'reason': 'Demo bonus points',
        'points': 100,
        'date': '2h ago',
      },
      {
        'userName': 'usr_201',
        'reason': 'Points correction',
        'points': -50,
        'date': '1d ago',
      },
      {
        'userName': 'usr_317',
        'reason': 'Referral reward',
        'points': 75,
        'date': '2d ago',
      },
      {
        'userName': 'usr_109',
        'reason': 'Duplicate donation reversal',
        'points': -120,
        'date': '3d ago',
      },
      {
        'userName': 'usr_654',
        'reason': 'Manual admin adjustment',
        'points': 200,
        'date': '5d ago',
      },
    ];

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.recentAdjustments,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recentAdjustments.length,
              itemBuilder: (context, index) {
                final adjustment = recentAdjustments[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecentAdjustmentsTile(
                    userName: adjustment['userName'] as String,
                    reason: adjustment['reason'] as String,
                    points: adjustment['points'] as int,
                    date: adjustment['date'] as String,
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