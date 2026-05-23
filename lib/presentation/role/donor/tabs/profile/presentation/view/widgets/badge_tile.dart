import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/models/badge_data.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'medal_icon.dart';



class BadgeTile extends StatelessWidget {
  const BadgeTile({super.key, required this.badge});

  final BadgeData badge;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: badge.isEarned ? badge.backgroundColor : ColorManger.grey100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: badge.isEarned ? badge.borderColor : ColorManger.grey300,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MedalIcon(
            backgroundColor: badge.isEarned
                ? badge.iconColor.withValues(alpha: 0.15)
                : ColorManger.grey300,
            iconColor: badge.isEarned ? badge.iconColor : ColorManger.grey500,
          ),

          const SizedBox(height: 10),

          CustomText(
            text: badge.label,
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
              color: badge.isEarned ? badge.iconColor : ColorManger.grey600,
            ),
          ),

          const SizedBox(height: 4),

          CustomText(
            text: '${badge.points} ${loc.points_short}',
            textStyle: TextStyle(
              fontSize: FontSize.s12,
              color: ColorManger.grey600,
            ),
          ),

          const SizedBox(height: 12),

          StatusChip(status: badge.status, chipColor: badge.iconColor),
        ],
      ),
    );
  }
}
