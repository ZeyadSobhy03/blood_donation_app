import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/sections/upcoming_rewards_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/models/badge_data.dart';
import '../../../../../../../../l10n/app_localizations.dart';

import '../widgets/badge_tile.dart';

class AchievementBadgesCard extends StatelessWidget {
  const AchievementBadgesCard({super.key, required this.badges});

  final List<BadgeData> badges;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black12,
        color: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomText(
                text: '${loc.achievement_badges} 🏅',
                textStyle: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.black,
                ),
              ),

              const SizedBox(height: 18),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: badges.map((badge) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                          width:110.w,
                          child: BadgeTile(badge: badge)),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              const UpcomingRewardsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
