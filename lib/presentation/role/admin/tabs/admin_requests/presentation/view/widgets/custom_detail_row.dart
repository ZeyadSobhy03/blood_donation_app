import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDetailRow extends StatelessWidget {
  final String label;
  final String value;
  const CustomDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: label,
              textStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
          Expanded(
            child: CustomText(text: value,
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
