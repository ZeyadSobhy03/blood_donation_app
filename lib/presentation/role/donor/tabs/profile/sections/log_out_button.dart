import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 70.h, maxWidth: double.infinity),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomElevatedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: ColorManger.brightRed.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          elevation: 4,
          foregroundColor: ColorManger.brightRed,
          backgroundColor: ColorManger.pureWhite,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          onPressed: () {
            Navigator.pushNamed(context, RouteManger.chooseRole);
            // Handle logout action
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: ColorManger.brightRed),
              SizedBox(width: 8),
              CustomText(
                text: appLocalization.logout,
                textStyle: TextStyle(
                  color: ColorManger.brightRed,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
