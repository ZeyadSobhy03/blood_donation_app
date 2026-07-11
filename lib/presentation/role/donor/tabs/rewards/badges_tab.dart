import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_badge_card.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_stat_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/error_localizer.dart';

class BadgesTab extends StatefulWidget {
  const BadgesTab({super.key});

  @override
  State<BadgesTab> createState() => _BadgesTabState();
}

class _BadgesTabState extends State<BadgesTab> {
  @override
  void initState() {
    super.initState();
    context.read<RewardsCubit>().fetchBadges();
  }

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

    return BlocBuilder<RewardsCubit, RewardsState>(
      builder: (context, state) {
        if (state is RewardsLoadingState) {
          return  CustomLoadingWidget(
            indicatorColor: ColorManger.brightRed,
          );
        }

        if (state is RewardsErrorState) {
          return CustomErrorWidget(message: localizeError(state.message, appLocalizations), onRetry: (){
              context.read<RewardsCubit>().fetchBadges();
          });
        }

        if (state is BadgesSuccessState) {
          final badgesData = state.badges.data;
          if (badgesData == null) {
            return  Center(
              child: CustomText(text: appLocalizations.no_badges_found),
            );
          }

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
                      value: badgesData.unlockedCount.toString(),
                      label: appLocalizations.badge_unlocked,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomStatCard(
                      icon: Icons.adjust,
                      value: badgesData.totalCount.toString(),
                      label: appLocalizations.total,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomStatCard(
                      icon: Icons.star_border,
                      value: "${badgesData.completionPercentage}%",
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
                children: badgesData.badges?.map((badge) {
                  final isUnlocked = badge.unlockStatus == "UNLOCKED";
                  final progressText = badge.progressCurrent != null && badge.progressTarget != null
                      ? "${badge.progressCurrent}/${badge.progressTarget}"
                      : "";

                  return CustomBadgeCard(
                    icon: _getBadgeIcon(badge.badgeIcon),
                    title: getBadgeName(badge.badgeName??'',appLocalizations),
                    subtitle: getBadgeDescription(badge.badgeName??'',appLocalizations),
                    isUnlocked: isUnlocked,
                    times: progressText,
                  );
                }).toList() ?? [],
              ),

              const SizedBox(height: 30),
            ],
          );
        }

        return  Center(
          child: CustomText(text: appLocalizations.no_badges_found),
        );
      },
    );
  }

  IconData _getBadgeIcon(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'heart':
        return Icons.favorite_border;
      case 'trophy':
        return Icons.emoji_events_outlined;
      case 'star':
        return Icons.star_border;
      case 'badge':
        return Icons.tag_faces_outlined;
      case 'crown':
        return Icons.bolt;
      case 'flash':
        return Icons.emergency_share;
      case 'shield':
        return Icons.security;
      default:
        return Icons.emoji_events;
    }
  }

  String getBadgeName(String tier,AppLocalizations appLocalizations){
    switch (tier.toLowerCase()) {
      case 'first timer':
        return appLocalizations.first_timer;
      case 'regular donor':
        return appLocalizations.regular_donor;
      case 'life saver':
        return appLocalizations.life_saver;
      case 'hero':
        return appLocalizations.hero;

      case 'legend':
        return appLocalizations.legend;
      case 'emergency responder':
        return appLocalizations.emergency_responder;
      case 'community helper':
        return appLocalizations.community_helper;
      default:
        return tier;
    }
}
String getBadgeDescription(String tier,AppLocalizations appLocalizations){
    switch (tier.toLowerCase()) {
      case 'first timer':
        return appLocalizations.completed_first_donation;
      case 'regular donor':
        return appLocalizations.donated_5_times;
      case 'life saver':
        return appLocalizations.donated_10_times;
      case 'hero':
        return appLocalizations.donated_20_times;

      case 'legend':
        return appLocalizations.donated_50_times;
      case 'emergency responder':
        return appLocalizations.responded_to_10_emergencies;
      case 'community helper':
        return appLocalizations.responded_to_25_emergencies;
      default:
        return '';
    }
}
}
