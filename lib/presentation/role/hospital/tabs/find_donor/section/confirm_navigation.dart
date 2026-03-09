import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ConfirmNavigation extends StatelessWidget {
  const ConfirmNavigation({super.key, required this.close});
  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return     CustomElevatedButton(
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),

      elevation: 3,
      backgroundColor: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManger.lightGrey, width: 1),
      ),
      onPressed: close,
      foregroundColor: ColorManger.black,
      child: CustomText(
        text: appLocalization.close,
        textStyle: TextStyle(
          color: ColorManger.black,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.medium,
        ),
      ),);
  }
}
