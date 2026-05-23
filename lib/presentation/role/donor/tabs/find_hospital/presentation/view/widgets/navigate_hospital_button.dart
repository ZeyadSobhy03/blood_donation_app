import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bottom_sheet/custom_model_sheet.dart';

class NavigateHospitalButton extends StatelessWidget {
  const NavigateHospitalButton({
    super.key, required this.hospitals,

  });

  final Hospitals hospitals;

  Future<void> _openDirectionsGoogle() async {
    final lat = hospitals.location?.lat?? 0.0;
    final lng = hospitals.location?.lng?? 0.0;

    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }
  Future<void> _openDirectionsApple() async {
    final lat = hospitals.location?.lat?? 0.0;
    final lng = hospitals.location?.lng?? 0.0;

    final Uri appleMapsUrl = Uri.parse(
      'https://maps.apple.com/?q=$lat,$lng',
    );

    if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }



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
          primaryButtonPressed: () => _openDirectionsGoogle(),
          secondaryButtonPressed: () => _openDirectionsApple(),

          text: hospitals.name ?? '',

          buttonBackgroundColor: ColorManger.skyBlue,
          context: context,
          cardBackgroundColor: ColorManger.lightBlue,
          title: appLocalization.navigateToHospital,
          prefixWidget: Icon(
            Icons.location_on_outlined,
            color: ColorManger.skyBlue,
          ),
          subTitleWidget: CustomText(
            text: appLocalization.distanceAway(hospitals.distanceKm ?? 0.0),
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
