import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_trends_chart.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/ai_insights_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/blood_type_chart.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/critical_alerts_card.dart';

import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/dashboard_title.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/section/top_donors_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resources/models/state_model.dart';
import '../../../../../l10n/app_localizations.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final appLocalization = AppLocalizations.of(context)!;
    final List<StateModel> stateModels = [
      StateModel(
        text: appLocalization.totalDonors,
        totalDonor: 2847,
        percentage: '+12%',
        icon: Icons.group,
        color: ColorManger.royalBlue,
        backgroundColor: ColorManger.lightBlue,
      ),
      StateModel(
        text: appLocalization.activeRequests,
        totalDonor: 23,
        percentage: '+5%',
        icon: Icons.favorite,
        color: ColorManger.brightRed,
        backgroundColor: ColorManger.lightRed,
      ),
      StateModel(
        text: appLocalization.criticalCases,
        totalDonor: 7,
        percentage: '-2%',
        icon: Icons.warning,
        color: ColorManger.orange,
        backgroundColor: ColorManger.lightOrange,
      ),
      StateModel(
        text: appLocalization.successfulDonations,
        totalDonor: 1500,
        percentage: '+8%',
        icon: Icons.trending_up,
        color: ColorManger.green,
        backgroundColor: ColorManger.lightGreen,
      ),
    ];
    final values = [44.0, 52.0, 48.0, 61.0, 55.0, 67.0, 43.0];
    final startDate = DateTime.now().subtract(Duration(days: values.length - 1));
    final useFullDayName = appLocalization.localeName.startsWith('ar');
    final xLabels = List<String>.generate(7, (index) {
      final date = startDate.add(Duration(days: index));
      return useFullDayName
          ? DateFormat.EEEE(appLocalization.localeName).format(date)
          : DateFormat.E(appLocalization.localeName).format(date);
    });


    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DashboardTitle(),
                const SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: stateModels.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,

                    crossAxisCount: screenWidth> 600 ? 4 : 2,
                  ),
                  itemBuilder: (context, index) {
                    final stateModel = stateModels[index];
                    return StateCard(
                      backgroundColor: stateModel.backgroundColor,
                      color: stateModel.color,
                      text: stateModel.text,
                      icon: stateModel.icon,
                      percentage: stateModel.percentage,
                      totalDonor: stateModel.totalDonor,
                    );
                  },
                ),
                SizedBox(height: 20),
                CriticalAlerts(),
                SizedBox(height: 20),
                BloodTypeChart(),
                SizedBox(height: 20),
                CustomTrendsChart(
                  values: values,
                  title: appLocalization.weeklyTrends,
                  xLabels: xLabels,
                ),
                SizedBox(height: 20),
                AiInsightsCard(),
                SizedBox(height: 20),
                TopDonorsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
