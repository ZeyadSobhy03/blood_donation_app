import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class EmergencyRequestCard extends StatelessWidget {
  const EmergencyRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.lightRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  size: 28,
                  color: ColorManger.brightRed,
                ),
                SizedBox(width: 12),
                CustomText(
                  text: appLocalizations.emergency_request,
                  textStyle: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.brightRed,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: ColorManger.brightRed,
              elevation: 4,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EmergencyRequestDialog(),
                );
              },
              foregroundColor: ColorManger.pureWhite,
              child: CustomText(
                text: appLocalizations.create_emergency_request,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
