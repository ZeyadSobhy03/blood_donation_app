import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class BotMessage extends StatelessWidget {
  const BotMessage({super.key, required this.text, required this.time});

  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManger.brightRed.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: ColorManger.brightRed,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appLocalizations.lifeLinkBot,
                      textStyle: TextStyle(
                        color: ColorManger.brightRed,
                        fontWeight: FontWeightManager.semiBold,
                        fontSize: FontSize.s13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManger.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: CustomText(
                        text: text,
                        textStyle: TextStyle(
                          color: ColorManger.slateGrey,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: time,
                      textStyle: TextStyle(
                        color: ColorManger.slateGrey.withValues(alpha: 0.5),
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
