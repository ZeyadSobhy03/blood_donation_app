import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class MaintenanceNoteCard extends StatelessWidget {
  const MaintenanceNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightBlue,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.skyBlue),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: CustomText(
          text: localizations.maintenanceNoteMessage,
          textStyle: TextStyle(
            color: ColorManger.royalBlue,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ),
    );
  }
}
