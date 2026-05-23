import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/badges_tab.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/user_points_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardsScreen extends StatefulWidget {
  static ValueNotifier<int> userPoints = ValueNotifier<int>(0);
  static ValueNotifier<int> pointsToNextTier = ValueNotifier<int>(0);
  static ValueNotifier<String> currentTier = ValueNotifier<String>('');
  static ValueNotifier<String> nextTier = ValueNotifier<String>('');

  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserPointsCubit>().fetchUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocListener<UserPointsCubit, UserPointsState>(
      listener: (context, state) {
        if (state is UserPointsSuccessState) {
          final data = state.pointsModel.data;
          RewardsScreen.userPoints.value       = data?.pointsBalance    ?? 0;
          RewardsScreen.pointsToNextTier.value = data?.pointsToNextTier ?? 0;
          RewardsScreen.currentTier.value      = data?.currentTier      ?? '';
          RewardsScreen.nextTier.value         = data?.nextTier         ?? '';
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: Column(
            children: [
              Container(
                color: const Color(0xFFFF0F22),
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appLocalizations.rewards_and_achievements,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF2C3D),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: appLocalizations.your_points,
                                    textStyle: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ValueListenableBuilder<int>(
                                    valueListenable: RewardsScreen.userPoints,
                                    builder: (context, currentPoints, _) {
                                      return CustomText(
                                        text: '$currentPoints',
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.workspace_premium,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: appLocalizations.next_reward,
                                textStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: RewardsScreen.pointsToNextTier,
                                builder: (context, remainingPoints, _) {
                                  return CustomText(
                                    text:
                                    '$remainingPoints ${appLocalizations.points_to_go}',
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          ValueListenableBuilder<int>(
                            valueListenable: RewardsScreen.userPoints,
                            builder: (context, currentPoints, _) {
                              final remaining =
                                  RewardsScreen.pointsToNextTier.value;
                              final total = currentPoints + remaining;
                              final progress =
                              total == 0 ? 0.0 : currentPoints / total;

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor: Colors.black26,
                                  valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder<String>(
                                valueListenable: RewardsScreen.currentTier,
                                builder: (context, currentTier, _) {
                                  return CustomText(
                                    text:
                                    '${appLocalizations.current}: ${_getTierLabel(currentTier, appLocalizations)}',
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              ValueListenableBuilder<String>(
                                valueListenable: RewardsScreen.nextTier,
                                builder: (context, nextTier, _) {
                                  return CustomText(
                                    text:
                                    '${appLocalizations.next}: ${_getTierLabel(nextTier, appLocalizations)}',
                                    textStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: const Color(0xFFFF0F22),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFFFF0F22),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.card_giftcard),
                      text: appLocalizations.rewards,
                    ),
                    Tab(
                      icon: const Icon(Icons.emoji_events_outlined),
                      text: appLocalizations.badges,
                    ),
                  ],
                ),
              ),

              const Expanded(
                child: TabBarView(
                  children: [
                    RewardsTab(),
                    BadgesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTierLabel(String tier, AppLocalizations l) {
    switch (tier.toUpperCase()) {
      case 'BRONZE':   return l.bronze;
      case 'SILVER':   return l.silver;
      case 'GOLD':     return l.gold;
      case 'PLATINUM': return l.platinum;
      default:         return tier;
    }
  }
}