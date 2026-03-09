import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/widgets/camera_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class CameraScannerCard extends StatelessWidget {
  const CameraScannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            CustomText(
              text: loc.camera_scanner,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 12.h),
            CameraContainer(),
            SizedBox(height: 26.h),

            CustomText(
              text: loc.scan_qr_description,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 26.h),

            CustomElevatedButton(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              backgroundColor: ColorManger.primaryRed,
              foregroundColor: ColorManger.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteManger.scanQrCode);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 16),
                  const SizedBox(width: 4),
                  CustomText(
                    text: loc.start_scanning,
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.pureWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
