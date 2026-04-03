import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/request_detail_row.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class RecentRequestBody extends StatelessWidget {
  const RecentRequestBody({super.key, required this.bloodRequestModel});

  final BloodRequestModel bloodRequestModel;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      children: [
        RequestDetailRow(
          label: appLocalization.bloodType,
          value: bloodRequestModel.bloodType,
        ),
        RequestDetailRow(
          label: appLocalization.unitsRequested,
          value: bloodRequestModel.unitsRequested.toString(),
        ),
        RequestDetailRow(
          label: appLocalization.urgencyLevel,
          value: bloodRequestModel.urgencyLevel == 'low'
              ? appLocalization.low
              : bloodRequestModel.urgencyLevel == 'medium'
              ? appLocalization.medium
              : appLocalization.high,
        ),
        RequestDetailRow(
          label: appLocalization.donorsContacted,
          value: bloodRequestModel.donorsContacted.toString(),
        ),
        RequestDetailRow(
          label: appLocalization.donorsConfirmed,
          value: bloodRequestModel.donorsConfirmed.toString(),
        ),
      ],
    );
  }
}
