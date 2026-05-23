import 'package:flutter/material.dart';

class StepperButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const StepperButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}