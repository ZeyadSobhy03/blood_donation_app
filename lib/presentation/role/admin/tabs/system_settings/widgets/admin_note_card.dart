import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class AdminNoteCard extends StatelessWidget {
  const AdminNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightGreen,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.green.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Text.rich(
          TextSpan(
            text: '${appLocalization.notePrefix} ',
            style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
              color: ColorManger.green,
            ),
            children: [
              TextSpan(
                text: appLocalization.adminNoteMessage,
                style: TextStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.green.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
