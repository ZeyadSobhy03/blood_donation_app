import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/choose_role/choose_role.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_pages.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requets/admin_request.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/dashboard.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/users.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/schedule_donation.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donor_main_layout.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/notifications.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/confirm_donation.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/help_and_support/screen/pdf_viewer_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/privacy_and_security/privacy_and_security.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/scan_qr.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/two_factor_authentication/screen/two_factor_authentication_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/request_screen.dart';
import 'package:flutter/material.dart';

import '../../../presentation/authentication/admin_authentication/admin_authentication.dart';
import '../../../presentation/authentication/donor_authentication/donor_forget_password.dart';
import '../../../presentation/authentication/donor_authentication/donor_login.dart';
import '../../../presentation/authentication/donor_authentication/donor_register.dart';
import '../../../presentation/authentication/hospital_authentication/hospital_authentication.dart';
import '../../../presentation/maps/maps.dart';
import '../../../presentation/role/admin/tabs/analytics/analytics.dart';
import '../../../presentation/role/admin/tabs/system_settings/system_setting.dart';
import '../../../presentation/role/donor/tabs/donation_history/donation_history.dart';
import '../../../presentation/role/donor/tabs/profile/help_and_support/screen/help_and_support_screen.dart';
import '../../../presentation/role/hospital/tabs/hospital_main_layout.dart';
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
  static const String mapScreen = '/mapScreen';
  static const String donationHistory = '/donationHistory';
  static const String privacyAndSecurity = '/privacyAndSecurity';
  static const String twoFactorAuthentication = '/twoFactorAuthentication';
  static const String confirmDonation= '/confirmDonation';

  static const String helpAndSupport = '/helpAndSupport';
  static const String pdfViewer = '/pdfViewer';
  static const String hospitalMainLayout = '/hospitalMainLayout';
  static const String scanQrCode = '/scanQrCode';
  static const String dashboard= '/dashboard';
  static const String users = '/users';
  static const String  adminRequest = '/adminRequest';
  static const String analytics= '/analytics';
  static const String systemSetting= '/systemSetting';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (context) => OnboardingPages());


      case systemSetting:
        return MaterialPageRoute(builder: (context) => const SystemSetting());

      case analytics:
        return MaterialPageRoute(builder: (context) => const Analytics());

      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());

      case users:
        return MaterialPageRoute(builder: (context) => const Users());


     case adminRequest:
        return MaterialPageRoute(builder: (context) => const AdminRequest());

      case scanQrCode:


        return MaterialPageRoute(builder: (context) => const ScanQr());

      case donationHistory:
        return MaterialPageRoute(builder: (context) => DonationHistory());

      case privacyAndSecurity:
        return MaterialPageRoute(builder: (context) => PrivacyAndSecurity());

      case helpAndSupport:
        return MaterialPageRoute(builder: (context) => HelpAndSupportScreen());

      case pdfViewer:
        return MaterialPageRoute(builder: (context) => PdfViewerScreen());

      case twoFactorAuthentication:
        return MaterialPageRoute(
          builder: (context) => TwoFactorAuthenticationScreen(),
        );

      case mapScreen:
        return MaterialPageRoute(
          builder: (context) => MapScreen(),
          settings: settings,
        );


      case chooseRole:
        return MaterialPageRoute(builder: (context) => ChooseRole());

      case hospitalMainLayout:
        return MaterialPageRoute(builder: (context) => HospitalMainLayout());

      case donorMainLayout:
        return MaterialPageRoute(builder: (context) => MainLayout());

      case notifications:
        return MaterialPageRoute(builder: (context) => Notifications());

      case scheduleDonation:
        return MaterialPageRoute(builder: (context) => ScheduleDonation());

      case donorLogin:
        return MaterialPageRoute(builder: (context) => DonorLogin());

      case confirmDonation:
        return MaterialPageRoute(builder: (context) => const ConfirmDonation());

      case donorRegister:
        return MaterialPageRoute(builder: (context) => DonorRegister());

      case donorForgetPassword:
        return MaterialPageRoute(builder: (context) => DonorForgetPassword());

      case hospitalAuth:
        return MaterialPageRoute(
          builder: (context) => HospitalAuthentication(),
        );

      case adminAuth:
        return MaterialPageRoute(builder: (context) => AdminAuthentication());

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
