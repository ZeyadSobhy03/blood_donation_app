import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/info_row.dart';

class HospitalExtraInfo extends StatelessWidget {
  const HospitalExtraInfo({
    super.key,
    required this.distanceKm,
    required this.urgentNeedsCount,
  });

  final double distanceKm;
  final int urgentNeedsCount;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Row(
      children: [
        InfoRow(
          icon: Icons.location_on_outlined,
          text: appLocalization.distanceKm(distanceKm.toStringAsFixed(1)),
        ),
        SizedBox(width: 12.w),
        InfoRow(
          icon: Icons.favorite_border,
          text: appLocalization.urgentNeeds(urgentNeedsCount),
        ),
      ],
    );
  }
}
