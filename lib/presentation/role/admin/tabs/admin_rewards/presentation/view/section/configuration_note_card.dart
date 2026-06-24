import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class ConfigurationNoteCard extends StatelessWidget {
  const ConfigurationNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc=AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: ColorManger.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.royalBlue.withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: ColorManger.royalBlue, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: loc.configurationNote,
                    textStyle: TextStyle(
                      color: ColorManger.royalBlue,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: loc.configurationNoteDescription,
                    textStyle: TextStyle(
                      height: 1.4,
                      letterSpacing: 0.2,
                      color: ColorManger.royalBlue,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
