import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/tabs/adjust_points_tab.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/tabs/configuration_tab.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/tabs/overview_tab.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/rewards_header.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/custom_rewards_tab.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class AdminRewards extends StatefulWidget {
  const AdminRewards({super.key});

  @override
  State<AdminRewards> createState() => _AdminRewardsState();
}

class _AdminRewardsState extends State<AdminRewards> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: RewardsHeader(
                  title: loc.rewardsConfigAnalyticsTitle,
                  description: loc.rewardsConfigAnalyticsDescription,
                ),
              ),
              const SizedBox(height: 16),
              CustomRewardsTab(
                tabs:  [loc.overview,  loc.configuration, loc.adjustPoints],
                onTabChanged: (index) {
                  setState(() => _selectedTabIndex = index);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: IndexedStack(
                  index: _selectedTabIndex,
                  children: const [
                    OverviewTab(),
                    ConfigurationTab(),
                    AdjustPointsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}