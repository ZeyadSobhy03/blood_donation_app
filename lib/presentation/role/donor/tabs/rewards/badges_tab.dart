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
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Expanded(child: CustomStatCard(icon: Icons.emoji_events, value: "3", label: appLocalizations.badge_unlocked, color: Colors.amber)),
            SizedBox(width: 12),
            Expanded(child: CustomStatCard(icon: Icons.adjust, value: "6", label: appLocalizations.total, color: Colors.blue)),
            SizedBox(width: 12),
            Expanded(child: CustomStatCard(icon: Icons.star_border, value: "50%", label: appLocalizations.completed, color: Colors.purple)),
          ],
        ),
        const SizedBox(height: 24),
        CustomText(text: appLocalizations.your_badges, textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
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