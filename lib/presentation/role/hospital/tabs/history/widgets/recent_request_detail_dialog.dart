import 'package:blood_donation_app/core/extension/data_ex.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/blood_request_status_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/completion_time_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/recent_request_body.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/recent_request_button.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/request_detail_note.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/models/blood_request_history.dart';
import '../../../../../../l10n/app_localizations.dart';

class RecentRequestDetailDialog extends StatelessWidget {
  const RecentRequestDetailDialog({super.key, required this.bloodRequestModel});

  final BloodRequestHistoryModel bloodRequestModel;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RequestHeader(
                  title: appLocalization.requestDetails,
                  subtitle: appLocalization.requestDetailsSubtitle,
                ),
                SizedBox(height: 8),
                BloodRequestStatusCard(
                  bloodType: bloodRequestModel.bloodType,
                  isFulfilled: bloodRequestModel.isFulfilled,
                  requestDate: bloodRequestModel.bloodRequestModel.requestDate
                      .toDateOnlyNumeric(),
                ),
                SizedBox(height: 8),
                RecentRequestBody(
                  bloodRequestModel: bloodRequestModel.bloodRequestModel,
                ),
                SizedBox(height: 8),
                bloodRequestModel.bloodRequestModel.isFulfilled
                    ? CompletionTimeCard(
                        completionTimeInHours: bloodRequestModel
                            .bloodRequestModel
                            .completionTimeInHours,
                      )
                    : SizedBox(),
                SizedBox(height: 8),
                RequestDetailNote(),

                SizedBox(height: 16),
                RecentRequestButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
