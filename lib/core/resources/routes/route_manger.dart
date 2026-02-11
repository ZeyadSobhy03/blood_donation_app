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

import '../../../presentation/authentication/admin_authentication/admin_authentication.dart';
import '../../../presentation/authentication/donor_authentication/donor_forget_password.dart';
import '../../../presentation/authentication/donor_authentication/donor_login.dart';
import '../../../presentation/authentication/donor_authentication/donor_register.dart';
import '../../../presentation/authentication/hospital_authentication/hospital_authentication.dart';
import '../../../presentation/splash_screen/splash_screen.dart';

class RouteManger {
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/chooseRole';
  static const String donorMainLayout = '/donorMainLayout';
  static const String requestScreen = '/requestScreen';
  static const String scheduleDonation = '/scheduleDonation';
  static const String notifications = '/notifications';
  static const String donorLogin = '/donorLogin';
  static const String donorRegister = '/donorRegister';
  static const String donorForgetPassword = '/donorForgetPassword';
  static const String hospitalAuth = '/hospitalAuthentication';
  static const String adminAuth = '/adminAuthentication';
  static const String splashScreen = '/splashScreen';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
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


      case donorLogin:
        return MaterialPageRoute(builder: (context) => DonorLogin());

      case donorRegister:
        return MaterialPageRoute(builder: (context) => DonorRegister());

      case donorForgetPassword:
        return MaterialPageRoute(builder: (context) => DonorForgetPassword());

      case hospitalAuth:
        return MaterialPageRoute(builder: (context) => HospitalAuthentication());

      case adminAuth:
        return MaterialPageRoute(builder: (context) => AdminAuthentication()) ;

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
