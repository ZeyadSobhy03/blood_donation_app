import 'dart:math' as math;

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTrendsChart extends StatelessWidget {
  const CustomTrendsChart({
    super.key,
    required this.values,
    required this.title,
    this.height = 240,
    this.lineColor = ColorManger.brightRed,
    this.cardColor = ColorManger.pureWhite,
    this.borderColor,
    this.backgroundGradient,
    this.xLabels,
    this.showDots = true,
    this.showGrid = true,
    this.showTitles = true,
    this.minY = 0,
    this.maxY,
    this.emptyMessage,
    this.emptyIcon = Icons.show_chart_outlined,
  });

  final List<double> values;
  final String title;

  final double height;
  final Color lineColor;
  final Color cardColor;
  final Color? borderColor;
  final Gradient? backgroundGradient;
  final List<String>? xLabels;
  final bool showDots;
  final bool showGrid;
  final bool showTitles;
  final double minY;
  final double? maxY;
  final String? emptyMessage;
  final IconData emptyIcon;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final safeValues = values.isEmpty ? const [0.0] : values;
    final chartMaxY = maxY ?? _calculateMaxY(safeValues);
    final resolvedBorderColor = borderColor ?? ColorManger.lightGrey.withValues(alpha: 0.5);

    return Card(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: resolvedBorderColor),
      ),
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: lineColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: title,
                    textStyle: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (values.isEmpty)
              SizedBox(
                height: height,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        emptyIcon,
                        size: 42,
                        color: ColorManger.slateGrey.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: emptyMessage ?? loc.noTrendDataAvailable,
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: height,
                child: LineChart(
                  LineChartData(
                    minY: minY,
                    maxY: chartMaxY,
                    gridData: FlGridData(
                      show: showGrid,
                      drawVerticalLine: false,
                      horizontalInterval: _calculateInterval(chartMaxY, minY),
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: ColorManger.grey200,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => ColorManger.black,
                        tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              spot.y.toStringAsFixed(0),
                              TextStyle(
                                color: ColorManger.pureWhite,
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: showTitles,
                          interval: _calculateInterval(chartMaxY, minY),
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
                          showTitles: showTitles,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= safeValues.length) {
                              return const SizedBox.shrink();
                            }

                            final label = _resolveLabel(context, index, safeValues.length);

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
                    lineBarsData: [
                      LineChartBarData(
                        spots: safeValues.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value);
                        }).toList(),
                        isCurved: true,
                        curveSmoothness: 0.35,
                        color: lineColor,
                        barWidth: 3,
                        dotData: FlDotData(
                          show: showDots,
                          getDotPainter: (spot, percent, bar, index) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: ColorManger.pureWhite,
                            strokeWidth: 2,
                            strokeColor: lineColor,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: backgroundGradient ??
                              LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  lineColor.withValues(alpha: 0.24),
                                  lineColor.withValues(alpha: 0.02),
                                ],
                              ),
                        ),
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

  double _calculateMaxY(List<double> safeValues) {
    final highest = safeValues.reduce(math.max);
    final top = highest <= 0 ? 10 : highest * 1.25;
    return top.ceilToDouble();
  }

  double _calculateInterval(double max, double min) {
    final range = max - min;
    if (range <= 0) return 1;
    final interval = range / 4;
    return interval < 1 ? 1 : interval.ceilToDouble();
  }

  String _resolveLabel(BuildContext context, int index, int length) {
    if (xLabels != null && index < xLabels!.length) {
      return xLabels![index];
    }

    if (length == 7) {
      final locale = Localizations.localeOf(context).languageCode;
      final startDate = DateTime.now().subtract(const Duration(days: 6));
      final date = startDate.add(Duration(days: index));
      final isArabic = locale == 'ar';

      return isArabic
          ? DateFormat.EEEE(locale).format(date)
          : DateFormat.E(locale).format(date);
    }

    return '${index + 1}';
  }
}