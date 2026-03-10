import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/badges_tab.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_tab.dart';
import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  static ValueNotifier<int> userPoints = ValueNotifier<int>(2340);
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DefaultTabController(
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
                    textStyle: TextStyle(
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
                                  textStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                ValueListenableBuilder(
                                  valueListenable: userPoints,
                                  builder: (context, currentPoints, child) {
                                    return CustomText(
                                      text: "$currentPoints",
                                      textStyle: TextStyle(
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
                              textStyle: TextStyle(color: Colors.white70),
                            ),
                            CustomText(
                              text:
                                  "${500 - (userPoints.value % 500)} ${appLocalizations.points_to_go}",
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder(
                          valueListenable: userPoints,
                          builder: (context, currentPoints, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.5,
                                minHeight: 8,
                                backgroundColor: Colors.black26,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            );
                          },
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
                labelColor: Color(0xFFFF0F22),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFFFF0F22),
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(icon: Icon(Icons.card_giftcard), text: appLocalizations.rewards),
                  Tab(icon: Icon(Icons.emoji_events_outlined), text: appLocalizations.badges),
                ],
              ),
            ),

            const Expanded(
              child: TabBarView(children: [RewardsTab(), BadgesTab()]),
            ),
          ],
        ),
      ),
    );
  }
}
