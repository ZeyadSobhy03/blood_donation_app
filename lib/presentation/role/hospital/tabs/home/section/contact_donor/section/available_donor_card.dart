import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/section/contact_donor_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/widgets/donor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class AvailableDonorCard extends StatelessWidget {
  const AvailableDonorCard({super.key, required this.donors});

  final DonorModel donors;

  void callDonor(String phoneNumber) async {
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
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: ColorManger.lightRed,
                  child: Icon(
                    Icons.favorite_border,
                    color: ColorManger.brightRed,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DonorInfo(
                    name: donors.name,
                    bloodType: donors.bloodType,
                  ),
                ),

                SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManger.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: appLocalization.available,
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            ContactDonorNavigationButton(
              contact: () {
                callDonor(donors.phoneNumber);
              },
              message: () {
                sendWhatsapp(
                  donors.phoneNumber,
                  appLocalization.hospital_message,
                );
              },
            ),
            SizedBox(height: 16.h),


          ],
        ),
      ),
    );
  }
}
