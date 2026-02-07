import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/choose_role/choose_role.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_pages.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/schedule_donation.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/main_layout.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/notifications.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/request_screen.dart';
import 'package:flutter/material.dart';

class RouteManger {
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/chooseRole';
  static const String donorMainLayout = '/donorMainLayout';
  static const String requestScreen = '/requestScreen';
  static const String scheduleDonation = '/scheduleDonation';
  static const String notifications = '/notifications';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => OnboardingPages());

      case chooseRole:
        return MaterialPageRoute(builder: (context) => ChooseRole());

      case donorMainLayout:
        return MaterialPageRoute(builder: (context) => MainLayout());

      case notifications:
        return MaterialPageRoute(builder: (context) => Notifications());

      case scheduleDonation:
        return MaterialPageRoute(builder: (context) => ScheduleDonation());

      case requestScreen:
        return MaterialPageRoute(
          builder: (context) => RequestScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: CustomText(
                  text: 'page not found',
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontSize: FontSize.s24,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            );
          },
        );
    }
  }
}
