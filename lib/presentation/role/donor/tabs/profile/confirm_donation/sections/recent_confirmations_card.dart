import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/confirmation_data.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/widgets/confirmation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class RecentConfirmationsCard extends StatelessWidget {
  const RecentConfirmationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    List<ConfirmationData> confirmationData = [
      ConfirmationData(
        hospitalName: 'City Hospital',
        date: DateTime(2024, 6, 15),
        points: 50,
      ),
      ConfirmationData(
        points: 30,
        hospitalName: 'Green Valley Clinic',
        date: DateTime(2024, 5, 10),
      ),
      ConfirmationData(
        hospitalName: 'Sunrise Medical Center',
        date: DateTime(2024, 4, 5),
        points: 40,
      ),
    ];
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: loc.recent_confirmations,
              textStyle: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              itemCount: confirmationData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = confirmationData[index];
                return ConfirmationTile(confirmationData: data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
