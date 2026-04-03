import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class RecentRequestButton extends StatelessWidget {
  const RecentRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return CustomElevatedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),

        side: BorderSide(color: ColorManger.lightGrey.withValues(alpha: 0.5)),
      ),
      backgroundColor: ColorManger.pureWhite,
      foregroundColor: ColorManger.black,
      onPressed: () {
        Navigator.pop(context);
      },
      child: CustomText(text: appLocalization.close),
    );
  }
}
