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

  @override
  String get donor_login_title => 'Donor Access';

  @override
  String get donor_login_subtitle => 'LifeLink Blood Donation';

  @override
  String get donor_login_card_title => 'Login to Your Account';

  @override
  String get donor_email => 'Email Address';

  @override
  String get donor_password => 'Password';

  @override
  String get donor_forget_password => 'Forgot Password?';

  @override
  String get donor_login_button => 'Login';

  @override
  String get donor_dont_have_account => 'Don\'t have an account?';

  @override
  String get donor_register_now => 'Register Now';

  @override
  String get donor_register_title => 'Create Donor Account';

  @override
  String get full_name => 'Full Name';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get donor_blood_type => 'Blood Type';

  @override
  String get donor_select_blood_type => 'Select blood type';

  @override
  String get donor_location => 'Location';

  @override
  String get city_state => 'City, State';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get already_have_account => 'Already have Account?';

  @override
  String get donor_forget_password_title => 'Donor Reset Password';

  @override
  String get donor_forget_password_text =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get donor_send_reset_link => 'Send Reset Link';

  @override
  String get donor_back_to_login => 'Back To Login';

  @override
  String get please_enter_email => 'Please Enter Email';

  @override
  String get please_enter_password => 'Please Enter Password';

  @override
  String get please_enter_fullname => 'Please Enter Full Name';

  @override
  String get please_enter_phone => 'Please Enter Phone Number';

  @override
  String get please_confirm_password => 'Please Confirm Password';

  @override
  String get please_enter_location => 'Please Enter Location';

  @override
  String get please_enter_hospital_id => 'Please Enter Hospital ID';

  @override
  String get please_enter_official_email =>
      'Please Enter Official Email Address';

  @override
  String get please_enter_secure_password => 'Please Enter Secure Password';

  @override
  String get please_enter_admin_access_key => 'Please Enter Admin Access Key';

  @override
  String get please_enter_admin_email => 'Please Enter Administrator Email';

  @override
  String get hospital_portal => 'Hospital/Patient Portal';

  @override
  String get authorized_access_only => 'Authorized Access Only';

  @override
  String get secure_login => 'Secure Login';

  @override
  String get hospital_patient_authentication =>
      'Hospital/Patient Authentication';

  @override
  String get hospital_id => 'Hospital ID';

  @override
  String get official_email => 'Official Email Address';

  @override
  String get secure_password => 'Secure Password';

  @override
  String get new_hospital_patient => 'New Hospital or Patient?';

  @override
  String get hospital_contact_text_1 => 'Contact our Administration Team at: ';

  @override
  String get hospital_contact_text_2 =>
      ' to register your facility or request access';

  @override
  String get admin_portal => 'Administrator Portal';

  @override
  String get system_management_access => 'System Management Access';

  @override
  String get restricted_access_area => 'Restricted Access Area';

  @override
  String get admin_authentication => 'Admin Authentication';

  @override
  String get admin_access_key => 'Admin Access Key';

  @override
  String get admin_email => 'Administrator Email';

  @override
  String get secure_admin_login => 'Secure Admin Login';

  @override
  String get security_notice => 'Security Notice:';

  @override
  String get security_notice_desc =>
      'All admin login attempts are logged and monitored. Unauthorized access attempts will be reported to system security.';

  @override
  String get need_access => 'Need Access?';

  @override
  String get contact_system_admin => 'Contact the System Administrator at:';

  @override
  String get emailIsRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get passwordIsRequired => 'Password is required';

  @override
  String get enterValidPassword => 'Enter a valid password';

  @override
  String get phoneIsRequired => 'Phone number is required';

  @override
  String get enterValidPhone => 'Enter a valid Egyptian phone number';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get enterValidName => 'Enter a valid name';

  @override
  String get locationIsRequired => 'Location is required';

  @override
  String get enterValidLocation => 'Enter a valid location';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get readyToDonateTitle => 'Ready to Donate';

  @override
  String get readyToDonateSubtitle => 'Every donation can save up to 3 lives';

  @override
  String get donationTip1 => 'Get a good night\'s sleep (7-8 hours)';

  @override
  String get donationTip2 => 'Eat a healthy meal 2-3 hours before';

  @override
  String get donationTip3 => 'Drink plenty of water (3-4 glasses)';

  @override
  String get donationTip4 => 'Avoid fatty foods before donation';

  @override
  String get donationTip5 => 'Bring a valid photo ID';

  @override
  String get donationTip6 => 'Wear comfortable clothing';

  @override
  String get scheduleDonation => 'Schedule Donation';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get pending => 'Pending';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get appointmentCancelled => 'Appointment cancelled';

  @override
  String get rescheduleAppointmentTitle => 'Reschedule Appointment';

  @override
  String get rescheduleAppointmentMessage =>
      'Would you like to reschedule your donation appointment?';

  @override
  String get chooseNewDateTime => 'Choose New Date & Time';

  @override
  String get cancelDonation => 'Cancel Donation';

  @override
  String get upcomingAppointments => 'Upcoming Appointments';

  @override
  String get eligibleTitle => 'You\'re Eligible to Donate';

  @override
  String get eligibleDescription =>
      'You meet all eligibility requirements for blood donation.';

  @override
  String get faqQuestion1 => 'Does donating blood hurt?';

  @override
  String get faqAnswer1 => 'No, donating blood is a painless process.';

  @override
  String get faqQuestion2 => 'How long does the donation process take?';

  @override
  String get faqAnswer2 =>
      'The donation process typically takes about 30-45 minutes.';

  @override
  String get faqQuestion3 => 'When can I donate again?';

  @override
  String get faqAnswer3 => 'You can donate again after 8 weeks.';

  @override
  String get faqQuestion4 => 'What if I feel faint during donation?';

  @override
  String get faqAnswer4 => 'If you feel faint, let the staff know immediately.';

  @override
  String get whatToExpect => 'What to Expect';

  @override
  String get instructionStep1Title => 'Registration & Health Check';

  @override
  String get instructionStep1Subtitle =>
      'Quick medical history and vital signs check';

  @override
  String get instructionStep2Title => 'Donation Process';

  @override
  String get instructionStep2Subtitle =>
      'Comfortable seating while you donate (30-45 min)';

  @override
  String get instructionStep3Title => 'Rest & Refreshments';

  @override
  String get instructionStep3Subtitle =>
      'Relax with snacks and drinks before you go';

  @override
  String get eligibilityRequirementsTitle => 'Eligibility Requirements';

  @override
  String get reqAge => 'Age: 18–65';

  @override
  String get reqWeight => 'Minimum weight 50 kg';

  @override
  String get reqLastDonation => 'At least 3 months since last donation';

  @override
  String get reqNoIllness => 'No recent illness';

  @override
  String get reqNoTattoos => 'No recent tattoos or piercings';
}
