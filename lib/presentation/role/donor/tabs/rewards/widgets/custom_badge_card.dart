import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomBadgeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isUnlocked;
  final String times;

  const CustomBadgeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isUnlocked,
    required this.times,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    final bool isDesktop = screenWidth >= 1200;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;
    final bool isMobile = screenWidth < 600;

    // Card should never grow beyond a reasonable size
    final double maxCardWidth = isDesktop ? 220 : isTablet ? 200 : 180;
    final double cardHeight = isDesktop ? 175 : isTablet ? 180 : 185;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxCardWidth,
        minWidth: isMobile ? 140 : maxCardWidth,
      ),
      child: SizedBox(
        height: cardHeight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Circle
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? const Color(0xFFFFEBEE)
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isUnlocked
                      ? const Color(0xFFFF0F22)
                      : Colors.grey,
                  size: 26,
                ),
              ),

              const SizedBox(height: 10),

              // Title
              CustomText(
                text: title,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 5),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomText(
                  text: subtitle,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10.5,
                    height: 1.4,
                  ),
                  maxLines: 2,
                ),
              ),

              const SizedBox(height: 10),

              // Status row
              if (isUnlocked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: appLocalizations.badge_unlocked,
                      textStyle: const TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 13,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      text: times,
                      textStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}