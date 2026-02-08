import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;

  const CustomLabel({
    required this.text,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D2D2D),
        ),
      );
    }
  }
