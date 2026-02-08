import 'package:blood_donation_app/authentication/admin_authentication/admin_authentication.dart';
import 'package:blood_donation_app/authentication/donor_authentication/donor_forget_password.dart';
import 'package:blood_donation_app/authentication/donor_authentication/donor_login.dart';
import 'package:blood_donation_app/authentication/donor_authentication/donor_register.dart';
import 'package:blood_donation_app/authentication/hospital_authentication/hospital_authentication.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/choose_role/choose_role.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_pages.dart';
import 'package:flutter/material.dart';

class RouteManger {
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/chooseRole';
  static const String donorLogin = '/donorLogin';
  static const String donorRegister = '/donorRegister';
  static const String donorForgetPassword = '/donorForgetPassword';
  static const String hospitalAuth = '/hospitalAuthentication';
  static const String adminAuth = '/adminAuthentication';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => OnboardingPages());

      case chooseRole:
        return MaterialPageRoute(builder: (context) => ChooseRole());

      case donorLogin:
        return MaterialPageRoute(builder: (context) => DonorLogin());

      case donorRegister:
        return MaterialPageRoute(builder: (context) => DonorRegister());

      case donorForgetPassword:
        return MaterialPageRoute(builder: (context) => DonorForgetPassword());

      case hospitalAuth:
        return MaterialPageRoute(builder: (context) => HospitalAuthentication());

      case adminAuth:
        return MaterialPageRoute(builder: (context) => AdminAuthentication());

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
