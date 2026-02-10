import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/requirement_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class EligibilityChecklistCard extends StatelessWidget {
  const EligibilityChecklistCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    List<String> requirements = [
      appLocalization.reqAge,
      appLocalization.reqWeight,
      appLocalization.reqLastDonation,
      appLocalization.reqNoIllness,
      appLocalization.reqNoTattoos,
    ];
    return Card(
      color: ColorManger.lightGreen,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: ColorManger.green.withValues(alpha: 0.6)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: requirements
              .map(
                (element) => RequirementRow(
                  icon: Icons.check_circle_outline,
                  text: element,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
