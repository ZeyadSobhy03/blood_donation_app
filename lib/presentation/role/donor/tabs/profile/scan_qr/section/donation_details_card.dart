import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/donation_details.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/widgets/detail_row.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/widgets/status_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../l10n/app_localizations.dart';

class DonationDetailsCard extends StatelessWidget {
  const DonationDetailsCard({super.key, required this.donation});

  final DonationDetails donation;

  String getFormattedDate(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    const monthsEn = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    const monthsAr = [
      'يناير','فبراير','مارس','أبريل','مايو','يونيو',
      'يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'
    ];

    final months = appLocalization.localeName.startsWith('ar') ? monthsAr : monthsEn;

    return '${donation.date.day} ${months[donation.date.month - 1]} ${donation.date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.grey300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.donationDetails,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 12.h),
            DetailRow(
              label: appLocalization.locationLabel,
              value: donation.location,
            ),
            SizedBox(height: 8.h),
            DetailRow(
              label: appLocalization.dateLabel,
              value: getFormattedDate(context),
            ),
            SizedBox(height: 8.h),
            DetailRow(
              label: appLocalization.typeLabel,
              value: donation.type,
            ),
            SizedBox(height: 8.h),
            StatusRow(donation: donation),
          ],
        ),
      ),
    );
  }
}