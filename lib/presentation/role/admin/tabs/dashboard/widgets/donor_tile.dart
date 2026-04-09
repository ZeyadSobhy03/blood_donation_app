import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/models/donor.dart';

class DonorTile extends StatelessWidget {
  const DonorTile({
    super.key,
    required this.donor,
    required this.showLastDonation,
    required this.showActivityStatus,
  });

  final DonorModel donor;
  final bool showLastDonation;
  final bool showActivityStatus;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    Color rankColor(int rank) {
      if (rank == 1) return ColorManger.yellow;
      if (rank == 2) return ColorManger.silver;
      if (rank == 3) return ColorManger.bronze;
      return ColorManger.slateGrey;
    }

    return Container(
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: rankColor(donor.donorRank),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                text: donor.donorRank.toString(),
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: donor.name,
                  textStyle: TextStyle(
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                  ),
                ),
                SizedBox(height: 2),
                CustomText(
                  text: '${donor.totalDonations} ${loc.donations}',
                  textStyle: TextStyle(
                    fontSize: FontSize.s12,
                    color: ColorManger.slateGrey,
                  ),
                ),
                if (showLastDonation)
                  if (showLastDonation) ...[
                    const SizedBox(height: 2),
                    CustomText(
                      text: '${loc.lastDonation} : ${donor.lastDonationDate}',
                      textStyle: TextStyle(
                        fontSize: FontSize.s12,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                  ],
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              CustomText(
                text: '${donor.totalDonations}',
                textStyle: TextStyle(
                  color: ColorManger.orange,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(height: 2),
              CustomText(
                text: loc.points,
                textStyle: TextStyle(
                  fontSize: FontSize.s12,
                  color: ColorManger.slateGrey,
                ),
              ),
              SizedBox(height: 4),
              showActivityStatus
                  ? Container(
                      decoration: BoxDecoration(
                        color: ColorManger.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        child: CustomText(
                          text: donor.isActive ? loc.active : loc.inactive,
                          textStyle: TextStyle(
                            color: ColorManger.pureWhite,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
