import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onboarding_1_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LifeLink'**
  String get onboarding_1_title;

  /// No description provided for @onboarding_1_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Blood Donation App'**
  String get onboarding_1_subTitle;

  /// No description provided for @onboarding_1_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Connecting donors with those in need, saving lives one donation at a time.'**
  String get onboarding_1_desc_1;

  /// No description provided for @onboarding_2_title.
  ///
  /// In en, this message translates to:
  /// **'The Problem'**
  String get onboarding_2_title;

  /// No description provided for @onboarding_2_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Challenges'**
  String get onboarding_2_subTitle;

  /// No description provided for @onboarding_2_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Difficulty finding donors quickly in emergencies'**
  String get onboarding_2_desc_1;

  /// No description provided for @onboarding_2_desc_2.
  ///
  /// In en, this message translates to:
  /// **'No centralized donor database'**
  String get onboarding_2_desc_2;

  /// No description provided for @onboarding_2_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Lack of motivation for repeat donations'**
  String get onboarding_2_desc_3;

  /// No description provided for @onboarding_3_title.
  ///
  /// In en, this message translates to:
  /// **'The Solution'**
  String get onboarding_3_title;

  /// No description provided for @onboarding_3_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Features'**
  String get onboarding_3_subTitle;

  /// No description provided for @onboarding_3_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Fast GPS-based donor matching'**
  String get onboarding_3_desc_1;

  /// No description provided for @onboarding_3_desc_2.
  ///
  /// In en, this message translates to:
  /// **'Instant emergency notifications'**
  String get onboarding_3_desc_2;

  /// No description provided for @onboarding_3_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Rewards system for donors'**
  String get onboarding_3_desc_3;

  /// No description provided for @onboarding_4_title.
  ///
  /// In en, this message translates to:
  /// **'Make a Difference'**
  String get onboarding_4_title;

  /// No description provided for @onboarding_4_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Our Community'**
  String get onboarding_4_subTitle;

  /// No description provided for @onboarding_4_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Every donation can save up to 3 lives. Be a hero in your community.'**
  String get onboarding_4_desc_1;

  /// No description provided for @button_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get button_skip;

  /// No description provided for @button_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get button_back;

  /// No description provided for @button_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get button_next;

  /// No description provided for @button_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get button_get_started;

  /// No description provided for @choose_role_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get choose_role_title;

  /// No description provided for @choose_role_subTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to use LifeLink?'**
  String get choose_role_subTitle;

  /// No description provided for @role_blood_donor_title.
  ///
  /// In en, this message translates to:
  /// **'Blood Donor'**
  String get role_blood_donor_title;

  /// No description provided for @role_blood_donor_desc.
  ///
  /// In en, this message translates to:
  /// **'Register as a donor, track donations, earn rewards'**
  String get role_blood_donor_desc;

  /// No description provided for @role_blood_donor_button.
  ///
  /// In en, this message translates to:
  /// **'Continue as Blood Donor'**
  String get role_blood_donor_button;

  /// No description provided for @role_hospital_title.
  ///
  /// In en, this message translates to:
  /// **'Hospital/Patient'**
  String get role_hospital_title;

  /// No description provided for @role_hospital_desc.
  ///
  /// In en, this message translates to:
  /// **'Request blood, find nearby donors, manage requests'**
  String get role_hospital_desc;

  /// No description provided for @role_hospital_button.
  ///
  /// In en, this message translates to:
  /// **'Continue as Hospital/Patient'**
  String get role_hospital_button;

  /// No description provided for @role_admin_title.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get role_admin_title;

  /// No description provided for @role_admin_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage users, monitor donations, oversee the system'**
  String get role_admin_desc;

  /// No description provided for @role_admin_button.
  ///
  /// In en, this message translates to:
  /// **'Continue as Admin'**
  String get role_admin_button;

  /// No description provided for @donor_login_title.
  ///
  /// In en, this message translates to:
  /// **'Donor Access'**
  String get donor_login_title;

  /// No description provided for @donor_login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'LifeLink Blood Donation'**
  String get donor_login_subtitle;

  /// No description provided for @donor_login_card_title.
  ///
  /// In en, this message translates to:
  /// **'Login to Your Account'**
  String get donor_login_card_title;

  /// No description provided for @donor_email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get donor_email;

  /// No description provided for @donor_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get donor_password;

  /// No description provided for @donor_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get donor_forget_password;

  /// No description provided for @donor_login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get donor_login_button;

  /// No description provided for @donor_dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get donor_dont_have_account;

  /// No description provided for @donor_register_now.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get donor_register_now;

  /// No description provided for @donor_register_title.
  ///
  /// In en, this message translates to:
  /// **'Create Donor Account'**
  String get donor_register_title;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @donor_blood_type.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get donor_blood_type;

  /// No description provided for @donor_select_blood_type.
  ///
  /// In en, this message translates to:
  /// **'Select blood type'**
  String get donor_select_blood_type;

  /// No description provided for @donor_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get donor_location;

  /// No description provided for @city_state.
  ///
  /// In en, this message translates to:
  /// **'City, State'**
  String get city_state;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have Account?'**
  String get already_have_account;

  /// No description provided for @donor_forget_password_title.
  ///
  /// In en, this message translates to:
  /// **'Donor Reset Password'**
  String get donor_forget_password_title;

  /// No description provided for @donor_forget_password_text.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get donor_forget_password_text;

  /// No description provided for @donor_send_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get donor_send_reset_link;

  /// No description provided for @donor_back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back To Login'**
  String get donor_back_to_login;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Email'**
  String get please_enter_email;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Password'**
  String get please_enter_password;

  /// No description provided for @please_enter_fullname.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Full Name'**
  String get please_enter_fullname;

  /// No description provided for @please_enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Phone Number'**
  String get please_enter_phone;

  /// No description provided for @please_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please Confirm Password'**
  String get please_confirm_password;

  /// No description provided for @please_enter_location.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Location'**
  String get please_enter_location;

  /// No description provided for @please_enter_hospital_id.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Hospital ID'**
  String get please_enter_hospital_id;

  /// No description provided for @please_enter_official_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Official Email Address'**
  String get please_enter_official_email;

  /// No description provided for @please_enter_secure_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Secure Password'**
  String get please_enter_secure_password;

  /// No description provided for @please_enter_admin_access_key.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Admin Access Key'**
  String get please_enter_admin_access_key;

  /// No description provided for @please_enter_admin_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Administrator Email'**
  String get please_enter_admin_email;

  /// No description provided for @hospital_portal.
  ///
  /// In en, this message translates to:
  /// **'Hospital/Patient Portal'**
  String get hospital_portal;

  /// No description provided for @authorized_access_only.
  ///
  /// In en, this message translates to:
  /// **'Authorized Access Only'**
  String get authorized_access_only;

  /// No description provided for @secure_login.
  ///
  /// In en, this message translates to:
  /// **'Secure Login'**
  String get secure_login;

  /// No description provided for @hospital_patient_authentication.
  ///
  /// In en, this message translates to:
  /// **'Hospital/Patient Authentication'**
  String get hospital_patient_authentication;

  /// No description provided for @hospital_id.
  ///
  /// In en, this message translates to:
  /// **'Hospital ID'**
  String get hospital_id;

  /// No description provided for @official_email.
  ///
  /// In en, this message translates to:
  /// **'Official Email Address'**
  String get official_email;

  /// No description provided for @secure_password.
  ///
  /// In en, this message translates to:
  /// **'Secure Password'**
  String get secure_password;

  /// No description provided for @new_hospital_patient.
  ///
  /// In en, this message translates to:
  /// **'New Hospital or Patient?'**
  String get new_hospital_patient;

  /// No description provided for @hospital_contact_text_1.
  ///
  /// In en, this message translates to:
  /// **'Contact our Administration Team at: '**
  String get hospital_contact_text_1;

  /// No description provided for @hospital_contact_text_2.
  ///
  /// In en, this message translates to:
  /// **' to register your facility or request access'**
  String get hospital_contact_text_2;

  /// No description provided for @admin_portal.
  ///
  /// In en, this message translates to:
  /// **'Administrator Portal'**
  String get admin_portal;

  /// No description provided for @system_management_access.
  ///
  /// In en, this message translates to:
  /// **'System Management Access'**
  String get system_management_access;

  /// No description provided for @restricted_access_area.
  ///
  /// In en, this message translates to:
  /// **'Restricted Access Area'**
  String get restricted_access_area;

  /// No description provided for @admin_authentication.
  ///
  /// In en, this message translates to:
  /// **'Admin Authentication'**
  String get admin_authentication;

  /// No description provided for @admin_access_key.
  ///
  /// In en, this message translates to:
  /// **'Admin Access Key'**
  String get admin_access_key;

  /// No description provided for @admin_email.
  ///
  /// In en, this message translates to:
  /// **'Administrator Email'**
  String get admin_email;

  /// No description provided for @secure_admin_login.
  ///
  /// In en, this message translates to:
  /// **'Secure Admin Login'**
  String get secure_admin_login;

  /// No description provided for @security_notice.
  ///
  /// In en, this message translates to:
  /// **'Security Notice:'**
  String get security_notice;

  /// No description provided for @security_notice_desc.
  ///
  /// In en, this message translates to:
  /// **'All admin login attempts are logged and monitored. Unauthorized access attempts will be reported to system security.'**
  String get security_notice_desc;

  /// No description provided for @need_access.
  ///
  /// In en, this message translates to:
  /// **'Need Access?'**
  String get need_access;

  /// No description provided for @contact_system_admin.
  ///
  /// In en, this message translates to:
  /// **'Contact the System Administrator at:'**
  String get contact_system_admin;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
