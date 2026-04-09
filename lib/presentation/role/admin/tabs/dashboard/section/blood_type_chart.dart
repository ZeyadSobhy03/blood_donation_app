import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class BloodTypeChart extends StatelessWidget {
  const BloodTypeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final data = [
      ('O+', 900.0),
      ('A+', 650.0),
      ('B+', 400.0),
      ('O-', 220.0),
      ('A-', 300.0),
      ('B-', 240.0),
      ('AB+', 80.0),
      ('AB-', 60.0),
    ];

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(

                  maxY: 1000,
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
                    horizontalInterval: 250,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: ColorManger.grey200, strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false,),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 250,
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
                          final label = data[value.toInt()].$1;
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
            ),
          ],
        ),
      ),
    );
  }
}
