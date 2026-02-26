import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_stats_row.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/app_footer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/donation_history_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/log_out_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/personal_information_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/setting.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/thanks_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/widgets/user_profile_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/colors/color_manger.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManger.primaryRed,
                      ColorManger.primaryRedDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
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
              PersonalInformationCard(),
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
}
