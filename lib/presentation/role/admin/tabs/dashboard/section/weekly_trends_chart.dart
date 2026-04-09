import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class WeeklyTrendsChart extends StatelessWidget {
  const WeeklyTrendsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final values = [44.0, 52.0, 48.0, 61.0, 55.0, 67.0, 43.0];

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.weeklyTrends,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 90,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: ColorManger.grey200, strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        reservedSize: 32,
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
                          final i = value.toInt();
                          if (i < 0 || i >= 7) {
                            return const SizedBox.shrink();
                          }

                          final locale =
                              Localizations.localeOf(context).languageCode;

                          final startDate = DateTime.now().subtract(const Duration(days: 6));

                          final date = startDate.add(Duration(days: i));

                          final isArabic = locale == 'ar';

                          final dayName = isArabic
                              ? DateFormat.EEEE(locale).format(date)
                              : DateFormat.E(locale).format(date);

                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: CustomText(
                              text: dayName,
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
                  lineBarsData: [
                    LineChartBarData(
                      spots: values.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value);
                      }).toList(),
                      isCurved: true,
                      color: ColorManger.brightRed,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              color: ColorManger.pureWhite,
                              strokeWidth: 2,
                              strokeColor: ColorManger.brightRed,
                            ),
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}