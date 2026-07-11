
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/earning_rules_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/history_cubit.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_bullet_point.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_confirmation_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_history_item.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/widgets/custom_redeem_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/error_localizer.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({super.key});

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  @override
  void initState() {
    super.initState();
    context.read<RewardsCubit>().fetchRewards();
    context.read<HistoryCubit>().fetchPointsHistory();
    context.read<EarningRulesCubit>().getEarningRules();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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

    return BlocConsumer<RewardsCubit, RewardsState>(

      listener: (context, state) {
        if (state is RedeemSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(text: AppLocalizations.of(context)!.reward_redeemed_successfully),
              backgroundColor: Colors.green,
            ),
          );
          context.read<RewardsCubit>().fetchRewards();
          context.read<HistoryCubit>().fetchPointsHistory();
        }
      },
      buildWhen: (previous, current) => current is! RedeemSuccessState,
      builder: (context, state) {
        if (state is RewardsLoadingState) {
          return const CustomLoadingWidget(
            indicatorColor: ColorManger.brightRed,
          );
        }

        if (state is RewardsErrorState) {
          return CustomErrorWidget(
            message: localizeError(state.message, appLocalizations),
            onRetry: () => context.read<RewardsCubit>().fetchRewards(),
          );
        }

        if (state is RewardsSuccessState) {
          final rewardsData = state.rewards.data;
          if (rewardsData == null ||
              rewardsData.rewards == null ||
              rewardsData.rewards!.isEmpty) {
            return Center(
              child: CustomText(text: appLocalizations.no_rewards_found),
            );
          }

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            children: [
              CustomText(
                text: appLocalizations.redeem_points,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: childAspectRatio,
                children: rewardsData.rewards!.map((reward) {
                  return CustomRedeemCard(
                    icon: _getRewardIcon(reward.iconType),
                    color: ColorManger.softRed,
                    iconColor: reward.colorCode != null
                        ? _hexToColor(reward.colorCode!)
                        : const Color(0xFFFF0F22),
                    title: tierLabel(reward.name ?? '', appLocalizations),
                    neededPoints: reward.pointsCost ?? 0,
                    onTap: () =>
                        _handleRedeem(
                          context,
                          appLocalizations,
                          reward.id ?? '',
                          reward.pointsCost ?? 0,
                          reward.name ?? '',
                          _getRewardIcon(reward.iconType),
                        ),
                    label: reward.status == 'ACTIVE'
                        ? appLocalizations.redeem
                        : appLocalizations.soon,
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              CustomText(
                text: appLocalizations.points_history,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, historyState) {
                  if (historyState is HistoryLoadingState) {
                    return const CustomLoadingWidget();
                  }
                  if (historyState is HistoryErrorState) {
                    return CustomErrorWidget(
                      message: historyState.message,
                      onRetry: () =>
                          context.read<HistoryCubit>().fetchPointsHistory(),
                    );
                  }
                  if (historyState is HistorySuccessState) {
                    final history =
                        historyState.pointsHistory.data?.transactions ?? [];
                    if (history.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: appLocalizations.no_points_history,
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: history.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = history[index];
                        return CustomHistoryItem(
                          title: getHistoryLabel(
                              item.transactionType ?? '', appLocalizations),
                          points: item.pointsAmount ?? 0,
                          date: item.createdAt != null
                              ? DateTime.parse(item.createdAt!)
                              : null,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 30),

              BlocBuilder<EarningRulesCubit, EarningRulesState>(
                builder: (context, rulesState) {
                  return Container(
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
                            const Icon(Icons.trending_up,
                                color: Color(0xFF1976D2)),
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

                        if (rulesState is EarningRulesSuccessState &&
                            rulesState.earningRulesModels.data != null &&
                            rulesState.earningRulesModels.data!.isNotEmpty)
                          ...rulesState.earningRulesModels.data!.map(
                                (rule) =>
                                CustomBulletPoint(
                                  text:
                                  earningRuleLabel(
                                      rule.title ?? '', appLocalizations)
                                  ,
                                ),
                          )
                        else
                          if (rulesState is EarningRulesLoadingState)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: CustomLoadingWidget(),
                            )
                          else
                            ...[
                              CustomBulletPoint(
                                  text: appLocalizations.donate_blood_points),
                              CustomBulletPoint(
                                  text:
                                  appLocalizations.emergency_response_points),
                              CustomBulletPoint(
                                  text: appLocalizations
                                      .refer_to_friends_points),
                              CustomBulletPoint(
                                  text: appLocalizations
                                      .complete_profile_points),
                            ],
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          );
        }

        return Center(
          child: CustomText(text: appLocalizations.no_rewards_found),
        );
      },
    );
  }

  void _handleRedeem(BuildContext context,
      AppLocalizations appLocalizations,
      String rewardId,
      int cost,
      String title,
      IconData icon,) {
    if (RewardsScreen.userPoints.value >= cost) {
      showDialog(
        context: context,
        builder: (_) =>
            CustomConfirmationDialog(
              cost: cost,
              title: title,
              icon: icon,
              rewardId: rewardId,
            ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(text: appLocalizations.not_enough_points),
        ),
      );
    }
  }

  IconData _getRewardIcon(String? iconType) {
    switch (iconType?.toLowerCase()) {
      case 'coffee':
        return Icons.coffee;
      case 'movie':
        return Icons.movie_creation_outlined;
      case 'restaurant':
        return Icons.restaurant;
      case 'medical':
        return Icons.favorite_border;
      case 'premium':
        return Icons.workspace_premium;
      case 'gym':
        return Icons.electric_bolt_outlined;
      default:
        return Icons.card_giftcard;
    }
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String tierLabel(String tier, AppLocalizations l) {
    switch (tier.toLowerCase()) {
      case 'coffee voucher':
        return l.coffeeVoucher;
      case 'movie tickets':
        return l.movieTickets;
      case 'restaurant gift card':
        return l.restaurantGiftCard;
      case 'health check-up':
        return l.healthCheckUp;
      case 'premium badge':
        return l.premiumBadge;
      case 'gym membership':
        return l.gymMembership;
      default:
        return tier;
    }
  }

   String earningRuleLabel(String title, AppLocalizations l) {
     switch (title.toLowerCase()) {
       case 'blood donation':
         return l.donate_blood_points;
       case 'plasma donation':
         return l.plasma_donation_points;
       case 'platelet donation':
         return l.platelets_donation_points;
       case 'organ donation':
         return l.organ_donation_points;
       case 'first donation bonus':
         return l.first_donation_bonus_points;
       case 'emergency response':
         return l.emergency_response_points;
       case 'referral':
         return l.refer_to_friends_points;
       case 'profile completion':
         return l.complete_profile_points;

       default:
         return title;
     }
   }


  String getHistoryLabel(String type, AppLocalizations l) {
    switch (type.toLowerCase()) {
      case 'blood_donation':
        return l.first_donation;

      case 'tier_bonus':
        return l.tier_bonus;

      case 'emergency_response':
        return l.emergency_response;

      case 'profile_completion':
        return l.profile_completion;

      case 'badge_unlock':
        return l.badge_unlock;

      case 'reward_redeemed':
        return l.reward_redeemed;

      case 'plasma_donation':
        return l.plasma_donation;

      case 'platelets_donation':
        return l.platelets_donation;


      case 'first_donation':
        return l.first_donation_bonus;

      case 'organ_donation':
        return l.organ_donation;

      case 'admin_adjustment':
        return l.admin_adjustment;

      case 'referral':
        return l.referral;

      default:
        return type;
    }
  }
}

