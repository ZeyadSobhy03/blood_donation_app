import 'package:blood_donation_app/core/extension/data_ex.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomHistoryItem extends StatelessWidget {
  final String title;
  final DateTime? date;
  final int points;

  const CustomHistoryItem({
    super.key,
    required this.title,
    this.date,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 10, color: Color(0xFF4CAF50)),
          // Green dot
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              CustomText(
                text: date != null ? "${date?.toTimeAgo(context)} " : "",
                textStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9), // Light Green
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomText(
              text: points > 0
                  ? '+$points'
                  : '$points',

              textStyle: TextStyle(
                color: points > 0
                    ? const Color(0xFF2E7D32)
                    : Colors.red,

                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
