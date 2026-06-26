import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_trends_chart.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/ai_insights_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/blood_type_chart.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/critical_alerts_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/dashboard_title.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/section/top_donors_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/resources/models/state_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../view_model/analytics/analytics_view_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsCubit>().fetchAnalytics();
  }

  List<String> _buildXLabels(
    List<String>? apiLabels,
    int count,
    AppLocalizations loc,
  ) {
    if (apiLabels != null && apiLabels.isNotEmpty) {
      if (loc.localeName.startsWith('ar')) {
        const Map<String, String> dayMap = {
          'Mon': 'الاثنين',
          'Tue': 'الثلاثاء',
          'Wed': 'الأربعاء',
          'Thu': 'الخميس',
          'Fri': 'الجمعة',
          'Sat': 'السبت',
          'Sun': 'الأحد',
        };
        return apiLabels.map((l) => dayMap[l] ?? l).toList();
      }
      return apiLabels;
    }

    final startDate = DateTime.now().subtract(Duration(days: count - 1));
    final useFullDayName = loc.localeName.startsWith('ar');
    return List<String>.generate(count, (index) {
      final date = startDate.add(Duration(days: index));
      return useFullDayName
          ? DateFormat.EEEE(loc.localeName).format(date)
          : DateFormat.E(loc.localeName).format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final appLocalization = AppLocalizations.of(context)!;

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
                BlocBuilder<AnalyticsCubit, AnalyticsState>(
                  builder: (context, state) {
                    if (state is AnalyticsLoadingState) {
                      return CustomLoadingWidget(
                        indicatorColor: ColorManger.royalBlue,
                      );
                    }

                    if (state is AnalyticsErrorState) {
                      return CustomErrorWidget(
                        message: localizeError(
                          state.errorMessage,
                          appLocalization,
                        ),
                        onRetry: () {
                          context.read<AnalyticsCubit>().fetchAnalytics();
                        },
                      );
                    }

                    final data = state is AnalyticsSuccessState
                        ? state.analyticsModel.data
                        : null;

                    final List<StateModel> stateModels = [
                      StateModel(
                        text: appLocalization.totalDonors,
                        totalDonor: data?.totalDonors ?? 0,
                        percentage: data?.totalDonorsGrowth ?? '+0%',
                        icon: Icons.group,
                        color: ColorManger.royalBlue,
                        backgroundColor: ColorManger.lightBlue,
                      ),
                      StateModel(
                        text: appLocalization.activeRequests,
                        totalDonor: data?.activeRequests ?? 0,
                        percentage: data?.activeRequestsGrowth ?? '-0%',
                        icon: Icons.favorite,
                        color: ColorManger.brightRed,
                        backgroundColor: ColorManger.lightRed,
                      ),
                      StateModel(
                        text: appLocalization.criticalCases,
                        totalDonor: data?.criticalCases ?? 0,
                        percentage: data?.criticalCasesGrowth ?? '+0%',
                        icon: Icons.warning,
                        color: ColorManger.orange,
                        backgroundColor: ColorManger.lightOrange,
                      ),
                      StateModel(
                        text: appLocalization.successfulDonations,
                        totalDonor: data?.successfulDonations ?? 0,
                        percentage: data?.successfulDonationsGrowth ?? '+0%',
                        icon: Icons.trending_up,
                        color: ColorManger.green,
                        backgroundColor: ColorManger.lightGreen,
                      ),
                    ];

                    final weeklyValues =
                        data?.weeklyTrends?.values
                            ?.map((v) => v.toDouble())
                            .toList() ??
                        [];

                    final xLabels = _buildXLabels(
                      data?.weeklyTrends?.labels,
                      weeklyValues.isEmpty ? 7 : weeklyValues.length,
                      appLocalization,
                    );

                    return Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stateModels.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                crossAxisCount: screenWidth > 600 ? 4 : 2,
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

                        const SizedBox(height: 20),
                        CriticalAlerts(),
                        const SizedBox(height: 20),
                        BloodTypeChart(),
                        const SizedBox(height: 20),

                        CustomTrendsChart(
                          values: weeklyValues,
                          title: appLocalization.weeklyTrends,
                          xLabels: xLabels,
                        ),

                        const SizedBox(height: 20),
                        AiInsightsCard(),
                        const SizedBox(height: 20),
                        TopDonorsCard(),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
