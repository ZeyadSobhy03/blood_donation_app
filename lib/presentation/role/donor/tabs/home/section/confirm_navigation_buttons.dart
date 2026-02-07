import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../l10n/app_localizations.dart';

class ConfirmNavigationButtons extends StatelessWidget {
  const ConfirmNavigationButtons({super.key, this.accept, this.cancel});

  final void Function()? accept;
  final void Function()? cancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomElevatedButton(
          backgroundColor: ColorManger.brightRed,
          elevation: 3,
          foregroundColor: ColorManger.pureWhite,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),

          onPressed: accept,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: ColorManger.pureWhite),
              SizedBox(width: 4.w),
              CustomText(
                text: AppLocalizations.of(context)!.acceptButton,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.pureWhite,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        CustomElevatedButton(
          backgroundColor: ColorManger.pureWhite,
          foregroundColor: ColorManger.black,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 3,

          onPressed: cancel,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel_outlined, color: ColorManger.pureWhite),
              SizedBox(width: 4.w),
              CustomText(
                text: AppLocalizations.of(context)!.declineButton,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.black,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
