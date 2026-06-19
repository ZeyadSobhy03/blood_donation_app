import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomStatCard extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;
  final Color bgColor;
  final Color iconColor;
  const CustomStatCard({super.key,
    required this.icon,
    required this.count,
    required this.label,
    required this.bgColor,
    required this.iconColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 16),
          CustomText(
            text: count,
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: label,
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
