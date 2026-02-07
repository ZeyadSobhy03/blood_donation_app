import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_custom_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/donation_status_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_title_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/urgent_requests_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/model/urgent_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations= AppLocalizations.of(context)!;
    final List<UrgentRequestModel> dummyUrgentRequests = [
      UrgentRequestModel(
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
      ),
      UrgentRequestModel(
        id: '2',
        title: 'Critical: A- needed',
        time: '25 min ago',
        isEmergency: false,
        bloodType: 'A-',
        unitsNeeded: 2,
        hospitalName: 'Central Medical Center',
        hospitalDistance: '4.8 km',
        location: '4.8 km away',
        patientType: 'ICU Patient',
        contactNumber: '+20 111 987 6543',
      ),
      UrgentRequestModel(
        id: '3',
        title: 'Emergency: B+ needed',
        time: '1 hour ago',
        isEmergency: true,
        bloodType: 'B+',
        unitsNeeded: 5,
        hospitalName: 'Al Salam Hospital',
        hospitalDistance: '6.1 km',
        location: '6.1 km away',
        patientType: 'Accident Case',
        contactNumber: '+20 122 555 7788',
      ),
      UrgentRequestModel(
        id: '3',
        title: 'Emergency: B+ needed',
        time: '1 hour ago',
        isEmergency: true,
        bloodType: 'B+',
        unitsNeeded: 5,
        hospitalName: 'Al Salam Hospital',
        hospitalDistance: '6.1 km',
        location: '6.1 km away',
        patientType: 'Accident Case',
        contactNumber: '+20 122 555 7788',
      ),
      UrgentRequestModel(
        id: '3',
        title: 'Emergency: B+ needed',
        time: '1 hour ago',
        isEmergency: true,
        bloodType: 'B+',
        unitsNeeded: 5,
        hospitalName: 'Al Salam Hospital',
        hospitalDistance: '6.1 km',
        location: '6.1 km away',
        patientType: 'Accident Case',
        contactNumber: '+20 122 555 7788',
      ),
      UrgentRequestModel(
        id: '3',
        title: 'Emergency: B+ needed',
        time: '1 hour ago',
        isEmergency: true,
        bloodType: 'B+',
        unitsNeeded: 5,
        hospitalName: 'Al Salam Hospital',
        hospitalDistance: '6.1 km',
        location: '6.1 km away',
        patientType: 'Accident Case',
        contactNumber: '+20 122 555 7788',
      ),
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeTitleText(
                      title: appLocalizations.welcomeBack('ziyad'),
                      subTitle: appLocalizations.readyToSaveLives,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: ColorManger.brightRed,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                DonationStatusCard(
                  donationStatus: appLocalizations.eligibleToDonate,
                  bloodType: 'O+',
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: HomeCustomCard(
                        number: 12,
                        icon: Icons.favorite_border_outlined,
                        text: appLocalizations.donations,
                        iconColor: ColorManger.brightRed,
                      ),
                    ),
                    Expanded(
                      child: HomeCustomCard(
                        iconColor: ColorManger.gold,
                        text: appLocalizations.points,
                        icon: Icons.military_tech,
                        number: 2300,
                      ),
                    ),

                    Expanded(
                      child: HomeCustomCard(
                        iconColor: ColorManger.skyBlue,
                        number: 36,
                        icon: Icons.trending_up,
                        text: appLocalizations.livesSaved,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                UrgentRequestsSection(requests: dummyUrgentRequests),
                SizedBox(height: 8.h),
                HomeNavigationButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteManger.scheduleDonation);
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
