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
    return ValueListenableBuilder(
      valueListenable: RewardsScreen.userPoints,
      builder: (context,currentPoints,child){
        bool isAvailable = currentPoints >= neededPoints? true : false;
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: isAvailable ? ColorManger.softRed : Color(0xFFF5F5F5), shape: BoxShape.circle),
                  child: Icon(icon, color: isAvailable? Color(0xFFFF0F22) : Colors.grey, size: 28),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText(
                    text: title,
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
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
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (label != null && isAvailable == false)
                        Text(
                          label!,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

    );
  }
}
