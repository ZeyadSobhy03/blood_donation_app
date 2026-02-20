import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';

class CustomRedeemCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final String title;
  final int neededPoints;
  final String? label;
  final VoidCallback onTap;

  const CustomRedeemCard({
    super.key,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.title,
    required this.neededPoints,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing — same breakpoints as BadgesTab / RewardsTab
    final double maxCardWidth = screenWidth >= 1200
        ? 220
        : screenWidth >= 900
        ? 200
        : screenWidth >= 600
        ? 200
        : 180;

    final double iconSize = screenWidth >= 900 ? 28 : 24;
    final double iconPadding = screenWidth >= 900 ? 16 : 13;
    final double titleFontSize = screenWidth >= 900 ? 14 : 13;
    final double pointsFontSize = screenWidth >= 900 ? 12 : 11;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxCardWidth),
      child: ValueListenableBuilder(
        valueListenable: RewardsScreen.userPoints,
        builder: (context, currentPoints, child) {
          final bool isAvailable = currentPoints >= neededPoints;

          return GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(iconPadding),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? ColorManger.softRed
                            : const Color(0xFFF5F5F5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: isAvailable
                            ? const Color(0xFFFF0F22)
                            : Colors.grey,
                        size: iconSize,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: title,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 14,
                        left: 12,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isAvailable
                                  ? const Color(0xFFFFEBEE)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomText(
                              text: "$neededPoints ${appLocalizations.points}",
                              textStyle: TextStyle(
                                color: isAvailable
                                    ? const Color(0xFFFF0F22)
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: pointsFontSize,
                              ),
                            ),
                          ),
                          if (label != null && !isAvailable)
                            Text(
                              label!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: pointsFontSize,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}