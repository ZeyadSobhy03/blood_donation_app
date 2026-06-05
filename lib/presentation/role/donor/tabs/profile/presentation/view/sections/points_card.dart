import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class PointsCard extends StatelessWidget {
  final int totalPoints;
  final int milestonePoints;
  final String milestoneName;

  const PointsCard({
    super.key,
    required this.totalPoints,
    required this.milestonePoints,
    required this.milestoneName,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    final int pointsRemaining = milestonePoints - totalPoints;
    final double progress = totalPoints / milestonePoints;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: ColorManger.lightCream,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: appLocalization.total_points,
                        textStyle: TextStyle(
                          fontSize: FontSize.s13,
                          color: ColorManger.slateGrey,
                          fontWeight: FontWeightManager.semiBold,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        text: _formatNumber(totalPoints),
                        textStyle: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManger.orange,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: ColorManger.lightYellow,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorManger.yellow, width: 2),
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: ColorManger.yellow,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: '${appLocalization.next_milestone}: $milestoneName',
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color:
                          ColorManger.slateGrey,
                    ),
                  ),
                  CustomText(
                    text:
                        '${_formatNumber(totalPoints)} / ${_formatNumber(milestonePoints)}',
                    textStyle: TextStyle(
                      fontSize: FontSize.s13,
                      color: ColorManger.slateGrey,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: ColorManger.pureWhite,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorManger.black, // dark/black fill
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Points remaining
              CustomText(
                text: appLocalization.points_until_milestone(
                  _formatNumber(pointsRemaining),
                  milestoneName,
                ),
                textStyle: TextStyle(
                  fontSize: FontSize.s12,
                  color: ColorManger.slateGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      final parts = number.toString().split('');
      final insertAt = parts.length - 3;
      parts.insert(insertAt, ',');
      return parts.join('');
    }
    return number.toString();
  }
}
