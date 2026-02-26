import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class DonorTile extends StatelessWidget {
  const DonorTile({
    super.key,
    required this.bloodType,
    required this.numberOfDonor,
  });

  final String bloodType;
  final int numberOfDonor;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManger.brightRed,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: CustomText(
            text: bloodType,
            textStyle: TextStyle(
              color: ColorManger.pureWhite,
              fontWeight: FontWeightManager.semiBold,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        SizedBox(height: 4),
        CustomText(
          text:
              '$numberOfDonor ${numberOfDonor > 1 ? appLocalizations.donors : appLocalizations.donor}',
          textStyle: TextStyle(
            color: ColorManger.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: FontSize.s14,
          ),
        ),
        SizedBox(height: 4),
        CustomText(
          text: appLocalizations.donor_available(5),
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s12,
          ),
        ),
      ],
    );
  }
}
