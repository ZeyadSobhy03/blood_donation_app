import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key, required this.totalDonations});
  final int totalDonations;

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    return  Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: ColorManger.pureWhite,),
        ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.donationHistory,
              textStyle: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: ColorManger.pureWhite,
              ),
            ),
            SizedBox(height: 6),
            CustomText(
              text: '$totalDonations ${appLocalization.totalDonations}',

              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
