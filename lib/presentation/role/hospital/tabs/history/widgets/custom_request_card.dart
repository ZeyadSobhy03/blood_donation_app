import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/recent_request_detail_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class CustomRequestCard extends StatelessWidget {
  final String type;
  final int units;
  final String date;
  final String priority;
  final String status;
  final Color color;

  const CustomRequestCard({
    super.key,
    required this.type,
    required this.units,
    required this.date,
    required this.priority,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final BloodRequestModel model = BloodRequestModel(
      bloodType: 'O+',
      unitsRequested: 2,
      urgencyLevel: 'low',
      donorsContacted: 12,
      donorsConfirmed: 13,
      isFulfilled: true,
      requestDate: DateTime.now(),
      completionTimeInHours: 3,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                status == "Fulfilled"
                    ? Icons.check_circle_outline
                    : Icons.cancel_outlined,
                color: color,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                        "${appLocalization.unitsCount(units)} • $date",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  priority,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RecentRequestDetailDialog(bloodRequestModel: model);
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child:  Text(
                appLocalization.viewDetails,

                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
