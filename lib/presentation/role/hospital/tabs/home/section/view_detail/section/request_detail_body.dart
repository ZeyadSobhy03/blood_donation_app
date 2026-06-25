import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/models/home_request_detail_model.dart';
import '../../../../request/data/model/request_enum_mapper.dart';
import '../../../widgets/request_detail_item.dart';

class RequestDetailBody extends StatelessWidget {
  const RequestDetailBody({super.key, required this.detail});

  final HomeRequestDetailData detail;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequestDetailItem(
          label: appLocalizations.blood_type,
          text: detail.bloodTypeDisplay,
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.units_needed,
          text: appLocalizations.units_needed_count(detail.unitsNeeded ?? 0),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.urgency,
          text: RequestEnumMapper.urgencyKeyToDisplay(detail.urgency, appLocalizations),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.time_left_label,
          text: detail.timeRemaining ?? '-',
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.response,
          text: appLocalizations.donors_have_responded(detail.responded ?? 0),
        ),
        SizedBox(height: 8.h),
        RequestDetailItem(
          label: appLocalizations.confirmed,
          text: '${detail.confirmed ?? 0}',
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
