import 'package:flutter/material.dart';

class CustomBulletPoint extends StatelessWidget {
  final String text;
  const CustomBulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Color(0xFF1565C0)),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.blue[800], fontSize: 13)),
        ],
      ),
    );
  }
}
