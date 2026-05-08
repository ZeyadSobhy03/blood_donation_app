import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_stats_row.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/achievement_badges_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/app_footer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/donation_history_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/log_out_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/personal_information_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/points_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/setting.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/sections/thanks_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/widgets/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/colors/color_manger.dart';
import '../../../../../core/resources/models/badge_data.dart';
import '../../../../../l10n/app_localizations.dart';
import 'presentation/view_model/profile_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileViewState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const CustomLoadingWidget();
            }

            if (state is ProfileErrorState) {
              return CustomErrorWidget(
                message: state.error,
                onRetry: () => context.read<ProfileCubit>().fetchProfile(),
                onDismiss: () => context.read<ProfileCubit>().reset(),
              );
            }

            if (state is ProfileSuccessState) {
              final data = state.profileModel.data;
              final stats = data?.stats;
              final points = stats?.points ?? 0;
              final totalDonations = stats?.totalDonations ?? 0;
              final livesSaved = stats?.livesSaved ?? 0;
              final nextBadge = data?.nextBadge ?? getBadgeName(points, context);
              final location = [
                data?.location?.city,
                data?.location?.governorate,
              ].whereType<String>().where((value) => value.isNotEmpty).join(', ');

              final createdAt = DateTime.tryParse(data?.createdAt ?? '');
              final updatedAt = DateTime.tryParse(data?.updatedAt ?? '');

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: ColorManger.bloodRed,
                      child: Column(
                        children: [
                          UserProfileTile(
                            name: data?.fullName ?? '-',
                            email: data?.email ?? '-',
                            bloodType: data?.bloodType ?? '-',
                          ),
                          HomeStatsRow(
                            donations: totalDonations,
                            points: points,
                            livesSaved: livesSaved,
                            textColor: ColorManger.pureWhite,
                            backgroundColor: ColorManger.pureWhite.withAlpha(0x33),
                            borderColor: ColorManger.pureWhite.withAlpha(0x33),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    PointsCard(
                      totalPoints: points,
                      milestonePoints: 3000,
                      milestoneName: nextBadge,
                    ),
                    const SizedBox(height: 16),
                    AchievementBadgesCard(
                      badges: [
                        BadgeData(
                          label: getBadgeName(1200, context),
                          points: 1200,
                          status: points >= 1200
                              ? BadgeStatus.earned
                              : BadgeStatus.locked,
                          backgroundColor: ColorManger.lightBronze,
                          borderColor: ColorManger.bronze,
                          iconColor: ColorManger.bronzeDark,
                        ),
                        BadgeData(
                          label: getBadgeName(2300, context),
                          points: 3000,
                          status: points >= 2300
                              ? BadgeStatus.earned
                              : BadgeStatus.locked,
                          backgroundColor: ColorManger.lightSilver,
                          borderColor: ColorManger.silverDark,
                          iconColor: ColorManger.silverDark,
                        ),
                        BadgeData(
                          label: getBadgeName(3000, context),
                          points: 3000,
                          status: points >= 3000
                              ? BadgeStatus.earned
                              : BadgeStatus.locked,
                          backgroundColor: ColorManger.lightGold,
                          borderColor: ColorManger.goldDark,
                          iconColor: ColorManger.goldDark,
                        ),
                        BadgeData(
                          label: getBadgeName(5000, context),
                          points: 5000,
                          status: points >= 5000
                              ? BadgeStatus.earned
                              : BadgeStatus.locked,
                          backgroundColor: ColorManger.lightDiamond,
                          borderColor: ColorManger.diamond,
                          iconColor: ColorManger.diamondDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PersonalInformationCard(
                      donor: DonorModel(
                        donorRank: 1,
                        id: data?.id ?? '-',
                        name: data?.fullName ?? '-',
                        email: data?.email ?? '-',
                        phoneNumber: data?.phoneNumber ?? '-',
                        bloodType: data?.bloodType ?? '-',
                        totalDonations: totalDonations,
                        points: points,
                        isEligibleToDonate: data?.availableToDonate ?? false,
                        location: location.isEmpty ? '-' : location,
                        isActive: data?.isAvailable ?? false,
                        isVerified: data?.isVerified ?? false,
                        gender: data?.gender ?? '-',
                        age: data?.age ?? 0,
                        weight: (data?.weight as num?)?.toDouble() ?? 0,
                        healthStatus: data?.healthHistory?.recentIllness?.isNotEmpty == true
                            ? data!.healthHistory!.recentIllness!
                            : '-',
                        isBanned: data?.isBanned ?? false,
                        isOnline: false,
                        createdAt: createdAt ?? DateTime.now(),
                        updatedAt: updatedAt,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DonationHistoryCard(),
                    const SizedBox(height: 16),
                    const Setting(),
                    const SizedBox(height: 16),
                    ThanksCard(donationsCount: totalDonations, livesSaved: livesSaved),
                    const SizedBox(height: 16),
                    const LogOutButton(),
                    const SizedBox(height: 16),
                    const AppFooter(),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }

            return const CustomLoadingWidget();
          },
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
