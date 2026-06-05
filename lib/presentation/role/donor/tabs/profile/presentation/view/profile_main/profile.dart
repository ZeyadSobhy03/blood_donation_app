
import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/utils/tier_utils.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/models/badge_data.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../home/presentation/view/widgets/home_stats_row.dart';
import '../../view_model/profile/profile_view_model.dart';
import '../sections/achievement_badges_card.dart';
import '../sections/app_footer.dart';
import '../sections/donation_history_card.dart';
import '../sections/log_out_button.dart';
import '../sections/personal_information_card.dart';
import '../sections/points_card.dart';
import '../sections/setting.dart';
import '../sections/thanks_card.dart';
import '../widgets/user_profile_tile.dart';
import '../../../../donation_history/presentation/view_model/donation_history_view_model.dart';

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
      context.read<DonationHistoryCubit>().getDonationHistory();
      context.read<RewardsCubit>().fetchUserPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

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
                message: localizeError(state.error, appLocalization),
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
              final createdAt = DateTime.tryParse(data?.createdAt ?? '');
              final updatedAt = DateTime.tryParse(data?.updatedAt ?? '');

               final phone = data?.phoneNumber ?? '-';
               final weight = data?.weight != null
                   ? (data!.weight is num ? data.weight.toString() : data.weight.toString())
                   : '0';
               final age = data?.age != null ? data!.age.toString() : '0';
               final genderValue = data?.gender ?? 'Male';
               final gender = genderValue.toString().toLowerCase() == 'male' ? 'Male' : 'Female';
               final city = data?.location?.city ?? '-';
               final governorate = data?.location?.governorate ?? '-';
               final location = '$city, $governorate';

               DateTime? birthDate;
               if (data?.dateOfBirth != null && data!.dateOfBirth != null && data.dateOfBirth!.isNotEmpty) {
                 birthDate = DateTime.tryParse(data.dateOfBirth!);
               }

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
                            phone: phone,
                            location: location.isEmpty ? '-' : location,
                            weight: weight,
                            age: age,
                            gender: gender,
                            birthDate: birthDate,
                          ),
                          HomeStatsRow(
                            donations: totalDonations,
                            points: points,
                            livesSaved: livesSaved,
                            textColor: ColorManger.pureWhite,
                            backgroundColor:
                            ColorManger.pureWhite.withAlpha(0x33),
                            borderColor:
                            ColorManger.pureWhite.withAlpha(0x33),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<RewardsCubit, RewardsState>(
                      builder: (context, rewardsState) {
                        int milestonePoints = 1200;
                        String milestoneName = appLocalization.bronze_donor;

                        if (rewardsState is UserPointsUpdatedState) {
                          final pointsData = rewardsState.points.data;
                          milestonePoints =
                              pointsData?.pointsToNextTier ?? 1200;
                          milestoneName = localizeTier(
                            pointsData?.nextTier,
                            appLocalization,
                          );
                        }

                        return PointsCard(
                          totalPoints: points,
                          milestonePoints: milestonePoints,
                          milestoneName: milestoneName,
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<RewardsCubit, RewardsState>(
                      builder: (context, rewardsState) {
                        int pointsBalance = 0;

                        if (rewardsState is UserPointsUpdatedState) {
                          pointsBalance =
                              rewardsState.points.data?.pointsBalance ?? 0;
                        }

                        final tiers = ['bronze', 'silver', 'gold', 'platinum'];

                        final tierColors = {
                          'bronze': (
                          bg: ColorManger.lightBronze,
                          border: ColorManger.bronze,
                          icon: ColorManger.bronzeDark,
                          ),
                          'silver': (
                          bg: ColorManger.lightSilver,
                          border: ColorManger.silverDark,
                          icon: ColorManger.silverDark,
                          ),
                          'gold': (
                          bg: ColorManger.lightGold,
                          border: ColorManger.goldDark,
                          icon: ColorManger.goldDark,
                          ),
                          'platinum': (
                          bg: ColorManger.lightDiamond,
                          border: ColorManger.diamond,
                          icon: ColorManger.diamondDark,
                          ),
                        };

                        final tierPoints = {
                          'bronze': 0,
                          'silver': 1000,
                          'gold': 2500,
                          'platinum': 5000,
                        };

                        return AchievementBadgesCard(
                          badges: tiers.map((tier) {
                            final colors = tierColors[tier]!;
                            return BadgeData(
                              label: localizeTier(tier, appLocalization),
                              points: tierPoints[tier]!,
                              status: pointsBalance >= tierPoints[tier]!
                                  ? BadgeStatus.earned
                                  : BadgeStatus.locked,
                              backgroundColor: colors.bg,
                              borderColor: colors.border,
                              iconColor: colors.icon,
                            );
                          }).toList(),
                        );
                      },
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
                        healthStatus:
                        data?.healthHistory?.recentIllness?.isNotEmpty ==
                            true
                            ? data!.healthHistory!.recentIllness!
                            : '-',
                        isBanned: data?.isBanned ?? false,
                        isOnline: false,
                        createdAt: createdAt ?? DateTime.now(),
                        updatedAt: updatedAt,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const DonationHistoryCard(),
                    const SizedBox(height: 16),
                    const Setting(),
                    const SizedBox(height: 16),
                    ThanksCard(
                      donationsCount: totalDonations,
                      livesSaved: livesSaved,
                    ),
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
}