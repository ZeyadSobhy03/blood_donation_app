import 'package:flutter/material.dart';

class CustomSummaryItem extends StatelessWidget {
  final int count;
  final String label;
  final Color bg;
  final Color text;
  const CustomSummaryItem({super.key, required this.count, required this.label, required this.bg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: text.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Text('$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: text)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: text.withValues(alpha: 0.8), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
