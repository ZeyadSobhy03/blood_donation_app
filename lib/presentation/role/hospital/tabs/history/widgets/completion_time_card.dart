import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class CompletionTimeCard extends StatelessWidget {
  const CompletionTimeCard({super.key, required this.completionTimeInHours});

  final int completionTimeInHours;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.green, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: appLocalization.completionTime,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            CustomText(
              text: appLocalization.hours(completionTimeInHours),
              textStyle: TextStyle(
                color: ColorManger.green,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
