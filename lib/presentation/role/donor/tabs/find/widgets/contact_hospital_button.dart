import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/bottom_sheet/custom_model_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactHospitalButton extends StatelessWidget {
  const ContactHospitalButton({
    super.key,
    required this.hospitalName,
    required this.bloodType,
    required this.hospitalNumber,
  });

  final String hospitalNumber;
  final String hospitalName;
  final String bloodType;

  void callHospital(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void sendWhatsapp(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return CustomElevatedButton(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: ColorManger.brightRed,
      foregroundColor: ColorManger.pureWhite,
      onPressed: () => showModelSheet(
        secondaryButtonPressed: () =>
            sendWhatsapp(hospitalNumber, appLocalization.donationMessage),
        primaryButtonPressed: () => callHospital(hospitalNumber),

        text: hospitalName,

        buttonBackgroundColor: ColorManger.brightRed,
        context: context,
        cardBackgroundColor: ColorManger.lightRed,
        title: appLocalization.contactHospital,
        prefixWidget: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.local_hospital, color: ColorManger.brightRed),
          ),
        ),
        subTitleWidget: Container(
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomText(
                text: bloodType,
                textStyle: TextStyle(
                  color: ColorManger.brightRed,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
        primaryButtonChild: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, color: ColorManger.pureWhite),
            SizedBox(width: 4.w),
            CustomText(text: appLocalization.callNow),
          ],
        ),
        secondaryButton: CustomText(text: appLocalization.sendMessage),
        tertiaryButton: CustomText(text: appLocalization.cancel),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone),
          SizedBox(width: 4.w),
          CustomText(
            text: appLocalization.contact,
            textStyle: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}
