import 'package:blood_donation_app/core/widgets/custom_badge_card.dart';
import 'package:blood_donation_app/core/widgets/custom_stat_card.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class BadgesTab extends StatelessWidget {
  const BadgesTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth >= 1200
        ? 4
        : screenWidth >= 900
        ? 3
        : screenWidth >= 600
        ? 3
        : 2;

    final double childAspectRatio = screenWidth >= 1200
        ? 0.95
        : screenWidth >= 900
        ? 0.90
        : screenWidth >= 600
        ? 0.85
        : 0.80;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth >= 900 ? 32 : 20,
        vertical: 20,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: CustomStatCard(
                icon: Icons.emoji_events,
                value: "3",
                label: appLocalizations.badge_unlocked,
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomStatCard(
                icon: Icons.adjust,
                value: "6",
                label: appLocalizations.total,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomStatCard(
                icon: Icons.star_border,
                value: "50%",
                label: appLocalizations.completed,
                color: Colors.purple,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        CustomText(
          text: appLocalizations.your_badges,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: childAspectRatio,
          children: [
            CustomBadgeCard(
              icon: Icons.favorite_border,
              title: appLocalizations.first_timer,
              subtitle: appLocalizations.completed_first_donation,
              isUnlocked: true,
              times: "",
            ),
            CustomBadgeCard(
              icon: Icons.emoji_events_outlined,
              title: appLocalizations.regular_donor,
              subtitle: appLocalizations.donated_5_times,
              isUnlocked: true,
              times: "",
            ),
            CustomBadgeCard(
              icon: Icons.star_border,
              title: appLocalizations.life_saver,
              subtitle: appLocalizations.donated_10_times,
              isUnlocked: true,
              times: "",
            ),
            CustomBadgeCard(
              icon: Icons.tag_faces_outlined,
              title: appLocalizations.hero,
              subtitle: appLocalizations.donated_20_times,
              isUnlocked: false,
              times: "",
            ),
            CustomBadgeCard(
              icon: Icons.bolt,
              title: appLocalizations.legend,
              subtitle: appLocalizations.donated_50_times,
              isUnlocked: false,
              times: "",
            ),
            CustomBadgeCard(
              icon: Icons.emergency_share,
              title: appLocalizations.emergency_responder,
              subtitle: appLocalizations.responded_to_10_emergencies,
              isUnlocked: false,
              times: "",
            ),
          ],
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}