import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.royalBlue.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: appLocalization.note,
                    textStyle: TextStyle(
                      color: ColorManger.skyBlue,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  CustomText(
                    text: appLocalization.note_dec,
                    textStyle: TextStyle(
                      color: ColorManger.skyBlue,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
