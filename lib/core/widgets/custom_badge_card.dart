import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomBadgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isUnlocked;
  final String times;

  const CustomBadgeCard({super.key, required this.icon, required this.title, required this.subtitle, required this.isUnlocked, required this.times});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUnlocked ? const Color(0xFFFFEBEE) : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isUnlocked ? const Color(0xFFFF0F22) : Colors.grey, size: 30),
          ),
          const SizedBox(height: 16),
          CustomText(text: title, textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomText(
              text: subtitle,
              textAlign: TextAlign.center,
              textStyle: TextStyle(color: Colors.grey[600], fontSize: 11),
              maxLines: 2,
            ),
          ),
          const Spacer(),
          if (isUnlocked)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF4CAF50)),
                  SizedBox(width: 4),
                  CustomText(text: appLocalizations.badge_unlocked, textStyle: TextStyle(color: Color(0xFF4CAF50), fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          if (!isUnlocked)
            const SizedBox(height: 16),
        ],
      ),
    );
  }
}