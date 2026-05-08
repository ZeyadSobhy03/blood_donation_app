import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../l10n/app_localizations.dart';

class ScanDonorQrCard extends StatelessWidget {
  const ScanDonorQrCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.skyBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.skyBlue, width: 1),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.qr_code_scanner_outlined,
                  color: ColorManger.pureWhite,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: appLocalizations.scanDonorQrCodeTitle,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomText(
              text: appLocalizations.scanDonorQrCodeDescription,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              elevation: 4,
              backgroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              foregroundColor: ColorManger.skyBlue,
              onPressed: () {
                Navigator.pushNamed(context, RouteManger.scanQrCode,);
              },

              child: CustomText(
                text: appLocalizations.openQrScannerButton,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.skyBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
