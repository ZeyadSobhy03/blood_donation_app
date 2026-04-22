import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class MaintenanceWarningCard extends StatelessWidget {
  const MaintenanceWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 0,
      color: ColorManger.lightOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.orange),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Text.rich(
          TextSpan(
            text: localizations.maintenanceWarningTitle,
            style: TextStyle(
              fontWeight: FontWeightManager.bold,
              color: ColorManger.orange,
              fontSize: FontSize.s16,
            ),
            children: [
              TextSpan(
                text: localizations.maintenanceWarningMessage,
                style: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.orange,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
