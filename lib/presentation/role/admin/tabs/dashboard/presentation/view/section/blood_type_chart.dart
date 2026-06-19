import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/analytics/analytics_view_model.dart';
import '../../../data/model/analytics/analytics_model.dart';

class BloodTypeChart extends StatelessWidget {
  const BloodTypeChart({super.key});

  List<(String, double)> _buildChartData(BloodTypeDistribution dist) {
    return [
      ('O+', (dist.oPos ?? 0).toDouble()),
      ('A+', (dist.aPos ?? 0).toDouble()),
      ('B+', (dist.bPos ?? 0).toDouble()),
      ('O-', (dist.oNeg ?? 0).toDouble()),
      ('A-', (dist.aNeg ?? 0).toDouble()),
      ('B-', (dist.bNeg ?? 0).toDouble()),
      ('AB+', (dist.abPos ?? 0).toDouble()),
      ('AB-', (dist.abNeg ?? 0).toDouble()),
    ];
  }

  double _calcMaxY(List<(String, double)> data) {
    final max = data.map((e) => e.$2).reduce((a, b) => a > b ? a : b);
    final ceiling = ((max + 5) / 5).ceil() * 5;
    return ceiling.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: ColorManger.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.bloodTypeDistribution,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManger.black,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<AnalyticsCubit, AnalyticsState>(
              builder: (context, state) {
                if (state is AnalyticsLoadingState) {
                  return CustomLoadingWidget(
                    indicatorColor: ColorManger.royalBlue,
                  );
                }

                if (state is AnalyticsErrorState) {
                  return CustomErrorWidget(
                    message: localizeError(state.errorMessage, appLocalization),
                    onRetry: () {
                      context.read<AnalyticsCubit>().fetchAnalytics();
                    },
                  );
                }

                if (state is AnalyticsSuccessState) {
                  final dist = state.analyticsModel.data?.bloodTypeDistribution;

                  if (dist == null) {
                    return SizedBox(
                      height: 220,
                      child: Center(
                        child: CustomText(text: appLocalization.noDataFound),
                      ),
                    );
                  }

                  final data = _buildChartData(dist);
                  final maxY = _calcMaxY(data);
                  final interval = (maxY / 4).ceilToDouble();

                  return SizedBox(
                    height: 220,
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final label = data[group.x.toInt()].$1;
                              final value = rod.toY;
                              return BarTooltipItem(
                                '$label\n${appLocalization.units_count(value.toInt())}',
                                TextStyle(
                                  color: ColorManger.pureWhite,
                                  fontSize: FontSize.s12,
                                ),
                              );
                            },
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: interval,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: ColorManger.grey200,
                            strokeWidth: 1,
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: interval,
                              reservedSize: 36,
                              getTitlesWidget: (value, meta) => CustomText(
                                text: value.toInt().toString(),
                                textStyle: TextStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManger.slateGrey,
                                ),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 || index >= data.length) {
                                  return const SizedBox.shrink();
                                }
                                final label = data[index].$1;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: CustomText(
                                    text: label,
                                    textStyle: TextStyle(
                                      fontSize: FontSize.s12,
                                      color: ColorManger.slateGrey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barGroups: data.asMap().entries.map((e) {
                          return BarChartGroupData(
                            x: e.key,
                            barRods: [
                              BarChartRodData(
                                toY: e.value.$2,
                                color: ColorManger.brightRed,
                                width: 16,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }

                return const SizedBox(height: 220);
              },
            ),
          ],
        ),
      ),
    );
  }
}
