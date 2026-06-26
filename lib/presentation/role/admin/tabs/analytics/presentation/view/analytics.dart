
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_trends_chart.dart';
import 'package:blood_donation_app/core/widgets/custom_note_card.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/presentation/view/section/analytics_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/ai_prediction_localizer.dart';
import '../../../../../../../core/utils/month_localizer.dart';
import '../view_model/analytics_overview_view_model.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsOverviewCubit>().getAnalyticsOverview();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<AnalyticsOverviewCubit, AnalyticsOverviewState>(
          builder: (context, state) {
            if (state is AnalyticsOverviewLoadingState) {
              return CustomLoadingWidget(
                indicatorColor: ColorManger.brightPurple,
              );
            }

            if (state is AnalyticsOverviewErrorState) {
              return CustomErrorWidget(message: localizeError(state.errorMessage, loc), onRetry: (){

                context.read<AnalyticsOverviewCubit>().getAnalyticsOverview();

              });
            }

            if (state is AnalyticsOverviewSuccessState) {
              final data = state.analyticsOverviewModel.data!;

              return SingleChildScrollView(
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
                              value: data.growthRate ?? '-',
                            ),
                          ),
                          Expanded(
                            child: AnalyticsCard(
                              icon: Icons.favorite_border,
                              iconColor: ColorManger.brightRed,
                              title: loc.successRate,
                              value: data.successRate ?? '-',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTrendsChart(
                        values: data.monthlyTrend?.values?.map((e) => e.toDouble()).toList() ?? [],                        title: loc.monthlyTrend,
                        xLabels: localizeMonthLabels(data.monthlyTrend?.labels ?? [], loc),
                      ),
                      const SizedBox(height: 16),
                      CustomNoteCard(
                        title: loc.aiPredictions,
                        items: localizeAiPredictions(data.aiPredictions ?? [], loc),
                        textColor: ColorManger.skyBlue,
                        cardColor: ColorManger.lightBlue,
                        bulletColor: ColorManger.skyBlue,
                        borderColor: ColorManger.skyBlue.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}