import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../widgets/request_detail_item.dart';

class RequestDetailBody extends StatelessWidget {
  const RequestDetailBody({
    super.key,
    required this.bloodType,
    required this.unitsNeeded,
    required this.urgency,
    required this.timeLeft,
    required this.responseCount,
    required this.confirmedCount,
  });

  final String bloodType;
  final int unitsNeeded;
  final String urgency;
  final int timeLeft;
  final int responseCount;
  final int confirmedCount;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequestDetailItem(label: appLocalizations.blood_type, text: bloodType),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.units_needed,
          text: appLocalizations.units_needed_count(unitsNeeded),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(label: appLocalizations.urgency, text: urgency),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.time_left_label,
          text: appLocalizations.time_left(timeLeft),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.response,
          text: appLocalizations.donors_have_responded(responseCount),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.confirmed,
          text: '$confirmedCount',
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
