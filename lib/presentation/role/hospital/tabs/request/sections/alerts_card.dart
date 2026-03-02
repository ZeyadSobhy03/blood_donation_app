import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.5), width: 1),
      ),
      elevation: 4,
      color: ColorManger.lightRed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: CustomText(
          text: appLocalizations.alerts_message,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.primaryRedDark,
            letterSpacing: 0.5,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
