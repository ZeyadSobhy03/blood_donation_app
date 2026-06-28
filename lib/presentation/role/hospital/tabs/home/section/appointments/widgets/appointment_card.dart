import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/data/models/appointment_list_model.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onViewDetail,
    required this.onScanQr,
  });

  final AppointmentListItem appointment;
  final VoidCallback onViewDetail;
  final VoidCallback onScanQr;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final donor = appointment.donorDetails;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: ColorManger.royalBlue.withValues(alpha: 0.1),
              child: Icon(
                Icons.person,
                color: ColorManger.royalBlue,
                size: 28,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: donor?.fullName ?? loc.unknown,
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManger.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManger.brightRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomText(
                          text: donor?.bloodType ?? '-',
                          textStyle: TextStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManger.brightRed,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CustomText(
                        text: '${donor?.phoneNumber ?? ''}',
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomElevatedButton(
                  onPressed: onViewDetail,
                  backgroundColor: ColorManger.pureWhite,
                  foregroundColor: ColorManger.royalBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: ColorManger.royalBlue),
                  ),
                    child: CustomText(
                    text: loc.view_details,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      color: ColorManger.royalBlue,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                CustomElevatedButton(
                  onPressed: onScanQr,
                  backgroundColor: ColorManger.royalBlue,
                  foregroundColor: ColorManger.pureWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                    child: CustomText(
                    text: loc.scan_qr_code,
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      color: ColorManger.pureWhite,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
