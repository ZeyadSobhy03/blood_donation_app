import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_bullet_point.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_confirmation_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_history_item.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_redeem_card.dart';
import 'package:flutter/material.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({super.key});

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive columns — same breakpoints as BadgesTab
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

    final double horizontalPadding = screenWidth >= 900 ? 32 : 20;

    void handleRedeem(int cost, String title, IconData icon) {
      if (RewardsScreen.userPoints.value >= cost) {
        showDialog(
          context: context,
          builder: (context) =>
              CustomConfirmationDialog(cost: cost, title: title, icon: icon),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(text: appLocalizations.not_enough_points),
          ),
        );
      }
    }

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 20,
      ),
      children: [
        CustomText(
          text: appLocalizations.redeem_points,
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
            CustomRedeemCard(
              icon: Icons.card_giftcard,
              color: ColorManger.softRed,
              iconColor: const Color(0xFFFF0F22),
              title: appLocalizations.coffee_voucher,
              neededPoints: 500,
              onTap: () => handleRedeem(
                  500, appLocalizations.coffee_voucher, Icons.coffee),
              label: appLocalizations.soon,
            ),
            CustomRedeemCard(
              icon: Icons.movie_creation_outlined,
              color: ColorManger.softRed,
              iconColor: const Color(0xFFFF0F22),
              title: appLocalizations.movie_tickets,
              neededPoints: 1000,
              onTap: () => handleRedeem(
                  1000, appLocalizations.movie_tickets, Icons.movie),
              label: appLocalizations.soon,
            ),
            CustomRedeemCard(
              icon: Icons.restaurant,
              color: ColorManger.softRed,
              iconColor: const Color(0xFFFF0F22),
              title: appLocalizations.restaurant_gift_card,
              neededPoints: 1500,
              onTap: () => handleRedeem(1500,
                  appLocalizations.restaurant_gift_card, Icons.restaurant),
              label: appLocalizations.soon,
            ),
            CustomRedeemCard(
              icon: Icons.favorite_border,
              color: ColorManger.softRed,
              iconColor: const Color(0xFFFF0F22),
              title: appLocalizations.health_check_up,
              neededPoints: 2000,
              onTap: () => handleRedeem(2000, appLocalizations.health_check_up,
                  Icons.favorite_outline),
              label: appLocalizations.soon,
            ),
            CustomRedeemCard(
              icon: Icons.workspace_premium,
              color: const Color(0xFFF5F5F5),
              iconColor: Colors.grey,
              title: appLocalizations.premium_badge,
              neededPoints: 2500,
              onTap: () => handleRedeem(2500, appLocalizations.premium_badge,
                  Icons.workspace_premium),
              label: appLocalizations.soon,
            ),
            CustomRedeemCard(
              icon: Icons.electric_bolt_outlined,
              color: const Color(0xFFF5F5F5),
              iconColor: Colors.grey,
              title: appLocalizations.gym_membership,
              neededPoints: 3000,
              onTap: () => handleRedeem(3000, appLocalizations.gym_membership,
                  Icons.electric_bolt_outlined),
              label: appLocalizations.soon,
            ),
          ],
        ),

        const SizedBox(height: 30),

        // ── Points History ───────────────────────────────────────
        CustomText(
          text: appLocalizations.points_history,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        CustomHistoryItem(
          title: appLocalizations.blood_donation,
          date: appLocalizations.days_ago(1),
          points: "+200",
        ),
        CustomHistoryItem(
          title: appLocalizations.emergency_response,
          date: appLocalizations.week_1_ago,
          points: "+100",
        ),
        CustomHistoryItem(
          title: appLocalizations.profile_completion,
          date: appLocalizations.weeks_2_ago,
          points: "+50",
        ),
        CustomHistoryItem(
          title: appLocalizations.referral_bonus,
          date: appLocalizations.weeks_3_ago,
          points: "+150",
        ),

        const SizedBox(height: 30),

        // ── How to Earn Points ───────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBBDEFB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.trending_up, color: Color(0xFF1976D2)),
                  const SizedBox(width: 8),
                  CustomText(
                    text: appLocalizations.how_to_earn_points,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomBulletPoint(text: appLocalizations.donate_blood_points),
              CustomBulletPoint(
                  text: appLocalizations.emergency_response_points),
              CustomBulletPoint(text: appLocalizations.refer_to_friends_points),
              CustomBulletPoint(text: appLocalizations.complete_profile_points),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}