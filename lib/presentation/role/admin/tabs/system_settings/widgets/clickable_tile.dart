import 'package:flutter/material.dart';

class ClickableTile extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  const ClickableTile({super.key,
    this.icon,
    required this.label,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 12)],
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
