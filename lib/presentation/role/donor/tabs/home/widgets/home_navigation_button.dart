import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class HomeNavigationButton extends StatelessWidget {
  const HomeNavigationButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            minHeight: 50,
          ),
          child: CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            elevation: 4,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            backgroundColor: ColorManger.brightRed,
            onPressed: onPressed,
            foregroundColor: ColorManger.pureWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  color: ColorManger.pureWhite,
                  size: 18,
                ),
                CustomText(text: AppLocalizations.of(context)!.donateNow)
              ],
            ),
          ),
        );
      },
    );
  }
}
