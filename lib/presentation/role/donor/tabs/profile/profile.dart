import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_stats_row.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/achievement_badges_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/app_footer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/confirm_donation_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/donation_history_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/log_out_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/personal_information_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/points_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/setting.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/thanks_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/widgets/user_profile_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/colors/color_manger.dart';
import '../../../../../core/resources/models/badge_data.dart';
import '../../../../../l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: ColorManger.bloodRed,

                child: Column(
                  children: [
                    UserProfileTile(
                      name: 'Ziyad sobhy',
                      email: 'ziyad@gmail.com',
                      bloodType: 'A+',
                    ),
                    HomeStatsRow(
                      donations: 5,
                      points: 12,
                      livesSaved: 36,
                      textColor: ColorManger.pureWhite,
                      backgroundColor: ColorManger.pureWhite.withAlpha(0x33),
                      borderColor: ColorManger.pureWhite.withAlpha(0x33),
                      elevation: 0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              PointsCard(
                totalPoints: 2300,
                milestonePoints: 3000,
                milestoneName: getBadgeName(2300, context),
              ),
              SizedBox(height: 16),
              AchievementBadgesCard(
                badges: [
                  BadgeData(
                    label: getBadgeName(1200, context),
                    points: 1200,
                    status: BadgeStatus.earned,
                    backgroundColor: ColorManger.lightBronze,
                    borderColor: ColorManger.bronze,
                    iconColor: ColorManger.bronzeDark,
                  ),

                  BadgeData(
                    label: getBadgeName(2300, context),
                    points: 3000,
                    status: BadgeStatus.earned,
                    backgroundColor: ColorManger.lightSilver,
                    borderColor: ColorManger.silverDark,
                    iconColor: ColorManger.silverDark,
                  ),

                  BadgeData(
                    label: getBadgeName(3000, context),
                    points: 3000,
                    status: BadgeStatus.earned,
                    backgroundColor: ColorManger.lightGold,
                    borderColor: ColorManger.goldDark,
                    iconColor: ColorManger.goldDark,
                  ),

                  BadgeData(
                    label: getBadgeName(5000, context),
                    points: 5000,
                    status: BadgeStatus.earned,
                    backgroundColor: ColorManger.lightDiamond,
                    borderColor: ColorManger.diamond,
                    iconColor: ColorManger.diamondDark,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ConfirmDonationCard(),
              SizedBox(height: 16),
              PersonalInformationCard(
                donor: DonorModel(
                  donorRank: 1,
                  id: '1',
                  name: 'Ziyad Sonhy',
                  email: 'ziad60189@gmail.com',
                  phoneNumber: '01141935341',
                  bloodType: 'A+',
                  totalDonations: 100,
                  points: 3000,
                  isEligibleToDonate: true,
                  location: 'Egypt',
                  isActive: true,
                  isVerified: true,
                  gender: 'male',
                  age: 20,
                  weight: 65,
                  healthStatus: 'ok',
                  isBanned: false,
                  isOnline: true,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              ),
              SizedBox(height: 16),
              DonationHistoryCard(),
              SizedBox(height: 16),
              Setting(),
              SizedBox(height: 16),
              ThanksCard(donationsCount: 5, livesSaved: 36),
              SizedBox(height: 16),
              LogOutButton(),
              SizedBox(height: 16),
              AppFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String getBadgeName(int points, BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (points >= 5000) {
      return loc.diamond_donor;
    } else if (points >= 3000) {
      return loc.gold_donor;
    } else if (points >= 1200) {
      return loc.silver_donor;
    } else {
      return loc.bronze_donor;
    }
  }
}
