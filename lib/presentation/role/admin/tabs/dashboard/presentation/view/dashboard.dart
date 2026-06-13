import 'dart:developer';

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final appLocalization = AppLocalizations.of(context)!;

    final values = [44.0, 52.0, 48.0, 61.0, 55.0, 67.0, 43.0];
    final startDate =
    DateTime.now().subtract(Duration(days: values.length - 1));
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
                BlocBuilder<AnalyticsCubit, AnalyticsState>(
                  builder: (context, state) {
                    log('Analytics State: $state');
                    if (state is AnalyticsLoadingState) {
                      return CustomLoadingWidget(
                        indicatorColor: ColorManger.royalBlue,
                      );
                    }

                    if (state is AnalyticsErrorState) {
                      return CustomErrorWidget(message: localizeError(state.errorMessage, appLocalization), onRetry: () {
                        context.read<AnalyticsCubit>().fetchAnalytics();
                      },);
                    }

                    final data = state is AnalyticsSuccessState
                        ? state.analyticsModel.data
                        : null;

                    final List<StateModel> stateModels = [
                      StateModel(
                        text: appLocalization.totalDonors,
                        totalDonor: data?.users?.donors ?? 0,
                        percentage: '+12%',
                        icon: Icons.group,
                        color: ColorManger.royalBlue,
                        backgroundColor: ColorManger.lightBlue,
                      ),
                      StateModel(
                        text: appLocalization.activeRequests,
                        totalDonor: data?.requests?.active ?? 0,
                        percentage: '+5%',
                        icon: Icons.favorite,
                        color: ColorManger.brightRed,
                        backgroundColor: ColorManger.lightRed,
                      ),
                      StateModel(
                        text: appLocalization.criticalCases,
                        totalDonor: data?.requests?.critical ?? 0,
                        percentage: '-2%',
                        icon: Icons.warning,
                        color: ColorManger.orange,
                        backgroundColor: ColorManger.lightOrange,
                      ),
                      StateModel(
                        text: appLocalization.successfulDonations,
                        totalDonor: data?.donations?.completed ?? 0,
                        percentage: '+8%',
                        icon: Icons.trending_up,
                        color: ColorManger.green,
                        backgroundColor: ColorManger.lightGreen,
                      ),
                    ];

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stateModels.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    );
                  },
                ),
                const SizedBox(height: 20),
                CriticalAlerts(),
                const SizedBox(height: 20),
                BloodTypeChart(),
                const SizedBox(height: 20),
                CustomTrendsChart(
                  values: values,
                  title: appLocalization.weeklyTrends,
                  xLabels: xLabels,
                ),
                const SizedBox(height: 20),
                AiInsightsCard(),
                const SizedBox(height: 20),
                TopDonorsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}