import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/bottom_sheet/custom_model_sheet.dart';

class NavigateHospitalButton extends StatelessWidget {
  const NavigateHospitalButton({
    super.key,
    required this.hospitalName,
    required this.distanceKm,
  });

  final String hospitalName;
  final double distanceKm;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomElevatedButton(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: ColorManger.pureWhite,
        foregroundColor: ColorManger.black,
        onPressed: () => showModelSheet(
          primaryButtonPressed: () {},
          secondaryButtonPressed: () {},

          text: hospitalName,

          buttonBackgroundColor: ColorManger.skyBlue,
          context: context,
          cardBackgroundColor: ColorManger.lightBlue,
          title: appLocalization.navigateToHospital,
          prefixWidget: Icon(
            Icons.location_on_outlined,
            color: ColorManger.skyBlue,
          ),
          subTitleWidget: CustomText(
            text: appLocalization.distanceAway(distanceKm.toStringAsFixed(1)),
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              height: 1.4,
            ),
          ),
          primaryButtonChild: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.785,
                child: Icon(Icons.send_rounded, color: ColorManger.pureWhite),
              ),
              SizedBox(width: 4.w),
              CustomText(text: appLocalization.openInGoogleMap),
            ],
          ),
          secondaryButton: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: ColorManger.black),
              SizedBox(width: 4.w),
              CustomText(text: appLocalization.openInAppleMap),
            ],
          ),
          tertiaryButton: CustomText(text: appLocalization.cancel),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Transform.rotate(
              angle: -0.785,
              child: Icon(Icons.send_rounded, color: ColorManger.black),
            ),
            SizedBox(width: 4.w),
            CustomText(
              text: appLocalization.navigate,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
