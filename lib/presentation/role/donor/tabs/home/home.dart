import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/chat_bot_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/recent_activity_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_custom_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/donation_status_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_title_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/urgent_requests_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/model/urgent_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/models/coordinates.dart';
import '../../../../../l10n/app_localizations.dart';
import 'model/recent_activity.dart';
import 'presentation/view_model/donor_states_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

    // ✅ API CALLS ONCE ONLY
    Future.microtask(() {
      context.read<ProfileCubit>().fetchProfile();
      context.read<DonorStatesCubit>().fetchDonorStates();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<UrgentRequestModel> dummyUrgentRequests = [
      UrgentRequestModel(
        createdAt: DateTime.now(),
        id: '1',
        title: 'Emergency: O+ needed',
        time: '10 min ago',
        isEmergency: true,
        bloodType: 'O+',
        unitsNeeded: 3,
        hospitalName: 'City Hospital',
        hospitalDistance: '2.3 km',
        location: '2.3 km away',
        patientType: 'Emergency Surgery',
        contactNumber: '+20 100 123 4567',
        locationHospital: Coordinates(latitude: 30.36, longitude: 30.50),
      ),
    ];

    final List<RecentActivityModel> dummyRecentActivity = [
      RecentActivityModel(
        points: '+200',
        title: 'Blood donated successfully',
        subTitle: 'City Hospital • 3 days ago',
        color: ColorManger.green,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,

      floatingActionButton: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const ChatBotDialog(),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: ColorManger.brightRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.messenger_outline,
                  color: ColorManger.pureWhite,
                ),
              ),
            ),
          );
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---------------- PROFILE ----------------
                BlocBuilder<ProfileCubit, ProfileViewState>(
                  builder: (context, state) {
                    if (state is ProfileLoadingState) {
                      return const CustomLoadingWidget();
                    }

                    if (state is ProfileErrorState) {
                      return CustomErrorWidget(
                        message: state.error,
                        onRetry: () =>
                            context.read<ProfileCubit>().fetchProfile(),
                        onDismiss: () => context.read<ProfileCubit>().reset(),
                      );
                    }

                    if (state is ProfileSuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeTitleText(
                                title: appLocalizations.welcomeBack(
                                  state.profileModel.data?.fullName ?? '',
                                ),
                                subTitle: appLocalizations.readyToSaveLives,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteManger.notifications,
                                  );
                                },
                                icon: const Icon(
                                  Icons.notifications,
                                  color: ColorManger.brightRed,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          DonationStatusCard(
                            donationStatus: appLocalizations.eligibleToDonate,
                            bloodType:
                                state.profileModel.data?.bloodType ?? 'O+',
                          ),
                        ],
                      );
                    }

                    return const CustomLoadingWidget();
                  },
                ),

                SizedBox(height: 12.h),

                BlocBuilder<DonorStatesCubit, DonorStatesViewState>(
                  builder: (context, state) {
                    log(state.toString());

                    if (state is DonorStatesLoadingState) {
                      return Row(
                        children: List.generate(
                          3,
                          (_) => const Expanded(child: SizedBox()),
                        ),
                      );
                    }

                    if (state is DonorStatesSuccessState) {
                      return Row(
                        children: [
                          Expanded(
                            child: HomeCustomCard(
                              number: state.totalDonations,
                              icon: Icons.favorite_border_outlined,
                              text: appLocalizations.donations,
                              iconColor: ColorManger.brightRed,
                              backgroundColor: ColorManger.pureWhite,
                              textColor: ColorManger.slateGrey,
                              elevation: 6,
                            ),
                          ),
                          Expanded(
                            child: HomeCustomCard(
                              number: state.points,
                              icon: Icons.military_tech,
                              text: appLocalizations.points,
                              iconColor: ColorManger.gold,
                              backgroundColor: ColorManger.pureWhite,
                              textColor: ColorManger.slateGrey,
                              elevation: 6,
                            ),
                          ),
                          Expanded(
                            child: HomeCustomCard(
                              number: state.livesSaved,
                              icon: Icons.trending_up,
                              text: appLocalizations.livesSaved,
                              iconColor: ColorManger.skyBlue,
                              backgroundColor: ColorManger.pureWhite,
                              textColor: ColorManger.slateGrey,
                              elevation: 6,
                            ),
                          ),
                        ],
                      );
                    }

                    if (state is DonorStatesErrorState) {
                      return CustomErrorWidget(
                        message: state.error,
                        onRetry: () =>
                            context.read<DonorStatesCubit>().fetchDonorStates(),
                        onDismiss: () => context
                            .read<DonorStatesCubit>()
                            .retryFetchDonorStates(),
                      );
                    }

                    return const SizedBox();
                  },
                ),

                SizedBox(height: 16.h),

                UrgentRequestsSection(requests: dummyUrgentRequests),
                SizedBox(height: 8.h),
                HomeNavigationButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteManger.scheduleDonation);
                  },
                ),
                SizedBox(height: 8.h),
                RecentActivitySection(activities: dummyRecentActivity),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
