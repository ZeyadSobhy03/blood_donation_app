import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/active_requests/active_requests_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/appointments/appointments_section.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/dashboard_stats_section.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/emergency_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/home_title.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/nearby_donor_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/recent_activity_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/scan_donor_qr_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/app_localizations.dart';
import 'appointments/presentation/view_model/appointments_view_model.dart';
import 'presentation/view_model/home_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHome();
    context.read<AppointmentsCubit>().loadAppointments();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context);
    if (loc != null) {
      context.read<HomeCubit>().setAppLoc(loc);
      context.read<AppointmentsCubit>().setAppLoc(loc);
    }
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().loadHome();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState || state is HomeInitialState) {
              return const Center(child: CircularProgressIndicator(
                color: ColorManger.royalBlue,
              ));
            }

            if (state is HomeErrorState) {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView(
                  children: [
                    SizedBox(height: 120.h),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomText(
                          text: state.message,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            color: ColorManger.brightRed,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final cubit = context.read<HomeCubit>();
            final dashboard = cubit.dashboard;
            final activity = cubit.activity;
            final requests = cubit.requests;
            final nearbyDonorGroups = cubit.nearbyDonorGroups;
            final hospitalName = cubit.hospitalName;

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: HomeTitle(hospitalName: hospitalName ?? ''),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              RouteManger.hospitalNotifications,
                            ),
                            icon: const Icon(
                              Icons.notifications,
                              color: ColorManger.royalBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      DashboardStatsSection(
                        activeRequests: dashboard?.activeRequests ?? 0,
                        responsesToday: dashboard?.responsesToday ?? 0,
                      ),
                      SizedBox(height: 16.h),
                      const ScanDonorQrCard(),
                      SizedBox(height: 16.h),
                      const EmergencyCard(),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: appLocalizations.active_requests,
                        textStyle: TextStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ActiveRequestsCard(requests: requests, maxVisible: 2),
                      SizedBox(height: 16.h),
                      const AppointmentsSection(),
                      SizedBox(height: 16.h),
                      NearbyDonorCard(groups: nearbyDonorGroups),
                      SizedBox(height: 16.h),
                      RecentActivityCard(activities: activity),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
