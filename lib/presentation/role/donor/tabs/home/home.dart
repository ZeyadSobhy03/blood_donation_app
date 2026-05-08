import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/chat_bot_dialog.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/recent_activity_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_custom_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/donation_status_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/home_title_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/urgent_requests_section.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/model/urgent_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/models/coordinates.dart';
import '../../../../../l10n/app_localizations.dart';
import 'model/recent_activity.dart';

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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
    super.initState();

    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<UrgentRequestModel> dummyUrgentRequests = [
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
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
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
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
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),

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
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
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
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
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
        // 30.36730355719704, 30.505864178391217
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
      UrgentRequestModel(
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
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
        locationHospital: Coordinates(
          latitude: 30.36730355719704,
          longitude: 30.505864178391217,
        ),
      ),
    ];
    final List<RecentActivityModel> dummyRecentActivity = [
      RecentActivityModel(
        points: '+200',
        title: 'Blood donated successfully',
        subTitle: 'City Hospital • 3 days ago',
        color: ColorManger.green,
      ),
      RecentActivityModel(
        points: '+100',
        title: 'Profile updated',
        subTitle: '2 days ago',
        color: ColorManger.skyBlue,
      ),
      RecentActivityModel(
        points: '+50',
        title: 'Completed survey',
        subTitle: '1 day ago',
        color: ColorManger.gold,
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
                  builder: (context) {
                    return ChatBotDialog();
                  },
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeTitleText(
                      title: appLocalizations.welcomeBack('ziyad'),
                      subTitle: appLocalizations.readyToSaveLives,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteManger.notifications);
                      },
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
                        backgroundColor: ColorManger.pureWhite,
                        textColor: ColorManger.slateGrey,
                        elevation: 6,
                      ),
                    ),
                    Expanded(
                      child: HomeCustomCard(
                        elevation: 6,
                        iconColor: ColorManger.gold,
                        text: appLocalizations.points,
                        icon: Icons.military_tech,
                        number: 2300,
                        backgroundColor: ColorManger.pureWhite,
                        textColor: ColorManger.slateGrey,
                      ),
                    ),

                    Expanded(
                      child: HomeCustomCard(
                        iconColor: ColorManger.skyBlue,
                        number: 36,
                        icon: Icons.trending_up,
                        text: appLocalizations.livesSaved,
                        backgroundColor: ColorManger.pureWhite,
                        textColor: ColorManger.slateGrey,
                        elevation: 6,
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
