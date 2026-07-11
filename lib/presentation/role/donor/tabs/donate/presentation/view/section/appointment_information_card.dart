import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../schedule_donation/presentation/view/widgets/review_row.dart';

class AppointmentInformationCard extends StatelessWidget {
  const AppointmentInformationCard({
    super.key,
    required this.location,
    required this.formattedDate,
    required this.donationType,
  });

  final String location;
  final String formattedDate;
  final String donationType;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManger.pureWhite.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalizations.appointmentInformation,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 16),
            ReviewRow(
              iconColor: ColorManger.slateGrey,
              isContact: false,
              icon: Icons.location_on_outlined,
              title: appLocalizations.location,
              subTitle: location,
            ),
            SizedBox(height: 8,),
            ReviewRow(
              iconColor: ColorManger.slateGrey,
              isContact: false,
              icon: Icons.date_range,
              title: appLocalizations.dateTime,
              subTitle: formattedDate,
            ),
            SizedBox(height: 8,),
            ReviewRow(
              title: appLocalizations.donationType,
              subTitle: donationType,
              icon: Icons.favorite_border,
              isContact: false,
              iconColor: ColorManger.slateGrey,
            ),
          ],
        ),
      ),
    );
  }
}
