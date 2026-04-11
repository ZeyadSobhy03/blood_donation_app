import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_trends_chart.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/section/analytics_card.dart';
import 'package:blood_donation_app/core/widgets/custom_note_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final xLabels = List<String>.generate(
      7,
      (index) => DateFormat.MMM(
        loc.localeName,
      ).format(DateTime.now().subtract(Duration(days: (6 + index) * 30))),
    );
    final items = [
      loc.aiPrediction1,
      loc.aiPrediction2,
      loc.aiPrediction3,
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomTitle(
                  title: loc.analytics,
                  subTitle: loc.analyticsSubtitle,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AnalyticsCard(
                        icon: Icons.trending_up,
                        iconColor: ColorManger.green,
                        title: loc.growthRate,
                        value: '15%',
                      ),
                    ),
                    Expanded(
                      child: AnalyticsCard(
                        icon: Icons.favorite_border,
                        iconColor: ColorManger.brightRed,
                        title: loc.successRate,
                        value: '12%',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTrendsChart(
                  values: [100, 120, 150, 130, 170, 160, 180],
                  title: loc.monthlyTrend,
                  xLabels: xLabels,
                ),
                SizedBox(height: 16),
                CustomNoteCard(
                  title: loc.aiPredictions,
                  items: items,
                  textColor: ColorManger.skyBlue,
                  cardColor: ColorManger.lightBlue,
                  bulletColor: ColorManger.skyBlue,
                  borderColor: ColorManger.skyBlue.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
