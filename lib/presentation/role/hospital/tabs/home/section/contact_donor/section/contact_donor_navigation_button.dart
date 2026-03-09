import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class ContactDonorNavigationButton extends StatelessWidget {
  const ContactDonorNavigationButton({
    super.key,
    required this.contact,
    required this.message,
  });

  final VoidCallback contact;
  final VoidCallback message;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: ColorManger.lightGrey.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            backgroundColor: ColorManger.pureWhite,
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            foregroundColor: ColorManger.black,
            onPressed: contact,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 16),
                SizedBox(width: 6),
                Flexible(
                  child: CustomText(
                    text: appLocalizations.contact,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: CustomElevatedButton(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: ColorManger.lightGrey.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.black,
            onPressed: message,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, size: 16),
                SizedBox(width: 6),
                Flexible(
                  child: CustomText(
                    text: appLocalizations.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
