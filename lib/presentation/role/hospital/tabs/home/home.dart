import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/active_requests_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/dashboard_stats_section.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/emergency_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/home_title.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/nearby_donor_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/recent_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTitle(hospitalName: 'Al-Azhar University Hospital'),
                SizedBox(height: 8.h),
                DashboardStatsSection(activeRequests: 5, responsesToday: 12),
                SizedBox(height: 16.h),
                EmergencyCard(),
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
                ActiveRequestsCard(),
                SizedBox(height: 16.h),
                NearbyDonorCard(),
                SizedBox(height: 16.h),
                RecentActivityCard()

              ],
            ),
          ),
        ),
      ),
    );
  }
}
