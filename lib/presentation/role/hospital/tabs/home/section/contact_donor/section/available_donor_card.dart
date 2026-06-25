import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/models/home_request_responses_model.dart';
import 'contact_donor_navigation_button.dart';
import '../widgets/donor_info.dart';

class AvailableDonorCard extends StatelessWidget {
  const AvailableDonorCard({super.key, required this.donor});

  final RequestDonorResponse donor;

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

  Color _statusColor() {
    if (donor.isAvailable == true) return ColorManger.green;
    switch (donor.responseStatus) {
      case 'accepted':
        return ColorManger.green;
      case 'declined':
        return ColorManger.brightRed;
      case 'pending':
      default:
        return ColorManger.orange;
    }
  }

  String _statusLabel(AppLocalizations loc) {
    switch (donor.responseStatus) {
      case 'accepted':
        return loc.statusAccepted;
      case 'declined':
        return loc.donorResponseStatusDeclined;
      case 'pending':
        return loc.pending;
      default:
        return donor.isAvailable == true ? loc.available : loc.notAvailable;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final phoneNumber = donor.phoneNumber ?? '';

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
                    name: donor.fullName ?? '',
                    bloodType: donor.bloodType ?? '',
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: _statusLabel(appLocalization),
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
              contact: phoneNumber.isEmpty
                  ? null
                  : () => callDonor(phoneNumber),
              message: phoneNumber.isEmpty
                  ? null
                  : () => sendWhatsapp(
                        phoneNumber,
                        appLocalization.hospital_message,
                      ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
