import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/widgets/state_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class DonationStatsCard extends StatelessWidget {
  const DonationStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: ColorManger.pureWhite.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StateItem(
              label: appLocalization.total,
              value: 12,
              subLabel: appLocalization.donations,
            ),
            StateItem(
              label: appLocalization.points,
              value: 2300,
              subLabel: appLocalization.earned,
            ),
            StateItem(
              label: appLocalization.livesSaved,
              value: 36,
              subLabel: appLocalization.completed,
            ),
          ],
        ),
      ),
    );
  }
}
