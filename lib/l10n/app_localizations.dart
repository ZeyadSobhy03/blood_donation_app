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
  /// **'Patient Type'**
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

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
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
  /// **'Appointment cancelled'**
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
