import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class RequestDetailNote extends StatelessWidget {
  const RequestDetailNote({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManger.lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManger.royalBlue,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: ColorManger.royalBlue,
            size: 20,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${appLocalization.note}: ",
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.royalBlue,
                    ),
                  ),
                  TextSpan(
                    text: appLocalization.requestNoteDescription,
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManger.royalBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
