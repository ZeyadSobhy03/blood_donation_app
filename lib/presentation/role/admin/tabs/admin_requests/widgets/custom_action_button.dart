import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;
  const CustomActionButton({super.key, required this.label, this.icon, required this.bgColor, required this.textColor, this.borderColor, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            CustomText(
              text: label,
              textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
