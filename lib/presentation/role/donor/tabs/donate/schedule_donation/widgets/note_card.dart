import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.skyBlue),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: CustomText(
          text:
          appLocalizations.noteMessage,

          textStyle: TextStyle(
            color: ColorManger.royalBlue,
            height: 1.4,
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s14,


          ),
        ),
      ),
    );
  }
}
