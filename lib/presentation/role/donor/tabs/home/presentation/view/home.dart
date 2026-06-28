import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/chat_bot_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/activities/activities_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/donation_status_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/recent_activity_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/section/urgent_requests_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_title_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/activities/activities_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donation_eligibility/donation_eligibility_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/requests/requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/widgets/home_stats_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../data/model/donation_eligibility/donation_eligibility_model.dart';
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

    context.read<RequestsCubit>().fetchRequests(limit: 10, page: 1);
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
                _DonationEligibilitySection(),
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
                _ActivitiesSection(),
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
        log('ProfileViewState: $state');
        final isLoading = state is ProfileLoadingState;

        if (state is ProfileErrorState) {
          log('Profile error: ${state.error}');
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
              DonationStatusCard(bloodType: bloodType),
            ],
          ),
        );
      },
    );
  }
}

class _DonationEligibilitySection extends StatelessWidget {
  const _DonationEligibilitySection();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocConsumer<DonationEligibilityCubit, DonationEligibilityState>(
      listener: (context, state) {
        if (state is DonationEligibilityParticipationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: appLocalizations.participationAddedSuccessfully,
                textStyle: const TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: ColorManger.green,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is DonationEligibilityFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: localizeError(state.errorMessage, appLocalizations),
                textStyle: const TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        final isParticipationLoading =
        state is DonationEligibilityParticipationLoading;
        final isInitialLoading = state is DonationEligibilityLoading;
        final isLoading = isInitialLoading;

        final isSuccess =
            state is DonationEligibilitySuccess ||
                state is DonationEligibilityParticipationLoading;
        final isFailing =
            state is DonationEligibilityFailure &&
                state is! DonationEligibilityParticipationLoading;

        if (isFailing && !isSuccess) {
          return CustomErrorWidget(
            message: localizeError(state.errorMessage, appLocalizations),
            onRetry: () => context
                .read<DonationEligibilityCubit>()
                .fetchDonationEligibility(),
          );
        }
        DonationEligibilityModel? eligibilityData;

        if (state is DonationEligibilitySuccess) {
          eligibilityData = state.donationEligibilityModel;
        } else if (state is DonationEligibilityParticipationLoading) {
          eligibilityData = state.donationEligibilityModel;
        } else if (state is DonationEligibilityParticipationSuccess) {
          eligibilityData = state.donationEligibilityModel;
        }

        final isEligible = eligibilityData?.data?.isEligible ?? false;
        final isParticipating =
            eligibilityData?.data?.participationEnabled ?? false;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isEligible ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isEligible
                    ? Colors.green.shade300
                    : Colors.orange.shade300,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: appLocalizations.donationEligibility,
                            textStyle: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s14,
                              color: ColorManger.brightRed,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: isEligible
                                ? appLocalizations.youAreEligible
                                : appLocalizations.youAreNotEligible,
                            textStyle: TextStyle(
                              fontWeight: FontWeightManager.regular,
                              fontSize: FontSize.s12,
                              color: isEligible
                                  ? Colors.green.shade700
                                  : Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _ParticipationToggleButton(
                      isLoading: isParticipationLoading,
                      isEligible: isEligible,
                      isParticipating: isParticipating,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ParticipationToggleButton extends StatelessWidget {
  const _ParticipationToggleButton({
    required this.isLoading,
    required this.isEligible,
    required this.isParticipating,
  });

  final bool isLoading;
  final bool isEligible;
  final bool isParticipating;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationEligibilityCubit, DonationEligibilityState>(
      builder: (context, state) {
        final isButtonLoading =
        state is DonationEligibilityParticipationLoading;

        bool currentParticipation = isParticipating;
        if (state is DonationEligibilitySuccess) {
          currentParticipation =
              state.donationEligibilityModel.data?.participationEnabled ??
                  false;
        } else if (state is DonationEligibilityParticipationLoading) {
          currentParticipation =
              state.donationEligibilityModel?.data?.participationEnabled ??
                  isParticipating;
        } else if (state is DonationEligibilityParticipationSuccess) {
          currentParticipation =
              state.donationEligibilityModel?.data?.participationEnabled ??
                  isParticipating;
        }

        final bool disabled = isButtonLoading || isLoading;

        return GestureDetector(
          onTap: disabled
              ? null
              : () {
            context.read<DonationEligibilityCubit>().setParticipation(
              participation: !currentParticipation,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            width: 64,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: LinearGradient(
                colors: currentParticipation
                    ? [const Color(0xFF43A047), const Color(0xFF66BB6A)]
                    : [const Color(0xFFBDBDBD), const Color(0xFFE0E0E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: currentParticipation
                      ? const Color(0xFF43A047).withValues(alpha: 0.3)
                      : Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  alignment: currentParticipation
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: isButtonLoading
                            ? SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                              currentParticipation
                                  ? const Color(0xFF43A047)
                                  : Colors.grey.shade500,
                            ),
                          ),
                        )
                            : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            currentParticipation
                                ? Icons.check_rounded
                                : Icons.close_rounded,
                            key: ValueKey(currentParticipation),
                            size: 16,
                            color: currentParticipation
                                ? const Color(0xFF43A047)
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
          child: HomeStatsRow(
            donations: stats?.totalDonations ?? 0,
            points: stats?.points ?? 0,
            livesSaved: stats?.livesSaved ?? 0,
            textColor: ColorManger.slateGrey,
            backgroundColor: ColorManger.pureWhite,
            borderColor: Colors.transparent,
            elevation: 6,
          ),
        );
      },
    );
  }
}

class _ActivitiesSection extends StatelessWidget {
  const _ActivitiesSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        final isLoading = state is ActivitiesLoadingState;
        final List<Activities> activities = state is ActivitiesSuccessState
            ? state.activities
            : [];

        if (state is ActivitiesErrorState) {
          return CustomErrorWidget(
            message: localizeError(
              state.message,
              AppLocalizations.of(context)!,
            ),
            onRetry: () => context.read<ActivitiesCubit>().fetchActivities(),
          );
        }

        if (activities.isEmpty && !isLoading) {
          return const SizedBox.shrink();
        }

        return Skeletonizer(
          enabled: isLoading,
          child: isLoading
              ? const _ActivitiesSkeletonLoader()
              : RecentActivitySection(activities: activities),
        );
      },
    );
  }
}

class _ActivitiesSkeletonLoader extends StatelessWidget {
  const _ActivitiesSkeletonLoader();

  @override
  Widget build(BuildContext context) {
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
}

class _RequestsSection extends StatefulWidget {
  const _RequestsSection({required this.onMapLoaded, required this.onRetry});

  final VoidCallback onMapLoaded;
  final VoidCallback onRetry;

  @override
  State<_RequestsSection> createState() => _RequestsSectionState();
}

class _RequestsSectionState extends State<_RequestsSection> {
  int currentPage = 1;
  int pageSize = 10;
  bool hasNextPage = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (hasNextPage) {
        currentPage++;
        _fetchNextPage();
      }
    }
  }

  void _fetchNextPage() {
    context.read<RequestsCubit>().fetchRequests(
      limit: pageSize,
      page: currentPage,
    );
  }

  void _resetPagination() {
    setState(() {
      currentPage = 1;
      hasNextPage = false;
    });
    widget.onRetry();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<MapCubit, MapState>(
      listener: (context, mapState) {
        if (mapState is MapLoaded) widget.onMapLoaded();
      },
      child: BlocBuilder<RequestsCubit, RequestsState>(
        builder: (context, state) {
          final isLoading = state is RequestsLoadingState;

          List<Request> requests = [];
          int totalRequests = 0;

          if (state is RequestsSuccessState) {
            requests = state.requestsModel.data?.matches
                ?.map((match) => match.request)
                .whereType<Request>()
                .toList() ?? [];

            totalRequests = state.requestsModel.data?.pagination?.total ?? 0;
            hasNextPage = state.requestsModel.data?.pagination?.hasNextPage ?? false;
          }

          if (state is RequestsErrorState) {
            log('Requests error: ${state.message}');
            return CustomErrorWidget(
              message: localizeError(state.message, appLocalization),
              onRetry: _resetPagination,
            );
          }

          if (requests.isEmpty && !isLoading) {
            return CustomText(
              text: appLocalization.noRequestsFound,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
                color: ColorManger.slateGrey,
              ),
            );
          }

          return Skeletonizer(
            enabled: isLoading && currentPage == 1,
            child: isLoading && currentPage == 1
                ? _buildSkeletonLoader()
                : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  if (requests.isNotEmpty)
                    UrgentRequestsSection(requests: requests),
                  if (isLoading && currentPage > 1)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (requests.isNotEmpty && !hasNextPage && !isLoading)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomText(
                        text: appLocalization.noMoreRequests,
                        textStyle: TextStyle(
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s12,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
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