import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_summary_item.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {

    final loc = AppLocalizations.of(context)!;

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
                  count: "42",
                  label: loc.fulfilled,
                  bg: const Color(0xFFE8F5E9),
                  text: const Color(0xFF2E7D32),
                ),

                const SizedBox(width: 12),

                CustomSummaryItem(
                  count: "3",
                  label: loc.active,
                  bg: const Color(0xFFFFF3E0),
                  text: const Color(0xFFEF6C00),
                ),

                const SizedBox(width: 12),

                CustomSummaryItem(
                  count: "2",
                  label: loc.cancelled,
                  bg: const Color(0xFFFFEBEE),
                  text: const Color(0xFFC62828),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              loc.recentRequests,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            /// Requests
            CustomRequestCard(
              type: "O+ ${loc.bloodRequest}",
              units: 3,
              date: "Sep 28, 2024",
              priority: loc.critical,
              status: loc.fulfilled,
              color: Colors.green,
            ),

            CustomRequestCard(
              type: "A- ${loc.bloodRequest}",
              units: 2,
              date: "Sep 15, 2024",
              priority: loc.high,
              status: loc.fulfilled,
              color: Colors.green,
            ),

            CustomRequestCard(
              type: "B+ ${loc.bloodRequest}",
              units: 4,
              date: "Mar 20, 2024",
              priority: loc.high,
              status: loc.fulfilled,
              color: Colors.green,
            ),

            CustomRequestCard(
              type: "A+ ${loc.bloodRequest}",
              units: 1,
              date: "Jun 3, 2024",
              priority: loc.critical,
              status: loc.cancelled,
              color: Colors.red,
            ),

            CustomRequestCard(
              type: "AB- ${loc.bloodRequest}",
              units: 3,
              date: "Feb 13, 2024",
              priority: loc.critical,
              status: loc.fulfilled,
              color: Colors.green,
            ),

            CustomRequestCard(
              type: "O- ${loc.bloodRequest}",
              units: 2,
              date: "Apr 23, 2024",
              priority: loc.low,
              status: loc.cancelled,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}