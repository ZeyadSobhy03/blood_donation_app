import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool isOutlineRed;
  const ControlButton(this.label, this.color, this.isOutlineRed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isOutlineRed ? Colors.red.shade200 : Colors.orange.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.power_settings_new, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
