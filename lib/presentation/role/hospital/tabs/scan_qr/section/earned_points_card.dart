import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../l10n/app_localizations.dart';

class EarnedPointsCard extends StatelessWidget {
  const EarnedPointsCard({super.key, required this.pointsEarned});

  final int pointsEarned;

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            CustomText(
              text: appLocalization.youEarned,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.medal,
                  color: ColorManger.green,
                  size: 24,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: '$pointsEarned ${appLocalization.points}',
                  textStyle: TextStyle(
                    color: ColorManger.green,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
