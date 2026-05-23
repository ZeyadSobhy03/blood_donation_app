import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/models/badge_data.dart';


class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
    required this.chipColor,
  });

  final BadgeStatus status;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final bool isEarned = status == BadgeStatus.earned;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isEarned
            ? chipColor
            : ColorManger.grey200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: isEarned ? loc.earned : loc.locked,
        textStyle: TextStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: isEarned
              ? ColorManger.pureWhite
              : ColorManger.grey600,
        ),
      ),
    );
  }
}
