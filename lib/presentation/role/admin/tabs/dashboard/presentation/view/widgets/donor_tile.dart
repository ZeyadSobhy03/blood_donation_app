import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DonorTile extends StatelessWidget {
  const DonorTile({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    required this.completedDonations,
    required this.showLastDonation,
    required this.showActivityStatus,
    this.lastDonation,
    this.isActive, this.location,
  });

  final int rank;
  final String name;
  final int points;
  final int completedDonations;
  final bool showLastDonation;
  final bool showActivityStatus;
  final String? lastDonation;
  final bool? isActive;
  final String? location;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    Color rankColor(int rank) {
      if (rank == 1) return ColorManger.yellow;
      if (rank == 2) return ColorManger.silver;
      if (rank == 3) return ColorManger.bronze;
      return ColorManger.slateGrey;
    }

    String formatDate(String? isoDate) {
      if (isoDate == null) return '-';
      try {
        final date = DateTime.parse(isoDate);
        return '${date.day}/${date.month}/${date.year}';
      } catch (_) {
        return isoDate;
      }
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
              color: rankColor(rank),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                text: rank.toString(),
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  textStyle: TextStyle(
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: '$completedDonations ${loc.donations}',
                  textStyle: TextStyle(
                    fontSize: FontSize.s12,
                    color: ColorManger.slateGrey,
                  ),
                ),
                if (location != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: ColorManger.slateGrey,
                      ),
                      const SizedBox(width: 2),
                      CustomText(
                        text: location!,
                        textStyle: TextStyle(
                          fontSize: FontSize.s12,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ],
                if (showLastDonation) ...[
                  const SizedBox(height: 2),
                  CustomText(
                    text: '${loc.lastDonation} : ${formatDate(lastDonation)}',
                    textStyle: TextStyle(
                      fontSize: FontSize.s12,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorManger.lightRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: '$points ${loc.points}',
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (showActivityStatus)
                Container(
                  decoration: BoxDecoration(
                    color: (isActive ?? false)
                        ? ColorManger.green
                        : ColorManger.slateGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: CustomText(
                      text: (isActive ?? false) ? loc.active : loc.inactive,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}