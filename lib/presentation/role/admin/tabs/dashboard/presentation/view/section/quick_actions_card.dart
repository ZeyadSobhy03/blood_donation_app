import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/quick_action_button.dart';


class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
    required this.onEmergencyBroadcast,
    required this.hospitalContactNumber,
    this.isLoading = false,
  });

  final VoidCallback? onEmergencyBroadcast;
  final String hospitalContactNumber;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.7),
          width: 1.1,
        ),
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
            // Emergency Broadcast Button
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 48,),
              child: Stack(

                children: [
                  QuickActionButton(
                    backgroundColor: ColorManger.royalBlue,
                    foregroundColor: ColorManger.pureWhite,
                    text: appLocalization.sendEmergencyBroadcast,
                    onPressed: isLoading ? null : onEmergencyBroadcast,
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorManger.pureWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Contact Hospital Button
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 48),
              child: QuickActionButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                text: appLocalization.contactHospital,
                onPressed: () {
                  callHospital(hospitalContactNumber);
                },
              ),
            ),
            SizedBox(height: 12),
            // Close Button
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 48),
              child: QuickActionButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                text: appLocalization.close,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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