// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboarding_1_title => 'Welcome to LifeLink';

  @override
  String get onboarding_1_subTitle => 'Smart Blood Donation App';

  @override
  String get onboarding_1_desc_1 =>
      'Connecting donors with those in need, saving lives one donation at a time.';

  @override
  String get onboarding_2_title => 'The Problem';

  @override
  String get onboarding_2_subTitle => 'Current Challenges';

  @override
  String get onboarding_2_desc_1 =>
      'Difficulty finding donors quickly in emergencies';

  @override
  String get onboarding_2_desc_2 => 'No centralized donor database';

  @override
  String get onboarding_2_desc_3 => 'Lack of motivation for repeat donations';

  @override
  String get onboarding_3_title => 'The Solution';

  @override
  String get onboarding_3_subTitle => 'Our Features';

  @override
  String get onboarding_3_desc_1 => 'Fast GPS-based donor matching';

  @override
  String get onboarding_3_desc_2 => 'Instant emergency notifications';

  @override
  String get onboarding_3_desc_3 => 'Rewards system for donors';

  @override
  String get onboarding_4_title => 'Make a Difference';

  @override
  String get onboarding_4_subTitle => 'Join Our Community';

  @override
  String get onboarding_4_desc_1 =>
      'Every donation can save up to 3 lives. Be a hero in your community.';

  @override
  String get button_skip => 'Skip';

  @override
  String get button_back => 'Back';

  @override
  String get button_next => 'Next';

  @override
  String get button_get_started => 'Get Started';

  @override
  String get choose_role_title => 'Choose Your Role';

  @override
  String get choose_role_subTitle => 'How would you like to use LifeLink?';

  @override
  String get role_blood_donor_title => 'Blood Donor';

  @override
  String get role_blood_donor_desc =>
      'Register as a donor, track donations, earn rewards';

  @override
  String get role_blood_donor_button => 'Continue as Blood Donor';

  @override
  String get role_hospital_title => 'Hospital/Patient';

  @override
  String get role_hospital_desc =>
      'Request blood, find nearby donors, manage requests';

  @override
  String get role_hospital_button => 'Continue as Hospital/Patient';

  @override
  String get role_admin_title => 'Admin';

  @override
  String get role_admin_desc =>
      'Manage users, monitor donations, oversee the system';

  @override
  String get role_admin_button => 'Continue as Admin';
}
