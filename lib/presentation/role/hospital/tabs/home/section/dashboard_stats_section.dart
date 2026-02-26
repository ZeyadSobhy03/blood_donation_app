import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../widgets/custom_dashboard_card.dart';

class DashboardStatsSection extends StatelessWidget {
  const DashboardStatsSection({
    super.key,
    required this.activeRequests,
    required this.responsesToday,
  });

  final int activeRequests;

  final int responsesToday;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: CustomDashboardCard(
            borderColor: ColorManger.brightRed,
            backgroundColor: ColorManger.lightRed,
            icon: Icons.favorite_border_outlined,
            iconColor: ColorManger.brightRed,
            activeRequest: activeRequests,
            title: appLocalizations.active_requests,
          ),
        ),
        Expanded(
          child: CustomDashboardCard(
            borderColor: ColorManger.green,
            backgroundColor: ColorManger.lightGreen,
            icon: Icons.person_outline,
            iconColor: ColorManger.green,
            activeRequest: responsesToday,
            title: appLocalizations.responses_today,
          ),
        ),
      ],
    );
  }
}
