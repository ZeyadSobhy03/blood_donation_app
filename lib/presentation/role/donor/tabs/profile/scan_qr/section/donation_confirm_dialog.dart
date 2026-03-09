import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/section/donation_confirm_header.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/section/donation_details_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/section/earned_points_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/models/donation_details.dart';
import '../../../../../../../l10n/app_localizations.dart';

class DonationConfirmDialog extends StatelessWidget {
  final int pointsEarned;
  final DonationDetails donation;

  const DonationConfirmDialog({
    super.key,
    required this.pointsEarned,
    required this.donation,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: ColorManger.slateGrey),
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              // Success header
              DonationConfirmHeader(),

              SizedBox(height: 8.h),

              // Earned points
              EarnedPointsCard(pointsEarned: pointsEarned),

              SizedBox(height: 8.h),

              // Donation details
              DonationDetailsCard(donation: donation),

              SizedBox(height: 8.h),

              // Thank you message
              CustomText(
                text: loc.donation_thank_you,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              // Buttons row
              Row(
                children: [
                  // Close button
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.pureWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: ColorManger.grey300, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      foregroundColor: ColorManger.black,
                      onPressed: () => Navigator.of(context).pop(),
                      child: CustomText(
                        text: loc.close,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // View points button
                  Expanded(
                    child: CustomElevatedButton(
                      foregroundColor: ColorManger.pureWhite,
                      backgroundColor: ColorManger.primaryRed,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteManger.donorMainLayout,
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomText(
                        text: loc.view_points,
                        textStyle: TextStyle(
                          color: ColorManger.pureWhite,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}