import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestDetailsSection extends StatelessWidget {
  const RequestDetailsSection({
    super.key,
    required this.posted,
    required this.patientType,
    required this.contact,
  });

  final String posted;
  final String patientType;
  final String contact;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.requestDetails,
              textStyle: TextStyle(
                height: 1.4,
                color: ColorManger.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 16.h),
            _buildInfoRow(appLocalization.posted, posted, Icons.access_time),
            SizedBox(height: 8.h),
            _buildInfoRow(
              appLocalization.patientType,
              patientType,
              Icons.person,
            ),
            SizedBox(height: 8.h),
            _buildInfoRow(appLocalization.contact, contact, Icons.phone),
          ],
        ),
      ),
    );
  }

  _buildInfoRow(String title, String subTitle, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: ColorManger.slateGrey, size: 22.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.slateGrey,
              ),
            ),
            SizedBox(width: 4.w),
            CustomText(
              text: subTitle,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManger.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
