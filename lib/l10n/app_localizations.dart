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

  /// No description provided for @reviewConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Review & Confirm'**
  String get reviewConfirmTitle;

  /// No description provided for @reviewConfirmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please review your appointment details'**
  String get reviewConfirmSubtitle;

  /// No description provided for @beforeYouDonate.
  ///
  /// In en, this message translates to:
  /// **'Before You Donate'**
  String get beforeYouDonate;

  /// No description provided for @donationTipEat.
  ///
  /// In en, this message translates to:
  /// **'Eat a healthy meal before donation'**
  String get donationTipEat;

  /// No description provided for @donationTipWater.
  ///
  /// In en, this message translates to:
  /// **'Drink plenty of water'**
  String get donationTipWater;

  /// No description provided for @donationTipId.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid ID'**
  String get donationTipId;

  /// No description provided for @donationTipSleep.
  ///
  /// In en, this message translates to:
  /// **'Get a good night\'s sleep'**
  String get donationTipSleep;

  /// No description provided for @confirmAppointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm appointment'**
  String get confirmAppointment;

  /// No description provided for @chooseLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get chooseLocationTitle;

  /// No description provided for @chooseLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where would you like to donate?'**
  String get chooseLocationSubtitle;

  /// No description provided for @selectDateTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Date & Time'**
  String get selectDateTimeTitle;

  /// No description provided for @selectDateTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When would you like to donate?'**
  String get selectDateTimeSubtitle;

  /// No description provided for @selectDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDateLabel;

  /// No description provided for @selectTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTimeLabel;

  /// No description provided for @donationTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Donation Type'**
  String get donationTypeLabel;

  /// No description provided for @datePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'mm/dd/yyyy'**
  String get datePlaceholder;

  /// No description provided for @continueStep.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueStep;

  /// No description provided for @confirmDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Details'**
  String get confirmDetailsTitle;

  /// No description provided for @confirmDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please verify your information'**
  String get confirmDetailsSubtitle;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressLabel;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Ziyad'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Sobhy'**
  String get lastNameHint;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'01XXXXXXXXX'**
  String get phoneHint;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'ziyad@gmail.com'**
  String get emailHint;

  /// No description provided for @appointmentConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment Confirmed!'**
  String get appointmentConfirmedTitle;

  /// No description provided for @appointmentConfirmedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your donation appointment has been successfully scheduled'**
  String get appointmentConfirmedSubtitle;

  /// No description provided for @whatsNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next:'**
  String get whatsNextTitle;

  /// No description provided for @nextStepEmail.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive a confirmation email'**
  String get nextStepEmail;

  /// No description provided for @nextStepReminder.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a reminder 24 hours before'**
  String get nextStepReminder;

  /// No description provided for @nextStepId.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid ID on the day of donation'**
  String get nextStepId;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @addToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to calendar'**
  String get addToCalendar;

  /// No description provided for @scheduleDonationTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Donation'**
  String get scheduleDonationTitle;

  /// No description provided for @scheduleStepCounter.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String scheduleStepCounter(Object current, Object total);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @whenLabel.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get whenLabel;

  /// No description provided for @chooseBloodType.
  ///
  /// In en, this message translates to:
  /// **'Choose a Blood Type'**
  String get chooseBloodType;

  /// No description provided for @wholeBlood.
  ///
  /// In en, this message translates to:
  /// **'Whole Blood'**
  String get wholeBlood;

  /// No description provided for @plasma.
  ///
  /// In en, this message translates to:
  /// **'Plasma'**
  String get plasma;

  /// No description provided for @platelets.
  ///
  /// In en, this message translates to:
  /// **'Platelets'**
  String get platelets;

  /// No description provided for @doubleRedCells.
  ///
  /// In en, this message translates to:
  /// **'Double Red Cells'**
  String get doubleRedCells;

  /// No description provided for @noteMessage.
  ///
  /// In en, this message translates to:
  /// **'Note: Appointments are typically available 24-48 hours in advance. Walk-ins are welcome during business hours.'**
  String get noteMessage;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTime;

  /// No description provided for @donationType.
  ///
  /// In en, this message translates to:
  /// **'Donation Type'**
  String get donationType;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfo;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'no email'**
  String get noEmail;

  /// No description provided for @noPhone.
  ///
  /// In en, this message translates to:
  /// **'no phone'**
  String get noPhone;

  /// No description provided for @chooseTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Choose a time slot'**
  String get chooseTimeSlot;

  /// No description provided for @confirmResponse.
  ///
  /// In en, this message translates to:
  /// **'Confirm Response'**
  String get confirmResponse;

  /// No description provided for @emergencyRequestQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you available to respond to this emergency blood request?'**
  String get emergencyRequestQuestion;

  /// No description provided for @acceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept - I Can Help'**
  String get acceptButton;

  /// No description provided for @declineButton.
  ///
  /// In en, this message translates to:
  /// **'Decline - Not Available'**
  String get declineButton;

  /// No description provided for @donationStatus.
  ///
  /// In en, this message translates to:
  /// **'Donation Status'**
  String get donationStatus;

  /// No description provided for @nextDonationReady.
  ///
  /// In en, this message translates to:
  /// **'Next donation: Ready now'**
  String get nextDonationReady;

  /// No description provided for @donor.
  ///
  /// In en, this message translates to:
  /// **'Donor'**
  String get donor;

  /// No description provided for @whatHappensNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next:'**
  String get whatHappensNext;

  /// No description provided for @hospitalNotified.
  ///
  /// In en, this message translates to:
  /// **'Hospital will be notified of your response'**
  String get hospitalNotified;

  /// No description provided for @directionsAndContact.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive directions and contact details'**
  String get directionsAndContact;

  /// No description provided for @arriveOnTime.
  ///
  /// In en, this message translates to:
  /// **'Please arrive within the estimated time'**
  String get arriveOnTime;

  /// No description provided for @urgentRequests.
  ///
  /// In en, this message translates to:
  /// **'Urgent Requests'**
  String get urgentRequests;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @donateNow.
  ///
  /// In en, this message translates to:
  /// **'Donate Now'**
  String get donateNow;

  /// No description provided for @respond.
  ///
  /// In en, this message translates to:
  /// **'Respond'**
  String get respond;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcomeBack(Object name);

  /// No description provided for @readyToSaveLives.
  ///
  /// In en, this message translates to:
  /// **'Ready to save lives today?'**
  String get readyToSaveLives;

  /// No description provided for @eligibleToDonate.
  ///
  /// In en, this message translates to:
  /// **'Eligible to donate'**
  String get eligibleToDonate;

  /// No description provided for @donations.
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get donations;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @livesSaved.
  ///
  /// In en, this message translates to:
  /// **'Lives Saved'**
  String get livesSaved;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @patientType.
  ///
  /// In en, this message translates to:
  /// **'PatientType'**
  String get patientType;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @iCanHelpRespondNow.
  ///
  /// In en, this message translates to:
  /// **'I Can Help - Respond Now'**
  String get iCanHelpRespondNow;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @whyYourResponseMatters.
  ///
  /// In en, this message translates to:
  /// **'Why Your Response Matters'**
  String get whyYourResponseMatters;

  /// No description provided for @responseMattersDescription.
  ///
  /// In en, this message translates to:
  /// **'Your blood type matches this urgent request. Your quick response could save a life. The patient needs 3 units of O+ blood for emergency surgery.'**
  String get responseMattersDescription;

  /// No description provided for @bloodTypeNeeded.
  ///
  /// In en, this message translates to:
  /// **'Blood Type Needed'**
  String get bloodTypeNeeded;

  /// No description provided for @urgentRequestActive.
  ///
  /// In en, this message translates to:
  /// **'Urgent Request Active'**
  String get urgentRequestActive;

  /// No description provided for @unitsNeeded.
  ///
  /// In en, this message translates to:
  /// **'Units Needed'**
  String get unitsNeeded;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @openInMap.
  ///
  /// In en, this message translates to:
  /// **'Open in Map'**
  String get openInMap;

  /// No description provided for @mapView.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get mapView;

  /// No description provided for @emergencyRequest.
  ///
  /// In en, this message translates to:
  /// **'Emergency Request'**
  String get emergencyRequest;

  /// No description provided for @criticalRequest.
  ///
  /// In en, this message translates to:
  /// **'Critical Request'**
  String get criticalRequest;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY'**
  String get emergency;

  /// No description provided for @critical.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL'**
  String get critical;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get units;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get find;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @notifications_unread.
  ///
  /// In en, this message translates to:
  /// **'{unreadCount} unread'**
  String notifications_unread(Object unreadCount);

  /// No description provided for @mark_all_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get mark_all_as_read;

  /// No description provided for @userDetails.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get userDetails;

  /// No description provided for @userDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage user details and actions.'**
  String get userDetailsSubtitle;

  /// No description provided for @adminRole.
  ///
  /// In en, this message translates to:
  /// **'Admin Role'**
  String get adminRole;

  /// No description provided for @systemAdministrator.
  ///
  /// In en, this message translates to:
  /// **'System Administrator'**
  String get systemAdministrator;

  /// No description provided for @respond_now.
  ///
  /// In en, this message translates to:
  /// **'Respond Now'**
  String get respond_now;

  /// No description provided for @findHospitals.
  ///
  /// In en, this message translates to:
  /// **'Find Hospitals'**
  String get findHospitals;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or location..'**
  String get searchHint;

  /// No description provided for @hospitalsNearby.
  ///
  /// In en, this message translates to:
  /// **'{count} hospitals nearby'**
  String hospitalsNearby(Object count);

  /// No description provided for @hospitalsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} Hospitals Found'**
  String hospitalsFound(Object count);

  /// No description provided for @sortByDistance.
  ///
  /// In en, this message translates to:
  /// **'Sort By Distance'**
  String get sortByDistance;

  /// No description provided for @contactHospital.
  ///
  /// In en, this message translates to:
  /// **'Contact Hospital'**
  String get contactHospital;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @adminActions.
  ///
  /// In en, this message translates to:
  /// **'Admin Actions'**
  String get adminActions;

  /// No description provided for @suspendUser.
  ///
  /// In en, this message translates to:
  /// **'Suspend User'**
  String get suspendUser;

  /// No description provided for @verifyUser.
  ///
  /// In en, this message translates to:
  /// **'Verify User'**
  String get verifyUser;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @iNeedToContactYouRegardingYourAccount.
  ///
  /// In en, this message translates to:
  /// **'I need to contact you regarding your account.'**
  String get iNeedToContactYouRegardingYourAccount;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteUser.
  ///
  /// In en, this message translates to:
  /// **'Delete User'**
  String get deleteUser;

  /// No description provided for @deleteUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user?'**
  String get deleteUserConfirm;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @donationMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I want to donate blood'**
  String get donationMessage;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(Object distance);

  /// No description provided for @urgentNeeds.
  ///
  /// In en, this message translates to:
  /// **'{count} urgent needs'**
  String urgentNeeds(Object count);

  /// No description provided for @hospitalType.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String hospitalType(Object type);

  /// No description provided for @navigateToHospital.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Hospital'**
  String get navigateToHospital;

  /// No description provided for @distanceAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String distanceAway(Object distance);

  /// No description provided for @openInGoogleMap.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Map'**
  String get openInGoogleMap;

  /// No description provided for @openInAppleMap.
  ///
  /// In en, this message translates to:
  /// **'Open in Apple Map'**
  String get openInAppleMap;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

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

  /// No description provided for @donor_pin_verification_title.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get donor_pin_verification_title;

  /// No description provided for @donor_pin_verification_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your 6-digit code to continue.'**
  String get donor_pin_verification_subtitle;

  /// No description provided for @donor_pin_verification_invalid_pin.
  ///
  /// In en, this message translates to:
  /// **'Please enter the full 6-digit code.'**
  String get donor_pin_verification_invalid_pin;

  /// No description provided for @donor_resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get donor_resend_code;

  /// No description provided for @donor_resending_code.
  ///
  /// In en, this message translates to:
  /// **'Resending code...'**
  String get donor_resending_code;

  /// No description provided for @donor_code_resent_success.
  ///
  /// In en, this message translates to:
  /// **'Verification code resent'**
  String get donor_code_resent_success;

  /// No description provided for @donor_code_resent_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to resend verification code'**
  String get donor_code_resent_error;

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

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @enterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid password'**
  String get enterValidPassword;

  /// No description provided for @phoneIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneIsRequired;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Egyptian phone number'**
  String get enterValidPhone;

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @enterValidName.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name'**
  String get enterValidName;

  /// No description provided for @locationIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Location is required'**
  String get locationIsRequired;

  /// No description provided for @enterValidLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid location'**
  String get enterValidLocation;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @readyToDonateTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to Donate'**
  String get readyToDonateTitle;

  /// No description provided for @readyToDonateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every donation can save up to 3 lives'**
  String get readyToDonateSubtitle;

  /// No description provided for @donationTip1.
  ///
  /// In en, this message translates to:
  /// **'Get a good night\'s sleep (7-8 hours)'**
  String get donationTip1;

  /// No description provided for @donationTip2.
  ///
  /// In en, this message translates to:
  /// **'Eat a healthy meal 2-3 hours before'**
  String get donationTip2;

  /// No description provided for @donationTip3.
  ///
  /// In en, this message translates to:
  /// **'Drink plenty of water (3-4 glasses)'**
  String get donationTip3;

  /// No description provided for @donationTip4.
  ///
  /// In en, this message translates to:
  /// **'Avoid fatty foods before donation'**
  String get donationTip4;

  /// No description provided for @donationTip5.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid photo ID'**
  String get donationTip5;

  /// No description provided for @donationTip6.
  ///
  /// In en, this message translates to:
  /// **'Wear comfortable clothing'**
  String get donationTip6;

  /// No description provided for @scheduleDonation.
  ///
  /// In en, this message translates to:
  /// **'Schedule Donation'**
  String get scheduleDonation;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @appointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'This appointment has been cancelled.'**
  String get appointmentCancelled;

  /// No description provided for @rescheduleAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Appointment'**
  String get rescheduleAppointmentTitle;

  /// No description provided for @rescheduleAppointmentMessage.
  ///
  /// In en, this message translates to:
  /// **'Would you like to reschedule your donation appointment?'**
  String get rescheduleAppointmentMessage;

  /// No description provided for @chooseNewDateTime.
  ///
  /// In en, this message translates to:
  /// **'Choose New Date & Time'**
  String get chooseNewDateTime;

  /// No description provided for @cancelDonation.
  ///
  /// In en, this message translates to:
  /// **'Cancel Donation'**
  String get cancelDonation;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @eligibleTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re Eligible to Donate'**
  String get eligibleTitle;

  /// No description provided for @eligibleDescription.
  ///
  /// In en, this message translates to:
  /// **'You meet all eligibility requirements for blood donation.'**
  String get eligibleDescription;

  /// No description provided for @faqQuestion1.
  ///
  /// In en, this message translates to:
  /// **'Does donating blood hurt?'**
  String get faqQuestion1;

  /// No description provided for @faqAnswer1.
  ///
  /// In en, this message translates to:
  /// **'No, donating blood is a painless process.'**
  String get faqAnswer1;

  /// No description provided for @faqQuestion2.
  ///
  /// In en, this message translates to:
  /// **'How long does the donation process take?'**
  String get faqQuestion2;

  /// No description provided for @faqAnswer2.
  ///
  /// In en, this message translates to:
  /// **'The donation process typically takes about 30-45 minutes.'**
  String get faqAnswer2;

  /// No description provided for @faqQuestion3.
  ///
  /// In en, this message translates to:
  /// **'When can I donate again?'**
  String get faqQuestion3;

  /// No description provided for @faqAnswer3.
  ///
  /// In en, this message translates to:
  /// **'You can donate again after 8 weeks.'**
  String get faqAnswer3;

  /// No description provided for @faqQuestion4.
  ///
  /// In en, this message translates to:
  /// **'What if I feel faint during donation?'**
  String get faqQuestion4;

  /// No description provided for @faqAnswer4.
  ///
  /// In en, this message translates to:
  /// **'If you feel faint, let the staff know immediately.'**
  String get faqAnswer4;

  /// No description provided for @whatToExpect.
  ///
  /// In en, this message translates to:
  /// **'What to Expect'**
  String get whatToExpect;

  /// No description provided for @instructionStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Registration & Health Check'**
  String get instructionStep1Title;

  /// No description provided for @instructionStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick medical history and vital signs check'**
  String get instructionStep1Subtitle;

  /// No description provided for @instructionStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Donation Process'**
  String get instructionStep2Title;

  /// No description provided for @instructionStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Comfortable seating while you donate (30-45 min)'**
  String get instructionStep2Subtitle;

  /// No description provided for @instructionStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Rest & Refreshments'**
  String get instructionStep3Title;

  /// No description provided for @instructionStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Relax with snacks and drinks before you go'**
  String get instructionStep3Subtitle;

  /// No description provided for @eligibilityRequirementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Eligibility Requirements'**
  String get eligibilityRequirementsTitle;

  /// No description provided for @reqAge.
  ///
  /// In en, this message translates to:
  /// **'Age: 18–65'**
  String get reqAge;

  /// No description provided for @reqWeight.
  ///
  /// In en, this message translates to:
  /// **'Minimum weight 50 kg'**
  String get reqWeight;

  /// No description provided for @reqLastDonation.
  ///
  /// In en, this message translates to:
  /// **'At least 3 months since last donation'**
  String get reqLastDonation;

  /// No description provided for @reqNoIllness.
  ///
  /// In en, this message translates to:
  /// **'No recent illness'**
  String get reqNoIllness;

  /// No description provided for @reqNoTattoos.
  ///
  /// In en, this message translates to:
  /// **'No recent tattoos or piercings'**
  String get reqNoTattoos;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minutesAgo(Object count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} h ago'**
  String hoursAgo(Object count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} d ago'**
  String daysAgo(Object count);

  /// No description provided for @gettingDistance.
  ///
  /// In en, this message translates to:
  /// **'Getting distance...'**
  String get gettingDistance;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @kmAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String kmAway(Object distance);

  /// No description provided for @hospitalLocation.
  ///
  /// In en, this message translates to:
  /// **'Hospital Location'**
  String get hospitalLocation;

  /// No description provided for @loadingMap.
  ///
  /// In en, this message translates to:
  /// **'Loading map...'**
  String get loadingMap;

  /// No description provided for @oopsError.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get oopsError;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @bloodDonationCenter.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation Center'**
  String get bloodDonationCenter;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'🩸 LifeLink - Blood Donation Center\n\n📍 Location:\n{lat}, {lng}\n\n🗺 View on Google Maps:\n{link}\n\nBe a hero. Donate blood. Save lives ❤️'**
  String shareMessage(Object lat, Object link, Object lng);

  /// No description provided for @protectYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Protect Your Account'**
  String get protectYourAccount;

  /// No description provided for @twoFactorDescription.
  ///
  /// In en, this message translates to:
  /// **'Add an extra layer of security by enabling two-factor authentication.'**
  String get twoFactorDescription;

  /// No description provided for @twoFactorSecurityInfo.
  ///
  /// In en, this message translates to:
  /// **'Enabling 2FA significantly reduces the risk of unauthorized access, even if your password is compromised.'**
  String get twoFactorSecurityInfo;

  /// No description provided for @smsVerification.
  ///
  /// In en, this message translates to:
  /// **'SMS Verification'**
  String get smsVerification;

  /// No description provided for @smsVerificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive a code via text message'**
  String get smsVerificationDescription;

  /// No description provided for @authenticatorApp.
  ///
  /// In en, this message translates to:
  /// **'Authenticator App'**
  String get authenticatorApp;

  /// No description provided for @authenticatorAppDescription.
  ///
  /// In en, this message translates to:
  /// **'Use Google Authenticator or Authy'**
  String get authenticatorAppDescription;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerification;

  /// No description provided for @emailVerificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive a code via email'**
  String get emailVerificationDescription;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Up'**
  String get setupTitle;

  /// No description provided for @twoFactorAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuthTitle;

  /// No description provided for @verificationMethods.
  ///
  /// In en, this message translates to:
  /// **'Verification Methods'**
  String get verificationMethods;

  /// No description provided for @infoBoxText.
  ///
  /// In en, this message translates to:
  /// **'Enabling 2FA significantly reduces the risk of unauthorized access, even if your password is compromised.'**
  String get infoBoxText;

  /// No description provided for @smsVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS Verification'**
  String get smsVerificationTitle;

  /// No description provided for @smsVerificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive a code via text message'**
  String get smsVerificationSubtitle;

  /// No description provided for @authAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Authenticator App'**
  String get authAppTitle;

  /// No description provided for @authAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use Google Authenticator or Authy'**
  String get authAppSubtitle;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationTitle;

  /// No description provided for @emailVerificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive a code via email'**
  String get emailVerificationSubtitle;

  /// No description provided for @setupTitleSms.
  ///
  /// In en, this message translates to:
  /// **'Set Up SMS Verification'**
  String get setupTitleSms;

  /// No description provided for @setupTitleApp.
  ///
  /// In en, this message translates to:
  /// **'Set Up Authenticator App'**
  String get setupTitleApp;

  /// No description provided for @setupTitleEmail.
  ///
  /// In en, this message translates to:
  /// **'Set Up Email Verification'**
  String get setupTitleEmail;

  /// No description provided for @setupDescSms.
  ///
  /// In en, this message translates to:
  /// **'A 6-digit code will be sent to your registered phone number each time you log in.'**
  String get setupDescSms;

  /// No description provided for @setupDescApp.
  ///
  /// In en, this message translates to:
  /// **'Use an authenticator app like Google Authenticator or Authy to generate time-based codes.'**
  String get setupDescApp;

  /// No description provided for @setupDescEmail.
  ///
  /// In en, this message translates to:
  /// **'A verification link or code will be sent to your registered email address.'**
  String get setupDescEmail;

  /// No description provided for @donationHistory.
  ///
  /// In en, this message translates to:
  /// **'Donation History'**
  String get donationHistory;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @blood.
  ///
  /// In en, this message translates to:
  /// **'Blood'**
  String get blood;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @passwordAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Password & Security'**
  String get passwordAndSecurity;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @twoFactorAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Two Factor Authentication'**
  String get twoFactorAuthentication;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications for requests'**
  String get pushNotificationsDesc;

  /// No description provided for @emergencyAlerts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alerts'**
  String get emergencyAlerts;

  /// No description provided for @emergencyAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'Urgent blood requests nearby'**
  String get emergencyAlertsDesc;

  /// No description provided for @privacyAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacyAndSecurity;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @changePasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password and a new password to update your account.'**
  String get changePasswordDescription;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Shows blood type followed by 'Donor'
  ///
  /// In en, this message translates to:
  /// **'{bloodType} Donor'**
  String donorLabel(Object bloodType);

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @totalDonations.
  ///
  /// In en, this message translates to:
  /// **'total donations'**
  String get totalDonations;

  /// No description provided for @pdfViewer.
  ///
  /// In en, this message translates to:
  /// **'PDF Viewer'**
  String get pdfViewer;

  /// No description provided for @loadingPdf.
  ///
  /// In en, this message translates to:
  /// **'Loading PDF...'**
  String get loadingPdf;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOf(Object current, Object total);

  /// No description provided for @helpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re here to help'**
  String get helpSubtitle;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get getHelp;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @chatSupport.
  ///
  /// In en, this message translates to:
  /// **'Chat with our support team'**
  String get chatSupport;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get emailUs;

  /// No description provided for @documentation.
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get documentation;

  /// No description provided for @userGuides.
  ///
  /// In en, this message translates to:
  /// **'User guides and tutorials'**
  String get userGuides;

  /// No description provided for @emailBodyRequestDocumentation.
  ///
  /// In en, this message translates to:
  /// **'I would like to request documentation on how to donate blood.'**
  String get emailBodyRequestDocumentation;

  /// No description provided for @documentationRequestSubject.
  ///
  /// In en, this message translates to:
  /// **'Documentation Request'**
  String get documentationRequestSubject;

  /// No description provided for @whatsappHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I need assistance'**
  String get whatsappHelpMessage;

  /// No description provided for @popularTopicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular Topics'**
  String get popularTopicsTitle;

  /// No description provided for @topicDonateBlood.
  ///
  /// In en, this message translates to:
  /// **'How to donate blood?'**
  String get topicDonateBlood;

  /// No description provided for @topicEligibility.
  ///
  /// In en, this message translates to:
  /// **'Eligibility requirements'**
  String get topicEligibility;

  /// No description provided for @topicEarnPoints.
  ///
  /// In en, this message translates to:
  /// **'How to earn points?'**
  String get topicEarnPoints;

  /// No description provided for @topicEmergencies.
  ///
  /// In en, this message translates to:
  /// **'Responding to emergencies'**
  String get topicEmergencies;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About LifeLink'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get aboutLastUpdated;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqTitle;

  /// No description provided for @faqHowToDonate.
  ///
  /// In en, this message translates to:
  /// **'How do I donate blood?'**
  String get faqHowToDonate;

  /// No description provided for @faqHowToDonateAnswer.
  ///
  /// In en, this message translates to:
  /// **'To donate blood, find a nearby donation center through the app, schedule an appointment, and make sure you meet the eligibility requirements. Stay hydrated and eat a healthy meal before donating.'**
  String get faqHowToDonateAnswer;

  /// No description provided for @faqEligibility.
  ///
  /// In en, this message translates to:
  /// **'What are the eligibility requirements?'**
  String get faqEligibility;

  /// No description provided for @faqEligibilityAnswer.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 17 years old, weigh at least 50 kg, be in good general health, and not have donated blood in the last 56 days. Certain medical conditions or medications may affect eligibility.'**
  String get faqEligibilityAnswer;

  /// No description provided for @faqEarnPoints.
  ///
  /// In en, this message translates to:
  /// **'How do I earn reward points?'**
  String get faqEarnPoints;

  /// No description provided for @faqEarnPointsAnswer.
  ///
  /// In en, this message translates to:
  /// **'You earn points each time you donate blood, refer a friend, complete your profile, or respond to emergency requests. Points can be redeemed for rewards in the app.'**
  String get faqEarnPointsAnswer;

  /// No description provided for @faqDonationFrequency.
  ///
  /// In en, this message translates to:
  /// **'How often can I donate blood?'**
  String get faqDonationFrequency;

  /// No description provided for @faqDonationFrequencyAnswer.
  ///
  /// In en, this message translates to:
  /// **'Whole blood can be donated every 56 days (8 weeks). Platelets can be donated every 7 days, up to 24 times per year. Plasma can be donated every 28 days.'**
  String get faqDonationFrequencyAnswer;

  /// No description provided for @faqBeforeDonation.
  ///
  /// In en, this message translates to:
  /// **'What should I do before donating?'**
  String get faqBeforeDonation;

  /// No description provided for @faqBeforeDonationAnswer.
  ///
  /// In en, this message translates to:
  /// **'Drink plenty of water, eat a healthy meal, avoid fatty foods, get a good night\'s sleep, and wear comfortable clothing with sleeves that can be rolled up easily.'**
  String get faqBeforeDonationAnswer;

  /// No description provided for @faqEmergencyResponse.
  ///
  /// In en, this message translates to:
  /// **'How do I respond to emergency requests?'**
  String get faqEmergencyResponse;

  /// No description provided for @faqEmergencyResponseAnswer.
  ///
  /// In en, this message translates to:
  /// **'When an emergency request matches your blood type, you will receive a push notification. Tap on it to view the details and confirm your availability to donate.'**
  String get faqEmergencyResponseAnswer;

  /// No description provided for @faqChangeBloodType.
  ///
  /// In en, this message translates to:
  /// **'How do I change my blood type?'**
  String get faqChangeBloodType;

  /// No description provided for @faqChangeBloodTypeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to your profile settings and tap on \"Edit Profile\". You can update your blood type there. Make sure to verify with your actual medical records.'**
  String get faqChangeBloodTypeAnswer;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Make changes to your profile here. Click save when you\'re done.'**
  String get editProfileDescription;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @thanksHero.
  ///
  /// In en, this message translates to:
  /// **'Thank You for Being a Hero! 🎉'**
  String get thanksHero;

  /// No description provided for @thanksHeroDesc.
  ///
  /// In en, this message translates to:
  /// **'Your {donationsCount} donations have helped save approximately {livesSaved} lives. Every donation makes a difference!'**
  String thanksHeroDesc(Object donationsCount, Object livesSaved);

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @rewards_and_achievements.
  ///
  /// In en, this message translates to:
  /// **'Rewards & Achievements'**
  String get rewards_and_achievements;

  /// No description provided for @your_points.
  ///
  /// In en, this message translates to:
  /// **'Your Points'**
  String get your_points;

  /// No description provided for @next_reward.
  ///
  /// In en, this message translates to:
  /// **'Next Reward'**
  String get next_reward;

  /// No description provided for @points_to_go.
  ///
  /// In en, this message translates to:
  /// **'pts to go'**
  String get points_to_go;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @rewards_redeemed.
  ///
  /// In en, this message translates to:
  /// **'Rewards Redeemed'**
  String get rewards_redeemed;

  /// No description provided for @you_have_successfully_redeemed.
  ///
  /// In en, this message translates to:
  /// **'You have successfully redeemed your reward'**
  String get you_have_successfully_redeemed;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @redeem_reward.
  ///
  /// In en, this message translates to:
  /// **'Redeem Reward'**
  String get redeem_reward;

  /// No description provided for @are_you_sure_you_want_to_redeem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to redeem this reward?'**
  String get are_you_sure_you_want_to_redeem;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @badge_unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get badge_unlocked;

  /// No description provided for @not_enough_points.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough points to redeem this reward'**
  String get not_enough_points;

  /// No description provided for @redeem_points.
  ///
  /// In en, this message translates to:
  /// **'Redeem Points'**
  String get redeem_points;

  /// No description provided for @coffee_voucher.
  ///
  /// In en, this message translates to:
  /// **'Coffee Voucher'**
  String get coffee_voucher;

  /// No description provided for @movie_tickets.
  ///
  /// In en, this message translates to:
  /// **'Movie Tickets'**
  String get movie_tickets;

  /// No description provided for @restaurant_gift_card.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Gift Card'**
  String get restaurant_gift_card;

  /// No description provided for @health_check_up.
  ///
  /// In en, this message translates to:
  /// **'Health Check-Up'**
  String get health_check_up;

  /// No description provided for @premium_badge.
  ///
  /// In en, this message translates to:
  /// **'Premium Badge'**
  String get premium_badge;

  /// No description provided for @gym_membership.
  ///
  /// In en, this message translates to:
  /// **'Gym Membership'**
  String get gym_membership;

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soon;

  /// No description provided for @points_history.
  ///
  /// In en, this message translates to:
  /// **'Points History'**
  String get points_history;

  /// No description provided for @blood_donation.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation'**
  String get blood_donation;

  /// No description provided for @emergency_response.
  ///
  /// In en, this message translates to:
  /// **'Emergency Response'**
  String get emergency_response;

  /// No description provided for @week_1_ago.
  ///
  /// In en, this message translates to:
  /// **'1 week ago'**
  String get week_1_ago;

  /// No description provided for @profile_completion.
  ///
  /// In en, this message translates to:
  /// **'Profile Completion'**
  String get profile_completion;

  /// No description provided for @weeks_2_ago.
  ///
  /// In en, this message translates to:
  /// **'2 weeks ago'**
  String get weeks_2_ago;

  /// No description provided for @referral_bonus.
  ///
  /// In en, this message translates to:
  /// **'Referral Bonus'**
  String get referral_bonus;

  /// No description provided for @weeks_3_ago.
  ///
  /// In en, this message translates to:
  /// **'3 weeks ago'**
  String get weeks_3_ago;

  /// No description provided for @how_to_earn_points.
  ///
  /// In en, this message translates to:
  /// **'How To Earn Points?'**
  String get how_to_earn_points;

  /// No description provided for @donate_blood_points.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation: 200 pts'**
  String get donate_blood_points;

  /// No description provided for @emergency_response_points.
  ///
  /// In en, this message translates to:
  /// **'Emergency Response: 100 pts'**
  String get emergency_response_points;

  /// No description provided for @refer_to_friends_points.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend: 150 pts'**
  String get refer_to_friends_points;

  /// No description provided for @complete_profile_points.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile: 50 pts'**
  String get complete_profile_points;

  /// No description provided for @your_badges.
  ///
  /// In en, this message translates to:
  /// **'Your Badges'**
  String get your_badges;

  /// No description provided for @first_timer.
  ///
  /// In en, this message translates to:
  /// **'First Timer'**
  String get first_timer;

  /// No description provided for @completed_first_donation.
  ///
  /// In en, this message translates to:
  /// **'Completed your first donation'**
  String get completed_first_donation;

  /// No description provided for @regular_donor.
  ///
  /// In en, this message translates to:
  /// **'Regular Donor'**
  String get regular_donor;

  /// No description provided for @donated_5_times.
  ///
  /// In en, this message translates to:
  /// **'Donated 5 times'**
  String get donated_5_times;

  /// No description provided for @life_saver.
  ///
  /// In en, this message translates to:
  /// **'Life Saver'**
  String get life_saver;

  /// No description provided for @donated_10_times.
  ///
  /// In en, this message translates to:
  /// **'Donated 10 times'**
  String get donated_10_times;

  /// No description provided for @hero.
  ///
  /// In en, this message translates to:
  /// **'Hero'**
  String get hero;

  /// No description provided for @donated_20_times.
  ///
  /// In en, this message translates to:
  /// **'Donated 20 times'**
  String get donated_20_times;

  /// No description provided for @legend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get legend;

  /// No description provided for @donated_50_times.
  ///
  /// In en, this message translates to:
  /// **'Donated 50 times'**
  String get donated_50_times;

  /// No description provided for @emergency_responder.
  ///
  /// In en, this message translates to:
  /// **'Emergency Responder'**
  String get emergency_responder;

  /// No description provided for @responded_to_10_emergencies.
  ///
  /// In en, this message translates to:
  /// **'Responded to 10 Emergencies'**
  String get responded_to_10_emergencies;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @blood_request_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Blood Request Dashboard'**
  String get blood_request_dashboard;

  /// No description provided for @active_requests.
  ///
  /// In en, this message translates to:
  /// **'Active Requests'**
  String get active_requests;

  /// No description provided for @responses_today.
  ///
  /// In en, this message translates to:
  /// **'Responses Today'**
  String get responses_today;

  /// No description provided for @emergency_request.
  ///
  /// In en, this message translates to:
  /// **'Emergency Request'**
  String get emergency_request;

  /// No description provided for @emergency_description.
  ///
  /// In en, this message translates to:
  /// **'Need blood urgently? Send immediate alerts to nearby donors.'**
  String get emergency_description;

  /// No description provided for @create_emergency_request.
  ///
  /// In en, this message translates to:
  /// **'Create Emergency Request'**
  String get create_emergency_request;

  /// No description provided for @emergency_blood_request.
  ///
  /// In en, this message translates to:
  /// **'Emergency Blood Request'**
  String get emergency_blood_request;

  /// No description provided for @emergency_blood_request_desc.
  ///
  /// In en, this message translates to:
  /// **'Enter details for the emergency blood request.'**
  String get emergency_blood_request_desc;

  /// No description provided for @blood_type.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get blood_type;

  /// No description provided for @select_blood_type.
  ///
  /// In en, this message translates to:
  /// **'Select Blood Type'**
  String get select_blood_type;

  /// No description provided for @units_needed.
  ///
  /// In en, this message translates to:
  /// **'Units Needed'**
  String get units_needed;

  /// No description provided for @enter_units_needed.
  ///
  /// In en, this message translates to:
  /// **'Enter number of units needed'**
  String get enter_units_needed;

  /// No description provided for @urgency.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get urgency;

  /// No description provided for @select_urgency.
  ///
  /// In en, this message translates to:
  /// **'Select Urgency Level'**
  String get select_urgency;

  /// No description provided for @submit_request.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submit_request;

  /// No description provided for @urgency_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get urgency_low;

  /// No description provided for @urgency_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get urgency_medium;

  /// No description provided for @urgency_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get urgency_high;

  /// No description provided for @recent_activity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recent_activity;

  /// No description provided for @privacy_Security.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacy_Security;

  /// No description provided for @mange_your_privacy_settings.
  ///
  /// In en, this message translates to:
  /// **'Manage your privacy settings'**
  String get mange_your_privacy_settings;

  /// No description provided for @all_blood_type.
  ///
  /// In en, this message translates to:
  /// **'All Blood Types'**
  String get all_blood_type;

  /// No description provided for @clear_filters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clear_filters;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @contact_donors.
  ///
  /// In en, this message translates to:
  /// **'Contact Donors'**
  String get contact_donors;

  /// No description provided for @responses.
  ///
  /// In en, this message translates to:
  /// **'{count} responses'**
  String responses(Object count);

  /// No description provided for @hours_ago.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hours_ago(Object count);

  /// No description provided for @unit_needed.
  ///
  /// In en, this message translates to:
  /// **'{count} units needed'**
  String unit_needed(Object count);

  /// No description provided for @time_left.
  ///
  /// In en, this message translates to:
  /// **'{count} hours left'**
  String time_left(Object count);

  /// No description provided for @time_left_label.
  ///
  /// In en, this message translates to:
  /// **'Time Left'**
  String get time_left_label;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @donors_have_responded.
  ///
  /// In en, this message translates to:
  /// **'{count} donors have responded'**
  String donors_have_responded(Object count);

  /// No description provided for @units_needed_count.
  ///
  /// In en, this message translates to:
  /// **'{count} units needed'**
  String units_needed_count(Object count);

  /// No description provided for @request_details.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get request_details;

  /// No description provided for @request_details_desc.
  ///
  /// In en, this message translates to:
  /// **'Details of the emergency blood request'**
  String get request_details_desc;

  /// No description provided for @contact_donor.
  ///
  /// In en, this message translates to:
  /// **'Contact Donor'**
  String get contact_donor;

  /// No description provided for @contact_donor_desc.
  ///
  /// In en, this message translates to:
  /// **'Available donors matching your blood request'**
  String get contact_donor_desc;

  /// No description provided for @request_for.
  ///
  /// In en, this message translates to:
  /// **'Request for'**
  String get request_for;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @hospital_message.
  ///
  /// In en, this message translates to:
  /// **'Hello, I am representing a hospital in need of blood and I would like to discuss how you can help.'**
  String get hospital_message;

  /// No description provided for @available_donors.
  ///
  /// In en, this message translates to:
  /// **'Available Donors({count})'**
  String available_donors(Object count);

  /// No description provided for @nearby_donor.
  ///
  /// In en, this message translates to:
  /// **'Nearby Donors (5km radius)'**
  String get nearby_donor;

  /// No description provided for @change_location.
  ///
  /// In en, this message translates to:
  /// **'Change Location'**
  String get change_location;

  /// No description provided for @change_location_desc.
  ///
  /// In en, this message translates to:
  /// **'Enter your new location:'**
  String get change_location_desc;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @zip_code.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zip_code;

  /// No description provided for @enter_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enter_address;

  /// No description provided for @enter_city.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enter_city;

  /// No description provided for @enter_state.
  ///
  /// In en, this message translates to:
  /// **'Enter your state'**
  String get enter_state;

  /// No description provided for @enter_zip_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your zip code'**
  String get enter_zip_code;

  /// No description provided for @donor_available.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String donor_available(Object distance);

  /// No description provided for @donors.
  ///
  /// In en, this message translates to:
  /// **'Donors'**
  String get donors;

  /// No description provided for @allUsers.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allUsers;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @find_donors.
  ///
  /// In en, this message translates to:
  /// **'Find Donors'**
  String get find_donors;

  /// No description provided for @find_donors_dec.
  ///
  /// In en, this message translates to:
  /// **'Search for available blood donors'**
  String get find_donors_dec;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @emergency_whatsapp_message.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}, there is an emergency case that needs blood type {bloodType}. Can you help?'**
  String emergency_whatsapp_message(Object bloodType, Object name);

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @note_dec.
  ///
  /// In en, this message translates to:
  /// **'Please be respectful of donor\'s time and availability when reaching out.'**
  String get note_dec;

  /// No description provided for @send_request.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get send_request;

  /// No description provided for @donors_found.
  ///
  /// In en, this message translates to:
  /// **'{count} Donors found'**
  String donors_found(Object count);

  /// No description provided for @create_request.
  ///
  /// In en, this message translates to:
  /// **'Blood Request'**
  String get create_request;

  /// No description provided for @create_request_dec.
  ///
  /// In en, this message translates to:
  /// **'Create a new blood donation request'**
  String get create_request_dec;

  /// No description provided for @alerts_message.
  ///
  /// In en, this message translates to:
  /// **'This will send immediate alerts to all nearby donors matching your blood type requirement. Use only for critical emergencies.'**
  String get alerts_message;

  /// No description provided for @patient_details.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patient_details;

  /// No description provided for @enter_patient_details.
  ///
  /// In en, this message translates to:
  /// **'Enter details about the patient in need of blood'**
  String get enter_patient_details;

  /// No description provided for @blood_type_needed.
  ///
  /// In en, this message translates to:
  /// **'Blood Type Needed'**
  String get blood_type_needed;

  /// No description provided for @confirm_donation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Donation'**
  String get confirm_donation;

  /// No description provided for @generate_donation_qr.
  ///
  /// In en, this message translates to:
  /// **'Generate Donation QR'**
  String get generate_donation_qr;

  /// No description provided for @qr_valid_message.
  ///
  /// In en, this message translates to:
  /// **'This QR code is valid for 5 minutes and can only be used once'**
  String get qr_valid_message;

  /// No description provided for @time_remaining.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get time_remaining;

  /// No description provided for @qr_expiry_warning.
  ///
  /// In en, this message translates to:
  /// **'This QR code can only be used once'**
  String get qr_expiry_warning;

  /// No description provided for @total_points.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get total_points;

  /// No description provided for @next_milestone.
  ///
  /// In en, this message translates to:
  /// **'Next Milestone'**
  String get next_milestone;

  /// No description provided for @points_until_milestone.
  ///
  /// In en, this message translates to:
  /// **'{points} points until {milestone}'**
  String points_until_milestone(Object milestone, Object points);

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @achievement_badges.
  ///
  /// In en, this message translates to:
  /// **'Achievement Badges'**
  String get achievement_badges;

  /// No description provided for @upcoming_rewards.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Rewards'**
  String get upcoming_rewards;

  /// No description provided for @gold_badge_reward.
  ///
  /// In en, this message translates to:
  /// **'🎁 Gold Badge: Priority donation scheduling'**
  String get gold_badge_reward;

  /// No description provided for @platinum_badge_reward.
  ///
  /// In en, this message translates to:
  /// **'🏆 Platinum Badge (5,000 pts): Exclusive merchandise'**
  String get platinum_badge_reward;

  /// No description provided for @confirm_donation_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm your donation'**
  String get confirm_donation_title;

  /// No description provided for @confirm_donation_desc.
  ///
  /// In en, this message translates to:
  /// **'Scan the hospital QR code to confirm your blood donation and earn points.'**
  String get confirm_donation_desc;

  /// No description provided for @scan_qr_code.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scan_qr_code;

  /// No description provided for @points_short.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get points_short;

  /// No description provided for @bronze_donor.
  ///
  /// In en, this message translates to:
  /// **'Bronze Donor'**
  String get bronze_donor;

  /// No description provided for @silver_donor.
  ///
  /// In en, this message translates to:
  /// **'Silver Donor'**
  String get silver_donor;

  /// No description provided for @gold_donor.
  ///
  /// In en, this message translates to:
  /// **'Gold Donor'**
  String get gold_donor;

  /// No description provided for @no_badge.
  ///
  /// In en, this message translates to:
  /// **'New Donor'**
  String get no_badge;

  /// No description provided for @scan_donation_qr.
  ///
  /// In en, this message translates to:
  /// **'Scan Donation QR'**
  String get scan_donation_qr;

  /// No description provided for @confirm_donation_qr_desc.
  ///
  /// In en, this message translates to:
  /// **'Confirm your donation with hospital QR code'**
  String get confirm_donation_qr_desc;

  /// No description provided for @how_it_works.
  ///
  /// In en, this message translates to:
  /// **'How it works?'**
  String get how_it_works;

  /// No description provided for @step_visit_hospital.
  ///
  /// In en, this message translates to:
  /// **'Visit the hospital or blood donation center'**
  String get step_visit_hospital;

  /// No description provided for @step_request_qr.
  ///
  /// In en, this message translates to:
  /// **'Request the donation QR code from staff'**
  String get step_request_qr;

  /// No description provided for @step_start_scanning.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Start Scanning\" below'**
  String get step_start_scanning;

  /// No description provided for @step_point_camera.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at the QR code'**
  String get step_point_camera;

  /// No description provided for @step_wait_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Wait for confirmation'**
  String get step_wait_confirmation;

  /// No description provided for @camera_scanner.
  ///
  /// In en, this message translates to:
  /// **'Camera Scanner'**
  String get camera_scanner;

  /// No description provided for @camera_ready.
  ///
  /// In en, this message translates to:
  /// **'Camera Ready'**
  String get camera_ready;

  /// No description provided for @tap_to_start.
  ///
  /// In en, this message translates to:
  /// **'Tap button below to start'**
  String get tap_to_start;

  /// No description provided for @scan_qr_description.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code provided by the hospital to confirm your donation.'**
  String get scan_qr_description;

  /// No description provided for @start_scanning.
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get start_scanning;

  /// No description provided for @security_notice_message.
  ///
  /// In en, this message translates to:
  /// **'Only scan QR codes provided directly by verified hospital staff. Never scan codes from untrusted sources.'**
  String get security_notice_message;

  /// No description provided for @recent_confirmations.
  ///
  /// In en, this message translates to:
  /// **'Recent Confirmations'**
  String get recent_confirmations;

  /// No description provided for @donationConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Donation Confirmed!'**
  String get donationConfirmedTitle;

  /// No description provided for @donationConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your blood donation has been successfully verified'**
  String get donationConfirmedMessage;

  /// No description provided for @youEarned.
  ///
  /// In en, this message translates to:
  /// **'You Earned'**
  String get youEarned;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get statusLabel;

  /// No description provided for @donationDetails.
  ///
  /// In en, this message translates to:
  /// **'Donation Details'**
  String get donationDetails;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get dateLabel;

  /// No description provided for @view_points.
  ///
  /// In en, this message translates to:
  /// **'View Points'**
  String get view_points;

  /// No description provided for @align_qr_frame.
  ///
  /// In en, this message translates to:
  /// **'Align the QR code inside the frame'**
  String get align_qr_frame;

  /// No description provided for @camera_error.
  ///
  /// In en, this message translates to:
  /// **'Camera error: {error}'**
  String camera_error(Object error);

  /// No description provided for @diamond_donor.
  ///
  /// In en, this message translates to:
  /// **'Diamond Donor'**
  String get diamond_donor;

  /// No description provided for @donation_thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank you for saving lives! Your contribution has been recorded in your donation history.'**
  String get donation_thank_you;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get typeLabel;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @securitySettings.
  ///
  /// In en, this message translates to:
  /// **'Security Settings'**
  String get securitySettings;

  /// No description provided for @securityInfo.
  ///
  /// In en, this message translates to:
  /// **'Keep your account secure by regularly updating your password and enabling two-factor authentication.'**
  String get securityInfo;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPasswordHint;

  /// No description provided for @twoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuth;

  /// No description provided for @extraSecurityLayer.
  ///
  /// In en, this message translates to:
  /// **'Add extra security layer'**
  String get extraSecurityLayer;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @notificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get notificationPreferences;

  /// No description provided for @receiveMobileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive mobile notifications'**
  String get receiveMobileNotifications;

  /// No description provided for @criticalDonorResponses.
  ///
  /// In en, this message translates to:
  /// **'Critical donor responses'**
  String get criticalDonorResponses;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @updatesViaEmail.
  ///
  /// In en, this message translates to:
  /// **'Updates via email'**
  String get updatesViaEmail;

  /// No description provided for @smsAlerts.
  ///
  /// In en, this message translates to:
  /// **'SMS Alerts'**
  String get smsAlerts;

  /// No description provided for @textMessageUpdates.
  ///
  /// In en, this message translates to:
  /// **'Text message updates'**
  String get textMessageUpdates;

  /// No description provided for @savePreferences.
  ///
  /// In en, this message translates to:
  /// **'Save Preferences'**
  String get savePreferences;

  /// No description provided for @hospitalName.
  ///
  /// In en, this message translates to:
  /// **'Hospital Name'**
  String get hospitalName;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @hospitalProfile.
  ///
  /// In en, this message translates to:
  /// **'Hospital Profile'**
  String get hospitalProfile;

  /// No description provided for @manageHospitalInformation.
  ///
  /// In en, this message translates to:
  /// **'Manage hospital information'**
  String get manageHospitalInformation;

  /// No description provided for @emergencyDepartment.
  ///
  /// In en, this message translates to:
  /// **'Emergency Department'**
  String get emergencyDepartment;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @accountStatistics.
  ///
  /// In en, this message translates to:
  /// **'Account Statistics'**
  String get accountStatistics;

  /// No description provided for @totalRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get totalRequests;

  /// No description provided for @fulfilled.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled'**
  String get fulfilled;

  /// No description provided for @successRate.
  ///
  /// In en, this message translates to:
  /// **'Success Rate'**
  String get successRate;

  /// No description provided for @requestHistory.
  ///
  /// In en, this message translates to:
  /// **'Request History'**
  String get requestHistory;

  /// No description provided for @trackBloodRequests.
  ///
  /// In en, this message translates to:
  /// **'Track your blood requests'**
  String get trackBloodRequests;

  /// No description provided for @recentRequests.
  ///
  /// In en, this message translates to:
  /// **'Recent Requests'**
  String get recentRequests;

  /// No description provided for @bloodRequest.
  ///
  /// In en, this message translates to:
  /// **'Blood Request'**
  String get bloodRequest;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @analyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Data insights and trends'**
  String get analyticsSubtitle;

  /// No description provided for @growthRate.
  ///
  /// In en, this message translates to:
  /// **'Growth Rate'**
  String get growthRate;

  /// No description provided for @monthlyTrend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trend'**
  String get monthlyTrend;

  /// No description provided for @aiPredictions.
  ///
  /// In en, this message translates to:
  /// **'AI Predictions'**
  String get aiPredictions;

  /// No description provided for @aiPrediction1.
  ///
  /// In en, this message translates to:
  /// **'AI predicts a 20% increase in donor turnout next month.'**
  String get aiPrediction1;

  /// No description provided for @aiPrediction2.
  ///
  /// In en, this message translates to:
  /// **'AI identifies a potential shortage of O- blood type in the next 2 weeks.'**
  String get aiPrediction2;

  /// No description provided for @aiPrediction3.
  ///
  /// In en, this message translates to:
  /// **'AI forecasts a 15% growth in successful donations over the next quarter.'**
  String get aiPrediction3;

  /// No description provided for @topic_create_request.
  ///
  /// In en, this message translates to:
  /// **'How to create blood request?'**
  String get topic_create_request;

  /// No description provided for @topic_qr_code.
  ///
  /// In en, this message translates to:
  /// **'How to generate QR code for blood request?'**
  String get topic_qr_code;

  /// No description provided for @topic_history.
  ///
  /// In en, this message translates to:
  /// **'How to view donation history?'**
  String get topic_history;

  /// No description provided for @topic_contact.
  ///
  /// In en, this message translates to:
  /// **'How to contact support?'**
  String get topic_contact;

  /// No description provided for @topic_update_profile.
  ///
  /// In en, this message translates to:
  /// **'How to update hospital profile?'**
  String get topic_update_profile;

  /// No description provided for @faqHowToCreateRequest.
  ///
  /// In en, this message translates to:
  /// **'How to create a blood request?'**
  String get faqHowToCreateRequest;

  /// No description provided for @faqHowToCreateRequestAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to the requests section, tap on \'Create Request\', fill in the required details like blood type, quantity, and location, then submit the request.'**
  String get faqHowToCreateRequestAnswer;

  /// No description provided for @faqQrCode.
  ///
  /// In en, this message translates to:
  /// **'How to generate a QR code for a blood request?'**
  String get faqQrCode;

  /// No description provided for @faqQrCodeAnswer.
  ///
  /// In en, this message translates to:
  /// **'After creating a blood request, open the request details and tap on \'Generate QR Code\' to create and share it.'**
  String get faqQrCodeAnswer;

  /// No description provided for @faqHistory.
  ///
  /// In en, this message translates to:
  /// **'How to view donation history?'**
  String get faqHistory;

  /// No description provided for @faqHistoryAnswer.
  ///
  /// In en, this message translates to:
  /// **'Navigate to the history section from your profile to see all previous donations and requests.'**
  String get faqHistoryAnswer;

  /// No description provided for @faqContact.
  ///
  /// In en, this message translates to:
  /// **'How to contact support?'**
  String get faqContact;

  /// No description provided for @faqContactAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to the Help & Support section and choose \'Contact Us\' to reach out via email or phone.'**
  String get faqContactAnswer;

  /// No description provided for @faqUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'How to update hospital profile?'**
  String get faqUpdateProfile;

  /// No description provided for @faqUpdateProfileAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open your profile settings, update the required information, and tap \'Save\' to apply the changes.'**
  String get faqUpdateProfileAnswer;

  /// No description provided for @requestDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View detailed information about the blood request.'**
  String get requestDetailsSubtitle;

  /// No description provided for @unitsRequested.
  ///
  /// In en, this message translates to:
  /// **'Units Requested'**
  String get unitsRequested;

  /// No description provided for @urgencyLevel.
  ///
  /// In en, this message translates to:
  /// **'Urgency Level'**
  String get urgencyLevel;

  /// No description provided for @donorsContacted.
  ///
  /// In en, this message translates to:
  /// **'Donors Contacted'**
  String get donorsContacted;

  /// No description provided for @donorsConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Donors Confirmed'**
  String get donorsConfirmed;

  /// No description provided for @completionTime.
  ///
  /// In en, this message translates to:
  /// **'Completion Time'**
  String get completionTime;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String hours(Object count);

  /// No description provided for @requestNoteDescription.
  ///
  /// In en, this message translates to:
  /// **'All blood request records are maintained for audit and compliance purposes.'**
  String get requestNoteDescription;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @notFulfilled.
  ///
  /// In en, this message translates to:
  /// **'Not Fulfilled'**
  String get notFulfilled;

  /// No description provided for @unitsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} units'**
  String unitsCount(Object count);

  /// No description provided for @pdfLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load PDF. Please try again later.'**
  String get pdfLoadError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'System overview and analytics'**
  String get dashboardSubtitle;

  /// No description provided for @criticalAlerts.
  ///
  /// In en, this message translates to:
  /// **'Critical Alerts'**
  String get criticalAlerts;

  /// No description provided for @alertBloodShortage.
  ///
  /// In en, this message translates to:
  /// **'O- blood shortage at City Hospital'**
  String get alertBloodShortage;

  /// No description provided for @alertHighDemand.
  ///
  /// In en, this message translates to:
  /// **'AI prediction: High demand for A+ expected'**
  String get alertHighDemand;

  /// No description provided for @alertEmergency.
  ///
  /// In en, this message translates to:
  /// **'Mass casualty event - Multiple blood types needed'**
  String get alertEmergency;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @bloodTypeDistribution.
  ///
  /// In en, this message translates to:
  /// **'Blood Type Distribution'**
  String get bloodTypeDistribution;

  /// No description provided for @units_count.
  ///
  /// In en, this message translates to:
  /// **'{count} units'**
  String units_count(Object count);

  /// No description provided for @aiInsights.
  ///
  /// In en, this message translates to:
  /// **'AI Insights'**
  String get aiInsights;

  /// No description provided for @predictedHighDemand.
  ///
  /// In en, this message translates to:
  /// **'Predicted High Demand'**
  String get predictedHighDemand;

  /// No description provided for @predictedHighDemandDesc.
  ///
  /// In en, this message translates to:
  /// **'A+ and O+ blood types expected to be in high demand next week'**
  String get predictedHighDemandDesc;

  /// No description provided for @shortageRisk.
  ///
  /// In en, this message translates to:
  /// **'Shortage Risk'**
  String get shortageRisk;

  /// No description provided for @shortageRiskDesc.
  ///
  /// In en, this message translates to:
  /// **'AB- blood type showing low donor availability in downtown area'**
  String get shortageRiskDesc;

  /// No description provided for @confidencePercentage.
  ///
  /// In en, this message translates to:
  /// **'{value}% confidence'**
  String confidencePercentage(Object value);

  /// No description provided for @systemOnline.
  ///
  /// In en, this message translates to:
  /// **'System Online'**
  String get systemOnline;

  /// No description provided for @weeklyTrends.
  ///
  /// In en, this message translates to:
  /// **'Weekly Trends'**
  String get weeklyTrends;

  /// No description provided for @allTopDonors.
  ///
  /// In en, this message translates to:
  /// **'All Top Donors'**
  String get allTopDonors;

  /// No description provided for @allTopDonorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all top donors and their contribution history.'**
  String get allTopDonorsSubtitle;

  /// No description provided for @lastDonation.
  ///
  /// In en, this message translates to:
  /// **'Last donation'**
  String get lastDonation;

  /// No description provided for @top_donors_in_month.
  ///
  /// In en, this message translates to:
  /// **'Top donors in the month'**
  String get top_donors_in_month;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @sendEmergencyBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Send Emergency Broadcast'**
  String get sendEmergencyBroadcast;

  /// No description provided for @alertDetails.
  ///
  /// In en, this message translates to:
  /// **'Alert Details'**
  String get alertDetails;

  /// No description provided for @alertDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View detailed information about this alert.'**
  String get alertDetailsSubtitle;

  /// No description provided for @totalDonors.
  ///
  /// In en, this message translates to:
  /// **'Total Donors'**
  String get totalDonors;

  /// No description provided for @activeRequests.
  ///
  /// In en, this message translates to:
  /// **'Active Requests'**
  String get activeRequests;

  /// No description provided for @criticalCases.
  ///
  /// In en, this message translates to:
  /// **'Critical Cases'**
  String get criticalCases;

  /// No description provided for @successfulDonations.
  ///
  /// In en, this message translates to:
  /// **'Successful Donations'**
  String get successfulDonations;

  /// No description provided for @just_now.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get just_now;

  /// No description provided for @minutes_ago.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutes_ago(Object minutes);

  /// No description provided for @days_ago.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String days_ago(Object days);

  /// No description provided for @hospitals.
  ///
  /// In en, this message translates to:
  /// **'Hospitals'**
  String get hospitals;

  /// No description provided for @admins.
  ///
  /// In en, this message translates to:
  /// **'Admins'**
  String get admins;

  /// No description provided for @userManagement.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get userManagement;

  /// No description provided for @manageUsersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage donors, hospitals, and administrators'**
  String get manageUsersSubtitle;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @recentUsers.
  ///
  /// In en, this message translates to:
  /// **'Recent Users'**
  String get recentUsers;

  /// No description provided for @addHospital.
  ///
  /// In en, this message translates to:
  /// **'Add Hospital'**
  String get addHospital;

  /// No description provided for @addHospitalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new hospital to the system.'**
  String get addHospitalSubtitle;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @selectHospitalType.
  ///
  /// In en, this message translates to:
  /// **'Select hospital type'**
  String get selectHospitalType;

  /// No description provided for @governmentHospital.
  ///
  /// In en, this message translates to:
  /// **'Government Hospital'**
  String get governmentHospital;

  /// No description provided for @privateHospital.
  ///
  /// In en, this message translates to:
  /// **'Private Hospital'**
  String get privateHospital;

  /// No description provided for @specializedHospital.
  ///
  /// In en, this message translates to:
  /// **'Specialized Hospital'**
  String get specializedHospital;

  /// No description provided for @communityHospital.
  ///
  /// In en, this message translates to:
  /// **'Community Hospital'**
  String get communityHospital;

  /// No description provided for @medicalCenter.
  ///
  /// In en, this message translates to:
  /// **'Medical Center'**
  String get medicalCenter;

  /// No description provided for @enterHospitalName.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital name'**
  String get enterHospitalName;

  /// No description provided for @enterHospitalEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital email'**
  String get enterHospitalEmail;

  /// No description provided for @enterHospitalContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital contact number'**
  String get enterHospitalContactNumber;

  /// No description provided for @enterHospitalAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital address'**
  String get enterHospitalAddress;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @enterHospitalLatitude.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital latitude'**
  String get enterHospitalLatitude;

  /// No description provided for @latitudeRangeError.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90'**
  String get latitudeRangeError;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @enterHospitalLongitude.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital longitude'**
  String get enterHospitalLongitude;

  /// No description provided for @longitudeRangeError.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get longitudeRangeError;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumber;

  /// No description provided for @enterHospitalLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter hospital license number'**
  String get enterHospitalLicenseNumber;

  /// No description provided for @adminContactName.
  ///
  /// In en, this message translates to:
  /// **'Admin Contact Name'**
  String get adminContactName;

  /// No description provided for @enterAdminContactName.
  ///
  /// In en, this message translates to:
  /// **'Enter admin contact name'**
  String get enterAdminContactName;

  /// No description provided for @adminContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Admin Contact Phone'**
  String get adminContactPhone;

  /// No description provided for @enterAdminContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter admin contact phone'**
  String get enterAdminContactPhone;

  /// No description provided for @emergencyContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Number'**
  String get emergencyContactNumber;

  /// No description provided for @enterEmergencyContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter emergency contact number'**
  String get enterEmergencyContactNumber;

  /// No description provided for @hospitalAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Hospital added successfully'**
  String get hospitalAddedSuccessfully;

  /// No description provided for @totalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get totalUsers;

  /// No description provided for @noTrendDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No trend data available'**
  String get noTrendDataAvailable;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @sendEmergencyBroadcastBtn.
  ///
  /// In en, this message translates to:
  /// **'Send Emergency Broadcast'**
  String get sendEmergencyBroadcastBtn;

  /// No description provided for @contactHospitalBtn.
  ///
  /// In en, this message translates to:
  /// **'Contact Hospital'**
  String get contactHospitalBtn;

  /// No description provided for @markAsFulfilledBtn.
  ///
  /// In en, this message translates to:
  /// **'Mark as Fulfilled'**
  String get markAsFulfilledBtn;

  /// No description provided for @cancelRequestBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request'**
  String get cancelRequestBtn;

  /// No description provided for @alertPrefix.
  ///
  /// In en, this message translates to:
  /// **'Alert: '**
  String get alertPrefix;

  /// No description provided for @alertCriticalMessage.
  ///
  /// In en, this message translates to:
  /// **'This is a critical request. Consider sending an emergency broadcast to all nearby donors.'**
  String get alertCriticalMessage;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @downTown.
  ///
  /// In en, this message translates to:
  /// **'DownTown'**
  String get downTown;

  /// No description provided for @eastSide.
  ///
  /// In en, this message translates to:
  /// **'EastSide'**
  String get eastSide;

  /// No description provided for @westSide.
  ///
  /// In en, this message translates to:
  /// **'WestSide'**
  String get westSide;

  /// No description provided for @hours_left.
  ///
  /// In en, this message translates to:
  /// **'{count} hours left'**
  String hours_left(Object count);

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @systemSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettingsTitle;

  /// No description provided for @systemSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure System Preferences'**
  String get systemSettingsSubtitle;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @criticalBloodShortageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Critical blood shortage notifications'**
  String get criticalBloodShortageNotifications;

  /// No description provided for @machineLearningDemandForecasts.
  ///
  /// In en, this message translates to:
  /// **'Machine learning demand forecasts'**
  String get machineLearningDemandForecasts;

  /// No description provided for @roleBasedPermissions.
  ///
  /// In en, this message translates to:
  /// **'Role-Based Permissions'**
  String get roleBasedPermissions;

  /// No description provided for @viewAuditLogs.
  ///
  /// In en, this message translates to:
  /// **'View Audit Logs'**
  String get viewAuditLogs;

  /// No description provided for @requiredForAllAdminAccounts.
  ///
  /// In en, this message translates to:
  /// **'Required for all admin accounts'**
  String get requiredForAllAdminAccounts;

  /// No description provided for @gpsAndLocation.
  ///
  /// In en, this message translates to:
  /// **'GPS & Location'**
  String get gpsAndLocation;

  /// No description provided for @configureSearchRadius.
  ///
  /// In en, this message translates to:
  /// **'Configure Search Radius'**
  String get configureSearchRadius;

  /// No description provided for @locationAccuracySettings.
  ///
  /// In en, this message translates to:
  /// **'Location Accuracy Settings'**
  String get locationAccuracySettings;

  /// No description provided for @systemHealth.
  ///
  /// In en, this message translates to:
  /// **'System Health'**
  String get systemHealth;

  /// No description provided for @systemHealthCheck.
  ///
  /// In en, this message translates to:
  /// **'System Health Check'**
  String get systemHealthCheck;

  /// No description provided for @editAdminProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Admin Profile'**
  String get editAdminProfile;

  /// No description provided for @updateAdminProfileInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your administrator profile information.'**
  String get updateAdminProfileInfo;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enterEmailAddress;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @systemManagement.
  ///
  /// In en, this message translates to:
  /// **'System Management'**
  String get systemManagement;

  /// No description provided for @userSupport.
  ///
  /// In en, this message translates to:
  /// **'User Support'**
  String get userSupport;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @selectDepartment.
  ///
  /// In en, this message translates to:
  /// **'Select Department'**
  String get selectDepartment;

  /// No description provided for @accessLevel.
  ///
  /// In en, this message translates to:
  /// **'Access Level'**
  String get accessLevel;

  /// No description provided for @selectAccessLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Access Level'**
  String get selectAccessLevel;

  /// No description provided for @pleaseSelectAccessLevel.
  ///
  /// In en, this message translates to:
  /// **'Please select access level'**
  String get pleaseSelectAccessLevel;

  /// No description provided for @fullAccess.
  ///
  /// In en, this message translates to:
  /// **'Full Access'**
  String get fullAccess;

  /// No description provided for @limitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Limited Access'**
  String get limitedAccess;

  /// No description provided for @viewOnly.
  ///
  /// In en, this message translates to:
  /// **'View Only'**
  String get viewOnly;

  /// No description provided for @adminAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Admin added successfully'**
  String get adminAddedSuccessfully;

  /// The main title of the blood requests screen
  ///
  /// In en, this message translates to:
  /// **'Blood Requests'**
  String get bloodRequestsTitle;

  /// Subtitle explaining the purpose of the screen
  ///
  /// In en, this message translates to:
  /// **'Monitor and manage all blood requests'**
  String get bloodRequestsSubtitle;

  /// No description provided for @criticalStatus.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get criticalStatus;

  /// No description provided for @fulfilledToday.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled Today'**
  String get fulfilledToday;

  /// No description provided for @unitsLabel.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get unitsLabel;

  /// No description provided for @contactedLabel.
  ///
  /// In en, this message translates to:
  /// **'contacted'**
  String get contactedLabel;

  /// No description provided for @confirmedLabel.
  ///
  /// In en, this message translates to:
  /// **'confirmed'**
  String get confirmedLabel;

  /// No description provided for @manageButton.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageButton;

  /// No description provided for @manageRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Blood Request'**
  String get manageRequestTitle;

  /// No description provided for @manageRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage the details and actions for this blood request.'**
  String get manageRequestSubtitle;

  /// No description provided for @bloodTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodTypeLabel;

  /// No description provided for @unitsNeededLabel.
  ///
  /// In en, this message translates to:
  /// **'Units Needed'**
  String get unitsNeededLabel;

  /// No description provided for @donorsContactedLabel.
  ///
  /// In en, this message translates to:
  /// **'Donors Contacted'**
  String get donorsContactedLabel;

  /// No description provided for @donorsConfirmedLabel.
  ///
  /// In en, this message translates to:
  /// **'Donors Confirmed'**
  String get donorsConfirmedLabel;

  /// No description provided for @adminActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Actions'**
  String get adminActionsTitle;

  /// No description provided for @addAdmin.
  ///
  /// In en, this message translates to:
  /// **'Add Admin'**
  String get addAdmin;

  /// No description provided for @notePrefix.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get notePrefix;

  /// No description provided for @adminNoteMessage.
  ///
  /// In en, this message translates to:
  /// **'Changes to your profile will be logged in the audit system and may require verification from another administrator.'**
  String get adminNoteMessage;

  /// No description provided for @pleasSelectDepartment.
  ///
  /// In en, this message translates to:
  /// **'Please select a department'**
  String get pleasSelectDepartment;

  /// No description provided for @roleBasedPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Role-Based Permissions'**
  String get roleBasedPermissionsTitle;

  /// No description provided for @roleBasedPermissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure access levels for different user roles.'**
  String get roleBasedPermissionsSubtitle;

  /// No description provided for @adminPermissions.
  ///
  /// In en, this message translates to:
  /// **'Admin Permissions'**
  String get adminPermissions;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @emergencyBroadcasts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Broadcasts'**
  String get emergencyBroadcasts;

  /// No description provided for @hospitalPermissions.
  ///
  /// In en, this message translates to:
  /// **'Hospital Permissions'**
  String get hospitalPermissions;

  /// No description provided for @createRequests.
  ///
  /// In en, this message translates to:
  /// **'Create Requests'**
  String get createRequests;

  /// No description provided for @generateQrCodes.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Codes'**
  String get generateQrCodes;

  /// No description provided for @viewAnalytics.
  ///
  /// In en, this message translates to:
  /// **'View Analytics'**
  String get viewAnalytics;

  /// No description provided for @donorPermissions.
  ///
  /// In en, this message translates to:
  /// **'Donor Permissions'**
  String get donorPermissions;

  /// No description provided for @viewRequests.
  ///
  /// In en, this message translates to:
  /// **'View Requests'**
  String get viewRequests;

  /// No description provided for @respondToAlerts.
  ///
  /// In en, this message translates to:
  /// **'Respond to Alerts'**
  String get respondToAlerts;

  /// No description provided for @earnRewards.
  ///
  /// In en, this message translates to:
  /// **'Earn Rewards'**
  String get earnRewards;

  /// No description provided for @systemControl.
  ///
  /// In en, this message translates to:
  /// **'System Control'**
  String get systemControl;

  /// No description provided for @enableMaintenanceMode.
  ///
  /// In en, this message translates to:
  /// **'Enable Maintenance Mode'**
  String get enableMaintenanceMode;

  /// No description provided for @emergencyShutdown.
  ///
  /// In en, this message translates to:
  /// **'Emergency Shutdown'**
  String get emergencyShutdown;

  /// No description provided for @runComprehensiveHealthCheck.
  ///
  /// In en, this message translates to:
  /// **'Run a comprehensive system health check.'**
  String get runComprehensiveHealthCheck;

  /// No description provided for @databaseConnection.
  ///
  /// In en, this message translates to:
  /// **'Database Connection'**
  String get databaseConnection;

  /// No description provided for @responseTime45ms.
  ///
  /// In en, this message translates to:
  /// **'Response time: 45ms'**
  String get responseTime45ms;

  /// No description provided for @apiServer.
  ///
  /// In en, this message translates to:
  /// **'API Server'**
  String get apiServer;

  /// No description provided for @uptime99_9.
  ///
  /// In en, this message translates to:
  /// **'Uptime: 99.9%'**
  String get uptime99_9;

  /// No description provided for @notificationService.
  ///
  /// In en, this message translates to:
  /// **'Notification Service'**
  String get notificationService;

  /// No description provided for @queue12Pending.
  ///
  /// In en, this message translates to:
  /// **'Queue: 12 pending'**
  String get queue12Pending;

  /// No description provided for @gpsServices.
  ///
  /// In en, this message translates to:
  /// **'GPS Services'**
  String get gpsServices;

  /// No description provided for @activeConnections234.
  ///
  /// In en, this message translates to:
  /// **'Active connections: 234'**
  String get activeConnections234;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @usedStorage.
  ///
  /// In en, this message translates to:
  /// **'Used: 45% (22GB / 50GB)'**
  String get usedStorage;

  /// No description provided for @healthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthy;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @reRunCheck.
  ///
  /// In en, this message translates to:
  /// **'Re-run Check'**
  String get reRunCheck;

  /// No description provided for @completeCheck.
  ///
  /// In en, this message translates to:
  /// **'Complete Check'**
  String get completeCheck;

  /// No description provided for @maintenanceWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning: '**
  String get maintenanceWarningTitle;

  /// No description provided for @maintenanceWarningMessage.
  ///
  /// In en, this message translates to:
  /// **' Enabling maintenance mode will temporarily disable access for all users except administrator'**
  String get maintenanceWarningMessage;

  /// No description provided for @maintenanceNoteMessage.
  ///
  /// In en, this message translates to:
  /// **'Users will see a maintenance message and will be unable to access the system during this time.'**
  String get maintenanceNoteMessage;

  /// No description provided for @enableMaintenanceModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Maintenance Mode'**
  String get enableMaintenanceModeTitle;

  /// No description provided for @enableMaintenanceModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Put the system into maintenance mode.'**
  String get enableMaintenanceModeSubtitle;

  /// No description provided for @reasonForMaintenanceMode.
  ///
  /// In en, this message translates to:
  /// **'Reason for Maintenance Mode'**
  String get reasonForMaintenanceMode;

  /// No description provided for @enterReasonForMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Enter the reason for enabling maintenance mode'**
  String get enterReasonForMaintenance;

  /// No description provided for @estimatedDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration (minutes)'**
  String get estimatedDurationMinutes;

  /// No description provided for @enterEstimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Enter the estimated duration of maintenance mode'**
  String get enterEstimatedDuration;

  /// No description provided for @enableMaintenanceButton.
  ///
  /// In en, this message translates to:
  /// **'Enable Maintenance'**
  String get enableMaintenanceButton;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @processingRequest.
  ///
  /// In en, this message translates to:
  /// **'Processing your request...'**
  String get processingRequest;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get loadingMessage;

  /// No description provided for @operationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Operation successful'**
  String get operationSuccessful;

  /// No description provided for @successDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get successDetails;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @donationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Donation successful'**
  String get donationSuccessful;

  /// No description provided for @requestSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Request successful'**
  String get requestSuccessful;

  /// No description provided for @thankYouDonation.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your donation'**
  String get thankYouDonation;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @errorDetails.
  ///
  /// In en, this message translates to:
  /// **'Error Details'**
  String get errorDetails;

  /// No description provided for @errorCode.
  ///
  /// In en, this message translates to:
  /// **'Error Code'**
  String get errorCode;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @dismissButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismissButton;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @failedToProcess.
  ///
  /// In en, this message translates to:
  /// **'Failed to process'**
  String get failedToProcess;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @processingDonation.
  ///
  /// In en, this message translates to:
  /// **'Processing your donation...'**
  String get processingDonation;

  /// No description provided for @fetchingData.
  ///
  /// In en, this message translates to:
  /// **'Fetching data...'**
  String get fetchingData;

  /// No description provided for @fetchingAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Fetching analytics...'**
  String get fetchingAnalytics;

  /// No description provided for @showQrCode.
  ///
  /// In en, this message translates to:
  /// **'Show QR Code'**
  String get showQrCode;

  /// No description provided for @donor_qr_card_title.
  ///
  /// In en, this message translates to:
  /// **'Your Donation QR Code'**
  String get donor_qr_card_title;

  /// No description provided for @donor_qr_card_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Show this QR code to hospital staff upon arrival to confirm your donation.'**
  String get donor_qr_card_subtitle;

  /// No description provided for @appointmentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetailsTitle;

  /// No description provided for @appointmentDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your donation QR code'**
  String get appointmentDetailsSubtitle;

  /// No description provided for @appointmentPrepStep1.
  ///
  /// In en, this message translates to:
  /// **'Arrive 10 minutes early'**
  String get appointmentPrepStep1;

  /// No description provided for @appointmentPrepStep2.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid photo ID'**
  String get appointmentPrepStep2;

  /// No description provided for @appointmentPrepStep3.
  ///
  /// In en, this message translates to:
  /// **'Have this QR code ready to scan'**
  String get appointmentPrepStep3;

  /// No description provided for @appointmentPrepStep4.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated before donation'**
  String get appointmentPrepStep4;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get important;

  /// No description provided for @appointmentInformation.
  ///
  /// In en, this message translates to:
  /// **'Appointment Information'**
  String get appointmentInformation;

  /// No description provided for @backToDonations.
  ///
  /// In en, this message translates to:
  /// **'Back to Donations'**
  String get backToDonations;

  /// No description provided for @shareQrCode.
  ///
  /// In en, this message translates to:
  /// **'Share Qr Code'**
  String get shareQrCode;

  /// No description provided for @bloodDonationAppointmentShare.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation Appointment'**
  String get bloodDonationAppointmentShare;

  /// No description provided for @hospitalLabel.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospitalLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @qrTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'QR Token'**
  String get qrTokenLabel;

  /// No description provided for @scanDonorQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Donor QR Code'**
  String get scanDonorQrCodeTitle;

  /// No description provided for @scanDonorQrCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Verify donors and record donations quickly using QR codes.'**
  String get scanDonorQrCodeDescription;

  /// No description provided for @openQrScannerButton.
  ///
  /// In en, this message translates to:
  /// **'Open Qr Scanner'**
  String get openQrScannerButton;

  /// No description provided for @lifeLinkBot.
  ///
  /// In en, this message translates to:
  /// **'LifeLink Bot'**
  String get lifeLinkBot;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please check your internet connection.'**
  String get connectionTimeout;

  /// No description provided for @sendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout while sending data. Try again.'**
  String get sendTimeout;

  /// No description provided for @receiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Server is taking too long to respond. Try again later.'**
  String get receiveTimeout;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternet;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get requestCancelled;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected network error occurred.'**
  String get unexpectedError;

  /// No description provided for @emptyResponse.
  ///
  /// In en, this message translates to:
  /// **'Empty response from server'**
  String get emptyResponse;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please check your email to verify your account.'**
  String get registrationSuccess;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful! Welcome back.'**
  String get loginSuccess;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get dateRequired;

  /// No description provided for @dateHint.
  ///
  /// In en, this message translates to:
  /// **'YYYY-MM-DD'**
  String get dateHint;

  /// No description provided for @pinVerificationCancelled.
  ///
  /// In en, this message translates to:
  /// **'PIN verification cancelled'**
  String get pinVerificationCancelled;

  /// No description provided for @invalidPin.
  ///
  /// In en, this message translates to:
  /// **'Invalid PIN. Please try again.'**
  String get invalidPin;

  /// No description provided for @invalid_pin_length.
  ///
  /// In en, this message translates to:
  /// **'PIN must be 6 digits long.'**
  String get invalid_pin_length;

  /// No description provided for @working_hours_and_slots.
  ///
  /// In en, this message translates to:
  /// **'Working Hours & Slots'**
  String get working_hours_and_slots;

  /// No description provided for @measure_in_hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get measure_in_hours;

  /// No description provided for @slots.
  ///
  /// In en, this message translates to:
  /// **'slots'**
  String get slots;

  /// No description provided for @manage_working_hours.
  ///
  /// In en, this message translates to:
  /// **'Manage Working Hours'**
  String get manage_working_hours;

  /// No description provided for @appointment_slots.
  ///
  /// In en, this message translates to:
  /// **'Appointment Slots'**
  String get appointment_slots;

  /// No description provided for @working_hours_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure your hospital\'s operating hours and appointment capacity'**
  String get working_hours_subtitle;

  /// No description provided for @working_hours_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: '**
  String get working_hours_tip;

  /// No description provided for @working_hours_tip_text.
  ///
  /// In en, this message translates to:
  /// **'Set your working hours and slots per hour. The same slot capacity will be applied to all hours.'**
  String get working_hours_tip_text;

  /// No description provided for @opening_time.
  ///
  /// In en, this message translates to:
  /// **'Opening Time'**
  String get opening_time;

  /// No description provided for @closing_time.
  ///
  /// In en, this message translates to:
  /// **'Closing Time'**
  String get closing_time;

  /// No description provided for @slots_per_hour.
  ///
  /// In en, this message translates to:
  /// **'Slots Per Hour'**
  String get slots_per_hour;

  /// No description provided for @slots_per_hour_text.
  ///
  /// In en, this message translates to:
  /// **'This value will be applied to every hour between opening and closing time.'**
  String get slots_per_hour_text;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @operating_hours.
  ///
  /// In en, this message translates to:
  /// **'Operating Hours: '**
  String get operating_hours;

  /// No description provided for @hours_per_day.
  ///
  /// In en, this message translates to:
  /// **'Hours Per Day: '**
  String get hours_per_day;

  /// No description provided for @total_daily_capacity.
  ///
  /// In en, this message translates to:
  /// **'Total Daily Capacity: '**
  String get total_daily_capacity;

  /// No description provided for @totalDailySlots.
  ///
  /// In en, this message translates to:
  /// **'Total Daily Slots'**
  String get totalDailySlots;

  /// No description provided for @availableForScheduling.
  ///
  /// In en, this message translates to:
  /// **'Available For Scheduling'**
  String get availableForScheduling;

  /// No description provided for @uniformAcrossAllHours.
  ///
  /// In en, this message translates to:
  /// **'Uniform Across All Hours'**
  String get uniformAcrossAllHours;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @noDonorsFound.
  ///
  /// In en, this message translates to:
  /// **'No Donors Found'**
  String get noDonorsFound;

  /// No description provided for @patientTypeAdult.
  ///
  /// In en, this message translates to:
  /// **'Adult'**
  String get patientTypeAdult;

  /// No description provided for @patientTypeChild.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get patientTypeChild;

  /// No description provided for @patientTypeInfant.
  ///
  /// In en, this message translates to:
  /// **'Infant'**
  String get patientTypeInfant;

  /// No description provided for @bloodTypeNeededMulti.
  ///
  /// In en, this message translates to:
  /// **'Blood Types Needed (Select one or more)'**
  String get bloodTypeNeededMulti;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @requiredBy.
  ///
  /// In en, this message translates to:
  /// **'Required By'**
  String get requiredBy;

  /// No description provided for @selectPatientType.
  ///
  /// In en, this message translates to:
  /// **'Select Patient Type'**
  String get selectPatientType;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @contactNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g: 015980089'**
  String get contactNumberHint;

  /// No description provided for @patientDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g: needed for surgery'**
  String get patientDetailsHint;

  /// No description provided for @noHistoryFound.
  ///
  /// In en, this message translates to:
  /// **'No History Found'**
  String get noHistoryFound;

  /// No description provided for @invalidUnits.
  ///
  /// In en, this message translates to:
  /// **'Invalid Units'**
  String get invalidUnits;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateRequest.
  ///
  /// In en, this message translates to:
  /// **'Update Request'**
  String get updateRequest;

  /// No description provided for @updateRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Edit the details for this blood request, then save your changes'**
  String get updateRequestSubtitle;

  /// No description provided for @cancelRequestConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this blood request? this action can\'t be undone'**
  String get cancelRequestConfirmation;

  /// No description provided for @keepRequest.
  ///
  /// In en, this message translates to:
  /// **'Keep Request'**
  String get keepRequest;

  /// No description provided for @yesCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel Request'**
  String get yesCancelRequest;

  /// No description provided for @patientDetailsSurgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get patientDetailsSurgery;

  /// No description provided for @patientDetailsCardiacSurgery.
  ///
  /// In en, this message translates to:
  /// **'Cardiac Surgery'**
  String get patientDetailsCardiacSurgery;

  /// No description provided for @patientDetailsAccident.
  ///
  /// In en, this message translates to:
  /// **'Accident'**
  String get patientDetailsAccident;

  /// No description provided for @patientDetailsBurns.
  ///
  /// In en, this message translates to:
  /// **'Burns'**
  String get patientDetailsBurns;

  /// No description provided for @patientDetailsCancer.
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get patientDetailsCancer;

  /// No description provided for @patientDetailsLeukemia.
  ///
  /// In en, this message translates to:
  /// **'Leukemia'**
  String get patientDetailsLeukemia;

  /// No description provided for @patientDetailsMaternity.
  ///
  /// In en, this message translates to:
  /// **'Maternity'**
  String get patientDetailsMaternity;

  /// No description provided for @patientDetailsChronicIllness.
  ///
  /// In en, this message translates to:
  /// **'Chronic Illness'**
  String get patientDetailsChronicIllness;

  /// No description provided for @patientDetailsHemophilia.
  ///
  /// In en, this message translates to:
  /// **'Hemophilia'**
  String get patientDetailsHemophilia;

  /// No description provided for @patientDetailsThalassemia.
  ///
  /// In en, this message translates to:
  /// **'Thalassemia'**
  String get patientDetailsThalassemia;

  /// No description provided for @patientDetailsDialysis.
  ///
  /// In en, this message translates to:
  /// **'Dialysis'**
  String get patientDetailsDialysis;

  /// No description provided for @patientDetailsGastrointestinalBleeding.
  ///
  /// In en, this message translates to:
  /// **'Gastrointestinal Bleeding'**
  String get patientDetailsGastrointestinalBleeding;

  /// No description provided for @patientDetailsOrganTransplant.
  ///
  /// In en, this message translates to:
  /// **'Organ Transplant'**
  String get patientDetailsOrganTransplant;

  /// No description provided for @patientDetailsPediatric.
  ///
  /// In en, this message translates to:
  /// **'Pediatric'**
  String get patientDetailsPediatric;

  /// No description provided for @patientDetailsEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get patientDetailsEmergency;

  /// No description provided for @patientDetailsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get patientDetailsGeneral;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @requestStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Request Status'**
  String get requestStatusLabel;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatus;

  /// No description provided for @selectStatus.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get selectStatus;

  /// No description provided for @activeRequestsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Active Requests'**
  String activeRequestsCount(Object count);

  /// No description provided for @responsesTodayCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Responses Today'**
  String responsesTodayCount(Object count);

  /// No description provided for @noActiveRequests.
  ///
  /// In en, this message translates to:
  /// **'No active requests right now'**
  String get noActiveRequests;

  /// No description provided for @noRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity'**
  String get noRecentActivity;

  /// No description provided for @noNearbyDonorsFound.
  ///
  /// In en, this message translates to:
  /// **'No nearby donors found'**
  String get noNearbyDonorsFound;

  /// No description provided for @nearestDonor.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get nearestDonor;

  /// No description provided for @donorsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} donors'**
  String donorsCountLabel(Object count);

  /// No description provided for @cancelRequestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled successfully'**
  String get cancelRequestSuccess;

  /// No description provided for @updateRequestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request updated successfully'**
  String get updateRequestSuccess;

  /// No description provided for @failedToLoadDashboard.
  ///
  /// In en, this message translates to:
  /// **'Failed to load dashboard data'**
  String get failedToLoadDashboard;

  /// No description provided for @failedToLoadRequests.
  ///
  /// In en, this message translates to:
  /// **'Failed to load requests'**
  String get failedToLoadRequests;

  /// No description provided for @failedToLoadActivity.
  ///
  /// In en, this message translates to:
  /// **'Failed to load recent activity'**
  String get failedToLoadActivity;

  /// No description provided for @failedToLoadNearbyDonors.
  ///
  /// In en, this message translates to:
  /// **'Failed to load nearby donors'**
  String get failedToLoadNearbyDonors;

  /// No description provided for @failedToLoadResponses.
  ///
  /// In en, this message translates to:
  /// **'Failed to load donor responses'**
  String get failedToLoadResponses;

  /// No description provided for @noResponsesYet.
  ///
  /// In en, this message translates to:
  /// **'No donors have responded yet'**
  String get noResponsesYet;

  /// No description provided for @donorResponseStatusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get donorResponseStatusDeclined;

  /// No description provided for @scanQrInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Point camera at donor\'s QR code'**
  String get scanQrInstructionTitle;

  /// No description provided for @verifyingQrCode.
  ///
  /// In en, this message translates to:
  /// **'Verifying QR code...'**
  String get verifyingQrCode;

  /// No description provided for @qrVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'QR verification failed.'**
  String get qrVerificationFailed;

  /// No description provided for @donationConfirmedSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Donation Confirmed!'**
  String get donationConfirmedSuccessTitle;

  /// No description provided for @donationConfirmedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'{donorName}\'s donation has been verified and recorded.'**
  String donationConfirmedSuccessMessage(Object donorName);

  /// No description provided for @scanAnotherCode.
  ///
  /// In en, this message translates to:
  /// **'Scan Another Code'**
  String get scanAnotherCode;

  /// No description provided for @invalidQrCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR code.'**
  String get invalidQrCode;

  /// No description provided for @qrCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'This QR code has expired.'**
  String get qrCodeExpired;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @allAppointments.
  ///
  /// In en, this message translates to:
  /// **'All Appointments'**
  String get allAppointments;

  /// No description provided for @noAppointmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No appointments found.'**
  String get noAppointmentsFound;

  /// No description provided for @enterCodeManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Code Manually'**
  String get enterCodeManually;

  /// No description provided for @manualEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual Entry'**
  String get manualEntry;

  /// No description provided for @enterDonationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the donation code'**
  String get enterDonationCode;

  /// No description provided for @donationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Donation Code'**
  String get donationCodeLabel;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @scanQrInstead.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code instead'**
  String get scanQrInstead;

  /// No description provided for @appointmentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appointmentDateLabel;

  /// No description provided for @rejectVerification.
  ///
  /// In en, this message translates to:
  /// **'Reject Verification'**
  String get rejectVerification;

  /// No description provided for @rejectConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this verification?'**
  String get rejectConfirmation;

  /// No description provided for @reasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reasonLabel;

  /// No description provided for @reasonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Patient not ready'**
  String get reasonHint;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @verificationRejected.
  ///
  /// In en, this message translates to:
  /// **'Verification rejected'**
  String get verificationRejected;

  /// No description provided for @pleaseEnterReason.
  ///
  /// In en, this message translates to:
  /// **'Please enter a reason'**
  String get pleaseEnterReason;

  /// No description provided for @pleaseCompleteChecklist.
  ///
  /// In en, this message translates to:
  /// **'Please complete all checklist items'**
  String get pleaseCompleteChecklist;

  /// No description provided for @eligibilityChecklist.
  ///
  /// In en, this message translates to:
  /// **'Eligibility Checklist'**
  String get eligibilityChecklist;

  /// No description provided for @donorNotEligible.
  ///
  /// In en, this message translates to:
  /// **'Donor is not eligible'**
  String get donorNotEligible;

  /// No description provided for @verificationChecklist.
  ///
  /// In en, this message translates to:
  /// **'Verification Checklist'**
  String get verificationChecklist;

  /// No description provided for @idVerified.
  ///
  /// In en, this message translates to:
  /// **'ID Verified'**
  String get idVerified;

  /// No description provided for @questionnaireCompleted.
  ///
  /// In en, this message translates to:
  /// **'Questionnaire Completed'**
  String get questionnaireCompleted;

  /// No description provided for @consentSigned.
  ///
  /// In en, this message translates to:
  /// **'Consent Signed'**
  String get consentSigned;

  /// No description provided for @diseaseScreening.
  ///
  /// In en, this message translates to:
  /// **'Disease Screening'**
  String get diseaseScreening;

  /// No description provided for @screeningCompleted.
  ///
  /// In en, this message translates to:
  /// **'Screening Completed (No disqualifying diseases)'**
  String get screeningCompleted;

  /// No description provided for @disqualifyingDiseaseFound.
  ///
  /// In en, this message translates to:
  /// **'Disqualifying Disease Found'**
  String get disqualifyingDiseaseFound;

  /// No description provided for @addDisease.
  ///
  /// In en, this message translates to:
  /// **'Add disease'**
  String get addDisease;

  /// No description provided for @addToList.
  ///
  /// In en, this message translates to:
  /// **'Add to list'**
  String get addToList;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional notes...'**
  String get additionalNotes;

  /// No description provided for @submitVerification.
  ///
  /// In en, this message translates to:
  /// **'Submit Verification'**
  String get submitVerification;

  /// No description provided for @pleaseFillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillRequiredFields;

  /// No description provided for @donationCompletion.
  ///
  /// In en, this message translates to:
  /// **'Donation Completion'**
  String get donationCompletion;

  /// No description provided for @donationCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Donation Completed Successfully!'**
  String get donationCompletedSuccessfully;

  /// No description provided for @pointsEarned.
  ///
  /// In en, this message translates to:
  /// **'Points earned: {count}'**
  String pointsEarned(Object count);

  /// No description provided for @recordDonorData.
  ///
  /// In en, this message translates to:
  /// **'Record Donor Data'**
  String get recordDonorData;

  /// No description provided for @enterDonorReadings.
  ///
  /// In en, this message translates to:
  /// **'Enter the donor\'s medical readings below'**
  String get enterDonorReadings;

  /// No description provided for @hemoglobinLevel.
  ///
  /// In en, this message translates to:
  /// **'Hemoglobin Level (g/dL)'**
  String get hemoglobinLevel;

  /// No description provided for @unitsCollected.
  ///
  /// In en, this message translates to:
  /// **'Units Collected'**
  String get unitsCollected;

  /// No description provided for @donationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter donation code'**
  String get donationCodeHint;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed.'**
  String get verificationFailed;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get connectionTimedOut;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternetConnection;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @notFoundItem.
  ///
  /// In en, this message translates to:
  /// **'Not found.'**
  String get notFoundItem;

  /// No description provided for @checkAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please check all fields and try again.'**
  String get checkAllFields;

  /// No description provided for @requestNotFound.
  ///
  /// In en, this message translates to:
  /// **'Request not found.'**
  String get requestNotFound;

  /// No description provided for @profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Profile not found.'**
  String get profileNotFound;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied.'**
  String get accessDenied;

  /// No description provided for @hospitalLocationNotSet.
  ///
  /// In en, this message translates to:
  /// **'Hospital location not set. Please update your profile.'**
  String get hospitalLocationNotSet;

  /// No description provided for @invalidStatusFilter.
  ///
  /// In en, this message translates to:
  /// **'Invalid status filter.'**
  String get invalidStatusFilter;

  /// No description provided for @failedLoadAppointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to load appointment details.'**
  String get failedLoadAppointmentDetails;

  /// No description provided for @failedCompleteDonation.
  ///
  /// In en, this message translates to:
  /// **'Failed to complete donation.'**
  String get failedCompleteDonation;

  /// No description provided for @failedRejectAppointment.
  ///
  /// In en, this message translates to:
  /// **'Failed to reject appointment.'**
  String get failedRejectAppointment;

  /// No description provided for @failedLoadRequestDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to load request details.'**
  String get failedLoadRequestDetails;

  /// No description provided for @requestUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request updated successfully.'**
  String get requestUpdatedSuccess;

  /// No description provided for @failedUpdateRequest.
  ///
  /// In en, this message translates to:
  /// **'Failed to update request.'**
  String get failedUpdateRequest;

  /// No description provided for @requestCancelledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled successfully.'**
  String get requestCancelledSuccess;

  /// No description provided for @failedLoadDonorResponses.
  ///
  /// In en, this message translates to:
  /// **'Failed to load donor responses.'**
  String get failedLoadDonorResponses;

  /// No description provided for @failedLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile.'**
  String get failedLoadProfile;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileUpdatedSuccess;

  /// No description provided for @workingHoursUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Working hours updated successfully.'**
  String get workingHoursUpdatedSuccess;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect.'**
  String get currentPasswordIncorrect;

  /// No description provided for @passwordMustBeDifferent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password.'**
  String get passwordMustBeDifferent;

  /// No description provided for @hospitalContactRequired.
  ///
  /// In en, this message translates to:
  /// **'Please set a contact number in your profile before creating a request.'**
  String get hospitalContactRequired;

  /// No description provided for @donationAlreadyCompleted.
  ///
  /// In en, this message translates to:
  /// **'This donation has already been completed.'**
  String get donationAlreadyCompleted;

  /// No description provided for @hospitalNotApproved.
  ///
  /// In en, this message translates to:
  /// **'Your hospital account is not yet approved. Please contact support@lifelink.org.'**
  String get hospitalNotApproved;

  /// No description provided for @invalidHospitalId.
  ///
  /// In en, this message translates to:
  /// **'Invalid hospital ID.'**
  String get invalidHospitalId;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidEmailOrPassword;

  /// No description provided for @activityRequestCreated.
  ///
  /// In en, this message translates to:
  /// **'Request created - {bloodTypes}'**
  String activityRequestCreated(Object bloodTypes);

  /// No description provided for @activityRequestFulfilled.
  ///
  /// In en, this message translates to:
  /// **'Request fulfilled - {bloodTypes}'**
  String activityRequestFulfilled(Object bloodTypes);

  /// No description provided for @activityDonorResponse.
  ///
  /// In en, this message translates to:
  /// **'New donor response - {donorName}'**
  String activityDonorResponse(Object donorName);

  /// No description provided for @activityDonorResponseFallback.
  ///
  /// In en, this message translates to:
  /// **'New donor response - Donor'**
  String get activityDonorResponseFallback;

  /// No description provided for @activityUnitsNeeded.
  ///
  /// In en, this message translates to:
  /// **'units needed {units}'**
  String activityUnitsNeeded(Object units);

  /// No description provided for @activityUnitsReceived.
  ///
  /// In en, this message translates to:
  /// **'units received {units}'**
  String activityUnitsReceived(Object units);

  /// No description provided for @activityDonorResponded.
  ///
  /// In en, this message translates to:
  /// **'{bloodType} donor responded'**
  String activityDonorResponded(Object bloodType);

  /// No description provided for @activityDonorRespondedFallback.
  ///
  /// In en, this message translates to:
  /// **'{bloodTypes} donor responded'**
  String activityDonorRespondedFallback(Object bloodTypes);

  /// No description provided for @notifications_match_title.
  ///
  /// In en, this message translates to:
  /// **'New Donor Matched'**
  String get notifications_match_title;

  /// No description provided for @notifications_match_body.
  ///
  /// In en, this message translates to:
  /// **'A donor has matched your {requestLabel} request'**
  String notifications_match_body(Object requestLabel);

  /// No description provided for @notifications_emergency_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Blood Request'**
  String get notifications_emergency_title;

  /// No description provided for @notifications_emergency_body.
  ///
  /// In en, this message translates to:
  /// **'Critical {bloodType} blood needed near {hospitalName}'**
  String notifications_emergency_body(Object bloodType, Object hospitalName);

  /// No description provided for @notifications_milestone_title.
  ///
  /// In en, this message translates to:
  /// **'Achievement Unlocked: {achievementTitle}'**
  String notifications_milestone_title(Object achievementTitle);

  /// No description provided for @notifications_milestone_body.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'ve unlocked: {achievementTitle}'**
  String notifications_milestone_body(Object achievementTitle);

  /// No description provided for @notifications_rewards_tier_upgraded.
  ///
  /// In en, this message translates to:
  /// **'Tier Upgraded to {newTier}!'**
  String notifications_rewards_tier_upgraded(Object newTier);

  /// No description provided for @notifications_rewards_badge_unlocked.
  ///
  /// In en, this message translates to:
  /// **'Badge Unlocked: {badgeName}'**
  String notifications_rewards_badge_unlocked(Object badgeName);

  /// No description provided for @notifications_rewards_reward_redeemed.
  ///
  /// In en, this message translates to:
  /// **'Reward Redeemed!'**
  String get notifications_rewards_reward_redeemed;

  /// No description provided for @notifications_appointment_rescheduled.
  ///
  /// In en, this message translates to:
  /// **'Appointment Rescheduled'**
  String get notifications_appointment_rescheduled;

  /// No description provided for @notifications_appointment_donor_rescheduled.
  ///
  /// In en, this message translates to:
  /// **'Donor Rescheduled Appointment'**
  String get notifications_appointment_donor_rescheduled;

  /// No description provided for @notifications_appointment_new_booked.
  ///
  /// In en, this message translates to:
  /// **'New Appointment Booked'**
  String get notifications_appointment_new_booked;

  /// No description provided for @notifications_appointment_cancelled_by_donor.
  ///
  /// In en, this message translates to:
  /// **'Appointment cancelled by donor'**
  String get notifications_appointment_cancelled_by_donor;

  /// No description provided for @notifications_activity_tier_promoted.
  ///
  /// In en, this message translates to:
  /// **'Tier Promoted'**
  String get notifications_activity_tier_promoted;

  /// No description provided for @notifications_activity_badge_unlocked.
  ///
  /// In en, this message translates to:
  /// **'Badge Unlocked'**
  String get notifications_activity_badge_unlocked;

  /// No description provided for @notifications_activity_redeemed_reward.
  ///
  /// In en, this message translates to:
  /// **'Reward Redeemed'**
  String get notifications_activity_redeemed_reward;

  /// No description provided for @notifications_activity_donation_created.
  ///
  /// In en, this message translates to:
  /// **'Donation Created'**
  String get notifications_activity_donation_created;

  /// No description provided for @notifications_activity_donation_verified.
  ///
  /// In en, this message translates to:
  /// **'Donation Verified'**
  String get notifications_activity_donation_verified;

  /// No description provided for @notifications_activity_donation_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Donation Confirmed'**
  String get notifications_activity_donation_confirmed;

  /// No description provided for @notifications_activity_donation_completed.
  ///
  /// In en, this message translates to:
  /// **'Donation Completed'**
  String get notifications_activity_donation_completed;

  /// No description provided for @notifications_activity_donation_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Donation Cancelled'**
  String get notifications_activity_donation_cancelled;

  /// No description provided for @notifications_activity_blood_donation_submitted.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation Submitted'**
  String get notifications_activity_blood_donation_submitted;

  /// No description provided for @notifications_activity_request_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get notifications_activity_request_cancelled;

  /// No description provided for @notifications_activity_request_rejected.
  ///
  /// In en, this message translates to:
  /// **'Request rejected'**
  String get notifications_activity_request_rejected;

  /// No description provided for @notifications_admin_registrations_rising.
  ///
  /// In en, this message translates to:
  /// **'Donor Registrations Rising'**
  String get notifications_admin_registrations_rising;

  /// No description provided for @notifications_admin_registrations_declining.
  ///
  /// In en, this message translates to:
  /// **'Donor Registrations Declining'**
  String get notifications_admin_registrations_declining;

  /// No description provided for @notifications_admin_verification_gap.
  ///
  /// In en, this message translates to:
  /// **'Verification Gap Detected'**
  String get notifications_admin_verification_gap;

  /// No description provided for @notifications_admin_inactive_hospitals.
  ///
  /// In en, this message translates to:
  /// **'Inactive Hospitals'**
  String get notifications_admin_inactive_hospitals;

  /// No description provided for @notifications_admin_donor_retention_alert.
  ///
  /// In en, this message translates to:
  /// **'Donor Retention Alert'**
  String get notifications_admin_donor_retention_alert;

  /// No description provided for @notifications_admin_suspension_spike.
  ///
  /// In en, this message translates to:
  /// **'Suspension Spike Detected'**
  String get notifications_admin_suspension_spike;

  /// No description provided for @notifications_admin_urgent_blood_request.
  ///
  /// In en, this message translates to:
  /// **'Urgent Blood Request'**
  String get notifications_admin_urgent_blood_request;

  /// No description provided for @notifications_analytics_critical_need_title.
  ///
  /// In en, this message translates to:
  /// **'Critical need for {bloodTypes}'**
  String notifications_analytics_critical_need_title(Object bloodTypes);

  /// No description provided for @notifications_analytics_predicted_high_demand_title.
  ///
  /// In en, this message translates to:
  /// **'Predicted High Demand'**
  String get notifications_analytics_predicted_high_demand_title;

  /// No description provided for @notifications_analytics_predicted_high_demand_body.
  ///
  /// In en, this message translates to:
  /// **'A {percent}% increase in blood requests is predicted next week.'**
  String notifications_analytics_predicted_high_demand_body(Object percent);

  /// No description provided for @notifications_analytics_rising_demand_title.
  ///
  /// In en, this message translates to:
  /// **'Rising Demand Trend'**
  String get notifications_analytics_rising_demand_title;

  /// No description provided for @notifications_analytics_rising_demand_body.
  ///
  /// In en, this message translates to:
  /// **'Blood requests are trending upward. Prepare additional resources.'**
  String get notifications_analytics_rising_demand_body;

  /// No description provided for @notifications_analytics_declining_demand_title.
  ///
  /// In en, this message translates to:
  /// **'Declining Demand'**
  String get notifications_analytics_declining_demand_title;

  /// No description provided for @notifications_analytics_declining_demand_body.
  ///
  /// In en, this message translates to:
  /// **'Blood requests are declining. Review inventory allocation.'**
  String get notifications_analytics_declining_demand_body;

  /// No description provided for @notifications_analytics_shortage_risk_title.
  ///
  /// In en, this message translates to:
  /// **'Shortage Risk'**
  String get notifications_analytics_shortage_risk_title;

  /// No description provided for @notifications_analytics_shortage_risk_body.
  ///
  /// In en, this message translates to:
  /// **'{bloodType} blood stock is expected to deplete within the next 4 days.'**
  String notifications_analytics_shortage_risk_body(Object bloodType);

  /// No description provided for @notifications_analytics_supply_warning_title.
  ///
  /// In en, this message translates to:
  /// **'Supply Warning'**
  String get notifications_analytics_supply_warning_title;

  /// No description provided for @notifications_analytics_supply_warning_body.
  ///
  /// In en, this message translates to:
  /// **'{bloodType} blood supply is approaching critical levels.'**
  String notifications_analytics_supply_warning_body(Object bloodType);

  /// No description provided for @notifications_analytics_peak_day_title.
  ///
  /// In en, this message translates to:
  /// **'Peak Day Insight'**
  String get notifications_analytics_peak_day_title;

  /// No description provided for @notifications_analytics_peak_day_body.
  ///
  /// In en, this message translates to:
  /// **'{peakDay} shows {pct}% higher donation activity. Consider scheduling more drives on this day.'**
  String notifications_analytics_peak_day_body(Object peakDay, Object pct);

  /// No description provided for @notifications_analytics_retention_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Donor Retention Alert'**
  String get notifications_analytics_retention_alert_title;

  /// No description provided for @notifications_analytics_retention_alert_body.
  ///
  /// In en, this message translates to:
  /// **'Donor return rate has dropped significantly. Consider re-engagement campaigns.'**
  String get notifications_analytics_retention_alert_body;

  /// No description provided for @notifications_analytics_growth_positive_title.
  ///
  /// In en, this message translates to:
  /// **'Donor Growth Positive'**
  String get notifications_analytics_growth_positive_title;

  /// No description provided for @notifications_analytics_growth_positive_body.
  ///
  /// In en, this message translates to:
  /// **'More donors are returning compared to last month. Momentum is strong.'**
  String get notifications_analytics_growth_positive_body;

  /// No description provided for @notifications_analytics_emergency_spike_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Demand Spike'**
  String get notifications_analytics_emergency_spike_title;

  /// No description provided for @notifications_analytics_emergency_spike_body.
  ///
  /// In en, this message translates to:
  /// **'Blood demand has surged unexpectedly in the last 3 days. Emergency response may be needed.'**
  String get notifications_analytics_emergency_spike_body;

  /// No description provided for @notifications_actions_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get notifications_actions_accept;

  /// No description provided for @notifications_actions_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get notifications_actions_view_details;

  /// No description provided for @notifications_delete_all.
  ///
  /// In en, this message translates to:
  /// **'Delete all notifications'**
  String get notifications_delete_all;

  /// No description provided for @notifications_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all notifications?'**
  String get notifications_delete_confirm;

  /// No description provided for @notifications_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Notifications deleted successfully'**
  String get notifications_delete_success;

  /// No description provided for @notifications_empty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notifications_empty;
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
