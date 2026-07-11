import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/pin_verification_args.dart';
import 'package:blood_donation_app/core/resources/models/reset_password_args.dart';
import 'package:blood_donation_app/core/widgets/custom_ban_screen.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/remote_data_source/hospital_api_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/repositories/hospital_repositories_impl.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/domain/use_case/hospital_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/hospital_forget_password.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/presentation/view_model/hospital_view_model.dart';
import 'package:blood_donation_app/presentation/choose_role/choose_role.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_pages.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view/section/audit_logs_screen.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donor_main_layout.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view/notifications.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/request_screen.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/notifications/presentation/view/notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/authentication/admin_authentication/presentation/view/admin_authentication.dart';
import '../../../presentation/authentication/admin_authentication/presentation/view/admin_forget_password.dart';
import '../../../presentation/authentication/donor_authentication/donor_forget_password.dart';
import '../../../presentation/authentication/donor_authentication/donor_login.dart';
import '../../../presentation/authentication/donor_authentication/donor_register.dart';
import '../../../presentation/authentication/hospital_authentication/hospital_authentication.dart';
import '../../../presentation/maps/maps.dart';
import '../../../presentation/role/admin/tabs/admin_main_layout.dart';
import '../../../presentation/role/admin/tabs/admin_requests/presentation/view/admin_request.dart';
import '../../../presentation/role/admin/tabs/admin_rewards/presentation/view/admin_rewards.dart';
import '../../../presentation/role/admin/tabs/analytics/presentation/view/analytics.dart';
import '../../../presentation/role/admin/tabs/dashboard/presentation/view/dashboard.dart';
import '../../../presentation/role/admin/tabs/system_settings/presentation/view/system_settings.dart';
import '../../../presentation/role/admin/tabs/system_settings/presentation/view/widgets/inbound_emails_screen.dart';
import '../../../presentation/role/admin/tabs/users/presentation/view/users.dart';
import '../../cubits/donation_schedule.dart';
import '../../../presentation/role/donor/tabs/donate/presentation/view/schedule_donation/presentation/view/schedule_donation.dart';
import '../../../presentation/role/donor/tabs/donate/presentation/view/section/accepted_request_details.dart';
import '../../../presentation/role/donor/tabs/donate/presentation/view/section/appointment_details.dart';
import '../../../presentation/role/donor/tabs/donation_history/presentation/view/donation_history.dart';
import '../../../presentation/role/donor/tabs/profile/presentation/view/help_and_support/screen/help_and_support_screen.dart';
import '../../../presentation/role/donor/tabs/profile/presentation/view/help_and_support/screen/pdf_viewer_screen.dart';
import '../../../presentation/role/donor/tabs/profile/presentation/view/privacy_and_security/privacy_and_security.dart';
import '../../../presentation/role/donor/tabs/profile/presentation/view/two_factor_authentication/screen/two_factor_authentication_screen.dart';
import '../../../presentation/role/hospital/tabs/hospital_main_layout.dart';
import '../../../presentation/role/hospital/tabs/profile/help&support/help_support_hospital.dart';
import '../../../presentation/role/hospital/tabs/scan_qr/scan_qr.dart';
import '../../../presentation/splash_screen/splash_screen.dart';
import '../../widgets/custom_pin_verification_screen.dart';

import '../../../presentation/authentication/donor_authentication/presentation/view/widgets/donor_reset_password.dart';
import '../../widgets/custom_reset_password.dart';

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
  static const String donorResetPassword = '/donorResetPassword';
  static const String hospitalAuth = '/hospitalAuthentication';
  static const String adminAuth = '/adminAuthentication';
  static const String splashScreen = '/splashScreen';
  static const String mapScreen = '/mapScreen';
  static const String donationHistory = '/donationHistory';
  static const String privacyAndSecurity = '/privacyAndSecurity';
  static const String twoFactorAuthentication = '/twoFactorAuthentication';

  static const String helpAndSupport = '/helpAndSupport';
  static const String pdfViewer = '/pdfViewer';
  static const String hospitalMainLayout = '/hospitalMainLayout';
  static const String scanQrCode = '/scanQrCode';
  static const String adminMainLayout = '/adminMainLayout';
  static const String dashboard = '/dashboard';
  static const String users = '/users';
  static const String adminRequest = '/adminRequest';
  static const String analytics = '/analytics';
  static const String systemSetting = '/systemSetting';
  static const String confirmDonation = '/confirmDonation';
  static const String helpAndSupportHospital = '/helpAndSupportHospital';
  static const String customPinVerificationScreen =
      "/customPinVerificationScreen";

  static const String hospitalForgetPassword = '/hospitalForgetPassword';
  static const String hospitalNotifications = '/hospitalNotifications';

  static const String adminForgetPassword = '/adminForgetPassword';
  static const String appointmentDetails = '/appointmentDetails';
  static const String banScreen = '/banScreen';
  static const String adminRewards='/adminRewards';
  static const String inboundEmailsScreen='/inboundEmailsScreen';
  static const String customResetPassword = '/customResetPassword';
  static const String acceptedRequestDetails='/acceptedRequestDetails';
  static const String auditLogsScreen = '/auditLogsScreen';
  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (context) => OnboardingPages());

      case RouteManger.auditLogsScreen:
        return MaterialPageRoute(
    builder: (context) => AuditLogsScreen(),

        );

      case banScreen:
        return MaterialPageRoute(
          builder: (context) {
            final role = settings.arguments as BanRole;
            return CustomBanScreen(role: role);
          },
          settings: settings,
        );
      case appointmentDetails:
        return MaterialPageRoute(
          builder: (context) => const AppointmentDetails(),
          settings: settings,
        );

      case acceptedRequestDetails:
        return MaterialPageRoute(
          builder: (context) => const AcceptedRequestDetails(),
          settings: settings,
        );

       case customResetPassword:
        final args = settings.arguments as ResetPasswordArgs ;
        return MaterialPageRoute(
          builder: (context) => CustomResetPassword(
            args: args,
          ),
          settings: settings,
        );

      case inboundEmailsScreen:
        return MaterialPageRoute(
          builder: (context) => const InboundEmailsScreen(),
          settings: settings,
        );

      case donationHistory:
        return MaterialPageRoute(builder: (context) => DonationHistory());
      case systemSetting:
        return MaterialPageRoute(builder: (context) => const SystemSettings());

      case helpAndSupportHospital:
        return MaterialPageRoute(
          builder: (context) => const HelpAndSupportHospital(),
        );


      case analytics:
        return MaterialPageRoute(builder: (context) => const Analytics());

      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());

      case users:
        return MaterialPageRoute(builder: (context) => const Users());

      case adminRewards:
        return MaterialPageRoute(builder: (context) => const AdminRewards());


      case adminMainLayout:
        return MaterialPageRoute(builder: (context) => const AdminMainLayout());

      case adminRequest:
        return MaterialPageRoute(builder: (context) => const AdminRequest());

      case scanQrCode:
        return MaterialPageRoute(builder: (context) => const ScanQr());

      case privacyAndSecurity:
        return MaterialPageRoute(builder: (context) => PrivacyAndSecurity());

      case helpAndSupport:
        return MaterialPageRoute(builder: (context) => HelpAndSupportScreen());

      case pdfViewer:
        return MaterialPageRoute(
          settings: settings,

          builder: (context) => PdfViewerScreen(),
        );

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
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DonationScheduleCubit(),
            child: const ScheduleDonation(),
          ),
        );
      case donorLogin:
        return MaterialPageRoute(builder: (context) => DonorLogin());

      case donorRegister:
        return MaterialPageRoute(builder: (context) => DonorRegister());

      case donorForgetPassword:
        return MaterialPageRoute(builder: (context) => DonorForgetPassword());

      case donorResetPassword:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) =>
              DonorResetPassword(email: args['email'], otp: args['otp']),
        );

      case hospitalAuth:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HospitalCubit(
              hospitalUseCase: HospitalUseCase(
                hospitalRepositories: HospitalRepositoriesImp(
                  hospitalRemoteDataSource: HospitalApiDataSource(Dio()),
                ),
              ),
              hospitalHiveDataSource: HospitalHiveDataSource()..init(),
            ),
            child: const HospitalAuthentication(),
          ),
        );

      case adminAuth:
        return MaterialPageRoute(builder: (context) => AdminAuthentication());

      case customPinVerificationScreen:
        final args = settings.arguments as PinVerificationArgs;
        return MaterialPageRoute<String>(
          builder: (context) => CustomPinVerificationScreen(args: args),
        );

      case requestScreen:
        return MaterialPageRoute(
          builder: (context) => RequestScreen(),
          settings: settings,
        );

      case hospitalNotifications:
        return MaterialPageRoute(
          builder: (context) => const HospitalNotifications(),
        );

      case hospitalForgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HospitalCubit(
              hospitalUseCase: HospitalUseCase(
                hospitalRepositories: HospitalRepositoriesImp(
                  hospitalRemoteDataSource: HospitalApiDataSource(Dio()),
                ),
              ),
              hospitalHiveDataSource: HospitalHiveDataSource()..init(),
            ),
            child: const HospitalForgetPassword(),
          ),
        );

      case adminForgetPassword:
        return MaterialPageRoute(builder: (context) => AdminForgetPassword());
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
