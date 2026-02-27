import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ContactNavigationButton extends StatelessWidget {
  const ContactNavigationButton({super.key, required this.onSendRequest});
  final VoidCallback onSendRequest ;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return  Row(

      children: [
        Expanded(
          flex: 1,
          child: CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManger.lightGrey, width: 1),
            ),
            onPressed: () => Navigator.of(context).pop(),
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomText(
              text: appLocalization.close,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          flex: 2,
          child: CustomElevatedButton(
            onPressed: onSendRequest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManger.royalBlue, width: 1),
            ),
            backgroundColor: ColorManger.royalBlue,
            foregroundColor: ColorManger.pureWhite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomText(
              text: appLocalization.send_request,
              textStyle: TextStyle(

                color: ColorManger.pureWhite,
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
