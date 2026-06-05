
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/chat_bot_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/activities/activities_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/donation_status_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/recent_activity_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/urgent_requests_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_custom_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_title_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/activities/activities_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donation_eligibility/donation_eligibility_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/requests/requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../view_model/donor_states/donor_states_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();

    Future.microtask(() {
      if (!mounted) return;
      context.read<ProfileCubit>().fetchProfile();
      context.read<DonorStatesCubit>().fetchDonorStates();
      context.read<DonationEligibilityCubit>().fetchDonationEligibility();
      _fetchRequestsWithLocation();
      context.read<ActivitiesCubit>().fetchActivities();
    });
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  void _fetchRequestsWithLocation() {
    if (!mounted) return;

    final mapState = context.read<MapCubit>().state;
    if (mapState is! MapLoaded) return;

    final profileState = context.read<ProfileCubit>().state;
    final bloodType = profileState is ProfileSuccessState
        ? profileState.profileModel.data?.bloodType ?? 'O+'
        : 'O+';

    context.read<RequestsCubit>().fetchRequests(
      latitude: mapState.latitude,
      longitude: mapState.longitude,
      bloodType: bloodType,
      radius: 500,
    );
  }

  void _onMapLoaded() {
    if (!mounted) return;
    final requestsState = context.read<RequestsCubit>().state;
    final shouldFetch =
        requestsState is RequestsInitialState ||
        requestsState is RequestsErrorState;
    if (shouldFetch) _fetchRequestsWithLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildActivitiesSkeletonLoader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 12.h),
          ...List.generate(
            3,
            (_) => Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      floatingActionButton: _FloatingChatButton(animation: _floatingAnimation),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileSection(),
                SizedBox(height: 12.h),
                _DonorStatsSection(),
                SizedBox(height: 16.h),
                _RequestsSection(
                  onMapLoaded: _onMapLoaded,
                  onRetry: _fetchRequestsWithLocation,
                ),
                SizedBox(height: 8.h),
                HomeNavigationButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    RouteManger.scheduleDonation,
                  ),
                ),
                SizedBox(height: 8.h),
                BlocBuilder<ActivitiesCubit, ActivitiesState>(
                  builder: (context, state) {
                    final isLoading = state is ActivitiesLoadingState;
                    final List<Activities> activities = state is ActivitiesSuccessState
                        ? state.activitiesModel.data?.activities ?? []
                        : [];

                    if (state is ActivitiesErrorState) {
                      return CustomErrorWidget(
                        message: localizeError(state.message, AppLocalizations.of(context)!),
                        onRetry: () =>
                            context.read<ActivitiesCubit>().fetchActivities(),
                      );
                    }

                    if (activities.isEmpty && !isLoading) {
                      return const SizedBox.shrink();
                    }

                    return Skeletonizer(
                      enabled: isLoading,
                      child: isLoading
                          ? _buildActivitiesSkeletonLoader()
                          : RecentActivitySection(activities: activities),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingChatButton extends StatelessWidget {
  const _FloatingChatButton({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (_) => const ChatBotDialog(userId: "123344"),
            ),
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
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileCubit, ProfileViewState>(
      builder: (context, state) {
        final isLoading = state is ProfileLoadingState;

        if (state is ProfileErrorState) {
          return CustomErrorWidget(
            message: localizeError(state.error, appLocalizations),
            onRetry: () => context.read<ProfileCubit>().fetchProfile(),
            onDismiss: () => context.read<ProfileCubit>().reset(),
          );
        }

        final profileData = state is ProfileSuccessState
            ? state.profileModel
            : null;
        final bloodType = profileData?.data?.bloodType ?? 'O+';

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: HomeTitleText(
                      title: appLocalizations.welcomeBack(
                        profileData?.data?.fullName ?? 'User',
                      ),
                      subTitle: appLocalizations.readyToSaveLives,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManger.notifications),
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
                bloodType: bloodType,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DonorStatsSection extends StatelessWidget {
  const _DonorStatsSection();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<DonorStatesCubit, DonorStatesViewState>(
      builder: (context, state) {
        final isLoading = state is DonorStatesLoadingState;
        final stats = state is DonorStatesSuccessState ? state : null;

        if (state is DonorStatesErrorState) {
          return CustomErrorWidget(
            message: localizeError(state.error, appLocalizations),
            onRetry: () => context.read<DonorStatesCubit>().fetchDonorStates(),
            onDismiss: () =>
                context.read<DonorStatesCubit>().retryFetchDonorStates(),
          );
        }

        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              Expanded(
                child: HomeCustomCard(
                  number: stats?.totalDonations ?? 0,
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
                  number: stats?.points ?? 0,
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
                  number: stats?.livesSaved ?? 0,
                  icon: Icons.trending_up,
                  text: appLocalizations.livesSaved,
                  iconColor: ColorManger.skyBlue,
                  backgroundColor: ColorManger.pureWhite,
                  textColor: ColorManger.slateGrey,
                  elevation: 6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RequestsSection extends StatelessWidget {
  const _RequestsSection({required this.onMapLoaded, required this.onRetry});

  final VoidCallback onMapLoaded;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return BlocListener<MapCubit, MapState>(
      listener: (context, mapState) {
        if (mapState is MapLoaded) onMapLoaded();
      },
      child: BlocBuilder<RequestsCubit, RequestsState>(
        builder: (context, state) {
          final isLoading = state is RequestsLoadingState;
          final List<Requests> requests=state is RequestsSuccessState ? state.requestsModel.data?.requests ?? [] : [];



          if (state is RequestsErrorState) {
            return CustomErrorWidget(message: localizeError(state.message, appLocalization), onRetry: onRetry);
          }

          if (requests.isEmpty && !isLoading) {
            return const SizedBox();
          }

          return Skeletonizer(
            enabled: isLoading,
            child: isLoading
                ? _buildSkeletonLoader()
                : UrgentRequestsSection(requests: requests),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 12.h),
          ...List.generate(
            2,
            (_) => Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
