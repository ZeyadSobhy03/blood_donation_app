import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/widgets/quick_action_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../l10n/app_localizations.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
    required this.onEmergencyBroadcast,
    required this.hospitalContactNumber,
  });

  final VoidCallback onEmergencyBroadcast;
  final String hospitalContactNumber;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(
              text: appLocalization.quickActions,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16),
            QuickActionButton(
              backgroundColor: ColorManger.royalBlue,
              foregroundColor: ColorManger.pureWhite,
              text: appLocalization.sendEmergencyBroadcast,
              onPressed: () {},
            ),
            SizedBox(height: 12),
            QuickActionButton(
              backgroundColor: ColorManger.pureWhite,
              foregroundColor: ColorManger.black,
              text: appLocalization.contactHospital,
              onPressed: () {
                callHospital(hospitalContactNumber);
              },
            ),
            SizedBox(height: 12),
            QuickActionButton(
              backgroundColor: ColorManger.pureWhite,
              foregroundColor: ColorManger.black,
              text: appLocalization.close,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void callHospital(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
