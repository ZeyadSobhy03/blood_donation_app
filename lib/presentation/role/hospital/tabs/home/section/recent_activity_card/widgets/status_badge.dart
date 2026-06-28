import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../model/activity_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    required this.donorPhoneNumber,
  });

  final ActivityStatus status;
  final String? donorPhoneNumber;

  @override
  Widget build(BuildContext context) {
    void callDonor(String phoneNumber) async {
      final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    }

    final appLocalizations = AppLocalizations.of(context)!;
    switch (status) {
      case ActivityStatus.complete:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ColorManger.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomText(
            text: appLocalizations.complete,
            textStyle: TextStyle(
              color: ColorManger.pureWhite,
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        );
      case ActivityStatus.contact:
        final phone = donorPhoneNumber;
        return CustomElevatedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: ColorManger.pureWhite,
          foregroundColor: ColorManger.black,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          onPressed: (phone == null || phone.isEmpty)
              ? null
              : () => callDonor(phone),
          child: Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 4),
              CustomText(
                text: appLocalizations.contact,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ],
          ),
        );
      case ActivityStatus.active:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ColorManger.slateGrey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomText(
            text: appLocalizations.active,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        );
    }
  }
}
