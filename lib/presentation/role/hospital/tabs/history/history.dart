import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/core/resources/models/summary_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_summary_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/recent_request_detail_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/models/blood_request_history.dart';
import '../../../../../l10n/app_localizations.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final List<BloodRequestHistoryModel> requests = [
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: true,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "O+",
        units: 3,
        date: DateTime(2024, 9, 28),
        priority: loc.critical,
        status: loc.fulfilled,
        isFulfilled: true,
      ),
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: true,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "A-",
        units: 2,
        date: DateTime(2024, 9, 15),
        priority: loc.high,
        status: loc.fulfilled,
        isFulfilled: true,
      ),
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: true,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "B+",
        units: 4,
        date: DateTime(2024, 3, 20),
        priority: loc.high,
        status: loc.fulfilled,
        isFulfilled: true,
      ),
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: false,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "A+",
        units: 1,
        date: DateTime(2024, 6, 3),
        priority: loc.critical,
        status: loc.cancelled,
        isFulfilled: false,
      ),
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: true,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "AB-",
        units: 3,
        date: DateTime(2024, 2, 13),
        priority: loc.critical,
        status: loc.fulfilled,
        isFulfilled: true,
      ),
      BloodRequestHistoryModel(
        bloodRequestModel: BloodRequestModel(
          bloodType: 'O+',
          unitsRequested: 12,
          urgencyLevel: 'low',
          donorsContacted: 13,
          donorsConfirmed: 20,
          isFulfilled: false,
          requestDate: DateTime.now(),
          completionTimeInHours: 1,
        ),
        bloodType: "O-",
        units: 2,
        date: DateTime(2024, 4, 23),
        priority: loc.low,
        status: loc.cancelled,
        isFulfilled: false,
      ),
    ];
    final SummaryModel summaryModel = SummaryModel(
      completed: 42,
      active: 3,
      cancelled: 2,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        title: Text(
          loc.requestHistory,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              loc.trackBloodRequests,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// Summary
            Row(
              children: [
                CustomSummaryItem(
                  count: summaryModel.completed,
                  label: loc.fulfilled,
                  bg: const Color(0xFFE8F5E9),
                  text: const Color(0xFF2E7D32),
                ),

                const SizedBox(width: 12),

                CustomSummaryItem(
                  count: summaryModel.active,
                  label: loc.active,
                  bg: const Color(0xFFFFF3E0),
                  text: const Color(0xFFEF6C00),
                ),

                const SizedBox(width: 12),

                CustomSummaryItem(
                  count: summaryModel.cancelled,
                  label: loc.cancelled,
                  bg: const Color(0xFFFFEBEE),
                  text: const Color(0xFFC62828),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              loc.recentRequests,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            ListView.builder(
              itemCount: requests.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomRequestCard(
                  isFulfilled: requests[index].isFulfilled ,
                  type: "${requests[index].bloodType} ${loc.bloodRequest}",
                  units: requests[index].units,
                  date:
                      "${requests[index].date.month}/${requests[index].date.day}/${requests[index].date.year}",
                  priority: requests[index].priority,
                  status: requests[index].status,
                  color: requests[index].isFulfilled
                      ? Colors.green
                      : Colors.red,

                  onViewDetails: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return RecentRequestDetailDialog(
                          bloodRequestModel: requests[index],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
