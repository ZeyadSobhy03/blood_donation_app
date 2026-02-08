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

  @override
  String get reviewConfirmTitle => 'Review & Confirm';

  @override
  String get reviewConfirmSubtitle => 'Please review your appointment details';

  @override
  String get beforeYouDonate => 'Before You Donate';

  @override
  String get donationTipEat => 'Eat a healthy meal before donation';

  @override
  String get donationTipWater => 'Drink plenty of water';

  @override
  String get donationTipId => 'Bring a valid ID';

  @override
  String get donationTipSleep => 'Get a good night\'s sleep';

  @override
  String get confirmAppointment => 'Confirm appointment';

  @override
  String get chooseLocationTitle => 'Choose Location';

  @override
  String get chooseLocationSubtitle => 'Where would you like to donate?';

  @override
  String get selectDateTimeTitle => 'Select Date & Time';

  @override
  String get selectDateTimeSubtitle => 'When would you like to donate?';

  @override
  String get selectDateLabel => 'Select Date';

  @override
  String get selectTimeLabel => 'Select Time';

  @override
  String get donationTypeLabel => 'Donation Type';

  @override
  String get datePlaceholder => 'mm/dd/yyyy';

  @override
  String get continueStep => 'Continue';

  @override
  String get confirmDetailsTitle => 'Confirm Your Details';

  @override
  String get confirmDetailsSubtitle => 'Please verify your information';

  @override
  String get firstNameLabel => 'First Name';

  @override
  String get lastNameLabel => 'Last Name';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get firstNameHint => 'Ziyad';

  @override
  String get lastNameHint => 'Sobhy';

  @override
  String get phoneHint => '01XXXXXXXXX';

  @override
  String get emailHint => 'ziyad@gmail.com';

  @override
  String get appointmentConfirmedTitle => 'Appointment Confirmed!';

  @override
  String get appointmentConfirmedSubtitle =>
      'Your donation appointment has been successfully scheduled';

  @override
  String get whatsNextTitle => 'What\'s Next:';

  @override
  String get nextStepEmail => 'You\'ll receive a confirmation email';

  @override
  String get nextStepReminder => 'We\'ll send you a reminder 24 hours before';

  @override
  String get nextStepId => 'Bring a valid ID on the day of donation';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get addToCalendar => 'Add to calendar';

  @override
  String get scheduleDonationTitle => 'Schedule Donation';

  @override
  String scheduleStepCounter(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String get locationLabel => 'Location';

  @override
  String get whenLabel => 'When';

  @override
  String get chooseBloodType => 'Choose a Blood Type';

  @override
  String get wholeBlood => 'Whole Blood';

  @override
  String get plasma => 'Plasma';

  @override
  String get platelets => 'Platelets';

  @override
  String get doubleRedCells => 'Double Red Cells';

  @override
  String get noteMessage =>
      'Note: Appointments are typically available 24-48 hours in advance. Walk-ins are welcome during business hours.';

  @override
  String get location => 'Location';

  @override
  String get dateTime => 'Date & Time';

  @override
  String get donationType => 'Donation Type';

  @override
  String get contactInfo => 'Contact Information';

  @override
  String get notSelected => 'Not selected';

  @override
  String get noEmail => 'no email';

  @override
  String get noPhone => 'no phone';

  @override
  String get chooseTimeSlot => 'Choose a time slot';

  @override
  String get confirmResponse => 'Confirm Response';

  @override
  String get emergencyRequestQuestion =>
      'Are you available to respond to this emergency blood request?';

  @override
  String get acceptButton => 'Accept - I Can Help';

  @override
  String get declineButton => 'Decline - Not Available';

  @override
  String get donationStatus => 'Donation Status';

  @override
  String get nextDonationReady => 'Next donation: Ready now';

  @override
  String get donor => 'Donor';

  @override
  String get whatHappensNext => 'What happens next:';

  @override
  String get hospitalNotified => 'Hospital will be notified of your response';

  @override
  String get directionsAndContact =>
      'You\'ll receive directions and contact details';

  @override
  String get arriveOnTime => 'Please arrive within the estimated time';

  @override
  String get urgentRequests => 'Urgent Requests';

  @override
  String get active => 'Active';

  @override
  String get donateNow => 'Donate Now';

  @override
  String get respond => 'Respond';

  @override
  String welcomeBack(Object name) {
    return 'Welcome back, $name!';
  }

  @override
  String get readyToSaveLives => 'Ready to save lives today?';

  @override
  String get eligibleToDonate => 'Eligible to donate';

  @override
  String get donations => 'Donations';

  @override
  String get points => 'Points';

  @override
  String get livesSaved => 'Lives Saved';

  @override
  String get requestDetails => 'Request Details';

  @override
  String get posted => 'Posted';

  @override
  String get patientType => 'Patient Type';

  @override
  String get contact => 'Contact';

  @override
  String get iCanHelpRespondNow => 'I Can Help - Respond Now';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get whyYourResponseMatters => 'Why Your Response Matters';

  @override
  String get responseMattersDescription =>
      'Your blood type matches this urgent request. Your quick response could save a life. The patient needs 3 units of O+ blood for emergency surgery.';

  @override
  String get bloodTypeNeeded => 'Blood Type Needed';

  @override
  String get urgentRequestActive => 'Urgent Request Active';

  @override
  String get unitsNeeded => 'Units Needed';

  @override
  String get distance => 'Distance';

  @override
  String get openInMap => 'Open in Map';

  @override
  String get mapView => 'Map View';

  @override
  String get emergencyRequest => 'Emergency Request';

  @override
  String get criticalRequest => 'Critical Request';

  @override
  String get emergency => 'EMERGENCY';

  @override
  String get critical => 'CRITICAL';

  @override
  String get units => 'units';

  @override
  String get home => 'Home';

  @override
  String get find => 'Find';

  @override
  String get donate => 'Donate';

  @override
  String get rewards => 'Rewards';

  @override
  String get profile => 'Profile';

  @override
  String get notifications_title => 'Notifications';

  @override
  String notifications_unread(Object unreadCount) {
    return '$unreadCount unread';
  }

  @override
  String get mark_all_as_read => 'Mark All as Read';

  @override
  String get respond_now => 'Respond Now';

  @override
  String get findHospitals => 'Find Hospitals';

  @override
  String get searchHint => 'Search by name or location..';

  @override
  String hospitalsNearby(Object count) {
    return '$count hospitals nearby';
  }

  @override
  String hospitalsFound(Object count) {
    return '$count Hospitals Found';
  }

  @override
  String get sortByDistance => 'Sort By Distance';

  @override
  String get contactHospital => 'Contact Hospital';

  @override
  String get callNow => 'Call Now';

  @override
  String get sendMessage => 'Send Message';

  @override
  String get cancel => 'cancel';

  @override
  String get donationMessage => 'Hello, I want to donate blood';

  @override
  String get available => 'Available';

  @override
  String distanceKm(Object distance) {
    return '$distance km';
  }

  @override
  String urgentNeeds(Object count) {
    return '$count urgent needs';
  }

  @override
  String hospitalType(Object type) {
    return 'Type: $type';
  }

  @override
  String get navigateToHospital => 'Navigate to Hospital';

  @override
  String distanceAway(Object distance) {
    return '$distance km away';
  }

  @override
  String get openInGoogleMap => 'Open in Google Map';

  @override
  String get openInAppleMap => 'Open in Apple Map';

  @override
  String get navigate => 'Navigate';
}
