import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class EmergencyRequestNavigationButton extends StatelessWidget {
  const EmergencyRequestNavigationButton({super.key, required this.onSubmit, required this.onCancel});
  final VoidCallback onSubmit;
  final VoidCallback onCancel ;


  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: ColorManger.pureWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManger.lightGrey, width: 1),
            ),
            foregroundColor: ColorManger.black,
            onPressed: onCancel,
            child: CustomText(
              text: appLocalizations.cancel,
              textStyle: TextStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
        ),

        CustomElevatedButton(
          onPressed: onSubmit,
          foregroundColor: ColorManger.pureWhite,
          backgroundColor: ColorManger.brightRed,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 3,
          child: CustomText(
            text: appLocalizations.submit_request,
            textStyle: TextStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
