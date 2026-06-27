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
  String get timeSlotTime => 'Time';

  @override
  String get timeSlotCapacity => 'Capacity';

  @override
  String timeSlotRemainingCapacity(Object remaining, Object total) {
    return '$remaining/$total slots available';
  }

  @override
  String get timeSlotMaxCapacity => 'Max Slots';

  @override
  String get timeSlotAvailable => 'Available';

  @override
  String get timeSlotFull => 'Full';

  @override
  String get timeSlotSlot => 'slot';

  @override
  String get timeSlotSlots => 'slots';

  @override
  String timeSlotBookedLabel(Object time, Object remaining, Object max) {
    return '$time - $remaining/$max available';
  }

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
  String responseMattersDescription(
    Object units,
    Object bloodType,
    Object reason,
  ) {
    return 'Your blood type matches this urgent request. Your quick response could save a life. The patient needs 3 units of O+ blood for emergency surgery.';
  }

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
  String get userDetails => 'User Details';

  @override
  String get userDetailsSubtitle => 'View and manage user details and actions.';

  @override
  String get adminRole => 'Admin Role';

  @override
  String get systemAdministrator => 'System Administrator';

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
  String get adminActions => 'Admin Actions';

  @override
  String get suspendUser => 'Suspend User';

  @override
  String get verifyUser => 'Verify User';

  @override
  String get hello => 'Hello';

  @override
  String get iNeedToContactYouRegardingYourAccount =>
      'I need to contact you regarding your account.';

  @override
  String get delete => 'Delete';

  @override
  String get deleteUser => 'Delete User';

  @override
  String get deleteUserConfirm => 'Are you sure you want to delete this user?';

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
  String get donor_pin_verification_title => 'Verify code';

  @override
  String get donor_pin_verification_subtitle =>
      'Enter your 6-digit code to continue.';

  @override
  String get donor_pin_verification_invalid_pin =>
      'Please enter the full 6-digit code.';

  @override
  String get donor_resend_code => 'Resend code';

  @override
  String get donor_resending_code => 'Resending code...';

  @override
  String get donor_code_resent_success => 'Verification code resent';

  @override
  String get donor_code_resent_error => 'Unable to resend verification code';

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
  String get nameIsRequired => 'Name is required';

  @override
  String get weightIsRequired => 'Weight is required';

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

  @override
  String minutesAgo(Object count) {
    return '$count min ago';
  }

  @override
  String hoursAgo(Object count) {
    return '$count h ago';
  }

  @override
  String daysAgo(Object count) {
    return '$count d ago';
  }

  @override
  String get gettingDistance => 'Getting distance...';

  @override
  String get km => 'km';

  @override
  String kmAway(Object distance) {
    return '$distance km away';
  }

  @override
  String get hospitalLocation => 'Hospital Location';

  @override
  String get loadingMap => 'Loading map...';

  @override
  String get oopsError => 'Oops! Something went wrong';

  @override
  String get goBack => 'Go Back';

  @override
  String get bloodDonationCenter => 'Blood Donation Center';

  @override
  String get directions => 'Directions';

  @override
  String shareMessage(Object lat, Object link, Object lng) {
    return '🩸 LifeLink - Blood Donation Center\n\n📍 Location:\n$lat, $lng\n\n🗺 View on Google Maps:\n$link\n\nBe a hero. Donate blood. Save lives ❤️';
  }

  @override
  String get protectYourAccount => 'Protect Your Account';

  @override
  String get twoFactorDescription =>
      'Add an extra layer of security by enabling two-factor authentication.';

  @override
  String get twoFactorSecurityInfo =>
      'Enabling 2FA significantly reduces the risk of unauthorized access, even if your password is compromised.';

  @override
  String get smsVerification => 'SMS Verification';

  @override
  String get smsVerificationDescription => 'Receive a code via text message';

  @override
  String get authenticatorApp => 'Authenticator App';

  @override
  String get authenticatorAppDescription => 'Use Google Authenticator or Authy';

  @override
  String get emailVerification => 'Email Verification';

  @override
  String get emailVerificationDescription => 'Receive a code via email';

  @override
  String get setupTitle => 'Set Up';

  @override
  String get twoFactorAuthTitle => 'Two-Factor Authentication';

  @override
  String get verificationMethods => 'Verification Methods';

  @override
  String get infoBoxText =>
      'Enabling 2FA significantly reduces the risk of unauthorized access, even if your password is compromised.';

  @override
  String get smsVerificationTitle => 'SMS Verification';

  @override
  String get smsVerificationSubtitle => 'Receive a code via text message';

  @override
  String get authAppTitle => 'Authenticator App';

  @override
  String get authAppSubtitle => 'Use Google Authenticator or Authy';

  @override
  String get emailVerificationTitle => 'Email Verification';

  @override
  String get emailVerificationSubtitle => 'Receive a code via email';

  @override
  String get setupTitleSms => 'Set Up SMS Verification';

  @override
  String get setupTitleApp => 'Set Up Authenticator App';

  @override
  String get setupTitleEmail => 'Set Up Email Verification';

  @override
  String get setupDescSms =>
      'A 6-digit code will be sent to your registered phone number each time you log in.';

  @override
  String get setupDescApp =>
      'Use an authenticator app like Google Authenticator or Authy to generate time-based codes.';

  @override
  String get setupDescEmail =>
      'A verification link or code will be sent to your registered email address.';

  @override
  String get donationHistory => 'Donation History';

  @override
  String get viewAll => 'View All';

  @override
  String get blood => 'Blood';

  @override
  String get completed => 'Completed';

  @override
  String get passwordAndSecurity => 'Password & Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get twoFactorAuthentication => 'Two Factor Authentication';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get fullName => 'Full Name';

  @override
  String get bloodType => 'Blood Type';

  @override
  String get settings => 'Settings';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsDesc => 'Receive notifications for requests';

  @override
  String get emergencyAlerts => 'Emergency Alerts';

  @override
  String get emergencyAlertsDesc => 'Urgent blood requests nearby';

  @override
  String get privacyAndSecurity => 'Privacy & Security';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get changePasswordDescription =>
      'Enter your current password and a new password to update your account.';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String donorLabel(Object bloodType) {
    return '$bloodType Donor';
  }

  @override
  String get total => 'Total';

  @override
  String get earned => 'Earned';

  @override
  String get totalDonations => 'total donations';

  @override
  String get pdfViewer => 'PDF Viewer';

  @override
  String get loadingPdf => 'Loading PDF...';

  @override
  String pageOf(Object current, Object total) {
    return 'Page $current of $total';
  }

  @override
  String get helpSubtitle => 'We\'re here to help';

  @override
  String get getHelp => 'Get Help';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get chatSupport => 'Chat with our support team';

  @override
  String get emailUs => 'Email Us';

  @override
  String get documentation => 'Documentation';

  @override
  String get userGuides => 'User guides and tutorials';

  @override
  String get emailBodyRequestDocumentation =>
      'I would like to request documentation on how to donate blood.';

  @override
  String get documentationRequestSubject => 'Documentation Request';

  @override
  String get whatsappHelpMessage => 'Hello, I need assistance';

  @override
  String get popularTopicsTitle => 'Popular Topics';

  @override
  String get topicDonateBlood => 'How to donate blood?';

  @override
  String get topicEligibility => 'Eligibility requirements';

  @override
  String get topicEarnPoints => 'How to earn points?';

  @override
  String get topicEmergencies => 'Responding to emergencies';

  @override
  String get aboutTitle => 'About LifeLink';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutLastUpdated => 'Last Updated';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get faqHowToDonate => 'How do I donate blood?';

  @override
  String get faqHowToDonateAnswer =>
      'To donate blood, find a nearby donation center through the app, schedule an appointment, and make sure you meet the eligibility requirements. Stay hydrated and eat a healthy meal before donating.';

  @override
  String get faqEligibility => 'What are the eligibility requirements?';

  @override
  String get faqEligibilityAnswer =>
      'You must be at least 17 years old, weigh at least 50 kg, be in good general health, and not have donated blood in the last 56 days. Certain medical conditions or medications may affect eligibility.';

  @override
  String get faqEarnPoints => 'How do I earn reward points?';

  @override
  String get faqEarnPointsAnswer =>
      'You earn points each time you donate blood, refer a friend, complete your profile, or respond to emergency requests. Points can be redeemed for rewards in the app.';

  @override
  String get faqDonationFrequency => 'How often can I donate blood?';

  @override
  String get faqDonationFrequencyAnswer =>
      'Whole blood can be donated every 56 days (8 weeks). Platelets can be donated every 7 days, up to 24 times per year. Plasma can be donated every 28 days.';

  @override
  String get faqBeforeDonation => 'What should I do before donating?';

  @override
  String get faqBeforeDonationAnswer =>
      'Drink plenty of water, eat a healthy meal, avoid fatty foods, get a good night\'s sleep, and wear comfortable clothing with sleeves that can be rolled up easily.';

  @override
  String get faqEmergencyResponse => 'How do I respond to emergency requests?';

  @override
  String get faqEmergencyResponseAnswer =>
      'When an emergency request matches your blood type, you will receive a push notification. Tap on it to view the details and confirm your availability to donate.';

  @override
  String get faqChangeBloodType => 'How do I change my blood type?';

  @override
  String get faqChangeBloodTypeAnswer =>
      'Go to your profile settings and tap on \"Edit Profile\". You can update your blood type there. Make sure to verify with your actual medical records.';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get editProfileDescription =>
      'Make changes to your profile here. Click save when you\'re done.';

  @override
  String get name => 'Name';

  @override
  String get saving => 'Saving...';

  @override
  String get weight => 'Weight';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get age => 'Age';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get gender => 'Gender';

  @override
  String get save => 'Save';

  @override
  String get thanksHero => 'Thank You for Being a Hero! 🎉';

  @override
  String thanksHeroDesc(Object donationsCount, Object livesSaved) {
    return 'Your $donationsCount donations have helped save approximately $livesSaved lives. Every donation makes a difference!';
  }

  @override
  String get logout => 'Logout';

  @override
  String get rewards_and_achievements => 'Rewards & Achievements';

  @override
  String get your_points => 'Your Points';

  @override
  String get next_reward => 'Next Reward';

  @override
  String get points_to_go => 'pts to go';

  @override
  String get badges => 'Badges';

  @override
  String get forget_password_success => 'Verification code sent to your email';

  @override
  String get success => 'Success';

  @override
  String get rewards_redeemed => 'Rewards Redeemed';

  @override
  String get you_have_successfully_redeemed =>
      'You have successfully redeemed your reward';

  @override
  String get close => 'Close';

  @override
  String get redeem_reward => 'Redeem Reward';

  @override
  String get are_you_sure_you_want_to_redeem =>
      'Are you sure you want to redeem this reward?';

  @override
  String get redeem => 'Redeem';

  @override
  String get badge_unlocked => 'Unlocked';

  @override
  String get not_enough_points =>
      'You don\'t have enough points to redeem this reward';

  @override
  String get redeem_points => 'Redeem Points';

  @override
  String get coffee_voucher => 'Coffee Voucher';

  @override
  String get movie_tickets => 'Movie Tickets';

  @override
  String get restaurant_gift_card => 'Restaurant Gift Card';

  @override
  String get health_check_up => 'Health Check-Up';

  @override
  String get premium_badge => 'Premium Badge';

  @override
  String get gym_membership => 'Gym Membership';

  @override
  String get soon => 'Soon';

  @override
  String get points_history => 'Points History';

  @override
  String get blood_donation => 'Blood Donation';

  @override
  String get emergency_response => 'Emergency Response';

  @override
  String get week_1_ago => '1 week ago';

  @override
  String get profile_completion => 'Profile Completion';

  @override
  String get weeks_2_ago => '2 weeks ago';

  @override
  String get referral_bonus => 'Referral Bonus';

  @override
  String get weeks_3_ago => '3 weeks ago';

  @override
  String get how_to_earn_points => 'How To Earn Points?';

  @override
  String get donate_blood_points => 'Blood Donation: 200 pts';

  @override
  String get emergency_response_points => 'Emergency Response: 100 pts';

  @override
  String get refer_to_friends_points => 'Refer a Friend: 150 pts';

  @override
  String get complete_profile_points => 'Complete Profile: 50 pts';

  @override
  String get plasma_donation_points => 'Plasma Donation: 150 pts';

  @override
  String get platelets_donation_points => 'Platelet Donation: 175 pts';

  @override
  String get organ_donation_points => 'Organ Donation: 500 pts';

  @override
  String get first_donation_bonus_points => 'First Donation Bonus: 100 pts';

  @override
  String get your_badges => 'Your Badges';

  @override
  String get first_timer => 'First Timer';

  @override
  String get completed_first_donation => 'Completed your first donation';

  @override
  String get regular_donor => 'Regular Donor';

  @override
  String get donated_5_times => 'Donated 5 times';

  @override
  String get life_saver => 'Life Saver';

  @override
  String get donated_10_times => 'Donated 10 times';

  @override
  String get hero => 'Hero';

  @override
  String get donated_20_times => 'Donated 20 times';

  @override
  String get legend => 'Legend';

  @override
  String get donated_50_times => 'Donated 50 times';

  @override
  String get emergency_responder => 'Emergency Responder';

  @override
  String get responded_to_10_emergencies => 'Responded to 10 Emergencies';

  @override
  String get history => 'History';

  @override
  String get request => 'Request';

  @override
  String get blood_request_dashboard => 'Blood Request Dashboard';

  @override
  String get active_requests => 'Active Requests';

  @override
  String get responses_today => 'Responses Today';

  @override
  String get emergency_request => 'Emergency Request';

  @override
  String get emergency_description =>
      'Need blood urgently? Send immediate alerts to nearby donors.';

  @override
  String get create_emergency_request => 'Create Emergency Request';

  @override
  String get emergency_blood_request => 'Emergency Blood Request';

  @override
  String get emergency_blood_request_desc =>
      'Enter details for the emergency blood request.';

  @override
  String get blood_type => 'Blood Type';

  @override
  String get select_blood_type => 'Select Blood Type';

  @override
  String get units_needed => 'Units Needed';

  @override
  String get enter_units_needed => 'Enter number of units needed';

  @override
  String get urgency => 'Urgency';

  @override
  String get select_urgency => 'Select Urgency Level';

  @override
  String get submit_request => 'Submit Request';

  @override
  String get urgency_low => 'Low';

  @override
  String get urgency_medium => 'Medium';

  @override
  String get urgency_high => 'High';

  @override
  String get recent_activity => 'Recent Activity';

  @override
  String get privacy_Security => 'Privacy & Security';

  @override
  String get mange_your_privacy_settings => 'Manage your privacy settings';

  @override
  String get all_blood_type => 'All Blood Types';

  @override
  String get clear_filters => 'Clear Filters';

  @override
  String get female => 'Female';

  @override
  String get male => 'Male';

  @override
  String get view_details => 'View Details';

  @override
  String get contact_donors => 'Contact Donors';

  @override
  String responses(Object count) {
    return '$count responses';
  }

  @override
  String hours_ago(Object count) {
    return '$count hours ago';
  }

  @override
  String unit_needed(Object count) {
    return '$count units needed';
  }

  @override
  String time_left(Object count) {
    return '$count hours left';
  }

  @override
  String get time_left_label => 'Time Left';

  @override
  String get response => 'Response';

  @override
  String donors_have_responded(Object count) {
    return '$count donors have responded';
  }

  @override
  String units_needed_count(Object count) {
    return '$count units needed';
  }

  @override
  String get request_details => 'Request Details';

  @override
  String get request_details_desc => 'Details of the emergency blood request';

  @override
  String get contact_donor => 'Contact Donor';

  @override
  String get contact_donor_desc =>
      'Available donors matching your blood request';

  @override
  String get request_for => 'Request for';

  @override
  String get message => 'Message';

  @override
  String get hospital_message =>
      'Hello, I am representing a hospital in need of blood and I would like to discuss how you can help.';

  @override
  String available_donors(Object count) {
    return 'Available Donors($count)';
  }

  @override
  String get nearby_donor => 'Nearby Donors (5km radius)';

  @override
  String get change_location => 'Change Location';

  @override
  String get change_location_desc => 'Enter your new location:';

  @override
  String get address => 'Address';

  @override
  String get city => 'City';

  @override
  String get state => 'State';

  @override
  String get zip_code => 'Zip Code';

  @override
  String get enter_address => 'Enter your address';

  @override
  String get enter_city => 'Enter your city';

  @override
  String get enter_state => 'Enter your state';

  @override
  String get enter_zip_code => 'Enter your zip code';

  @override
  String donor_available(Object distance) {
    return '$distance km away';
  }

  @override
  String get donors => 'Donors';

  @override
  String get allUsers => 'All';

  @override
  String get complete => 'Complete';

  @override
  String get find_donors => 'Find Donors';

  @override
  String get find_donors_dec => 'Search for available blood donors';

  @override
  String get inactive => 'Inactive';

  @override
  String get call => 'Call';

  @override
  String emergency_whatsapp_message(Object bloodType, Object name) {
    return 'Hello $name, there is an emergency case that needs blood type $bloodType. Can you help?';
  }

  @override
  String get note => 'Note';

  @override
  String get note_dec =>
      'Please be respectful of donor\'s time and availability when reaching out.';

  @override
  String get send_request => 'Send Request';

  @override
  String donors_found(Object count) {
    return '$count Donors found';
  }

  @override
  String get create_request => 'Blood Request';

  @override
  String get create_request_dec => 'Create a new blood donation request';

  @override
  String get alerts_message =>
      'This will send immediate alerts to all nearby donors matching your blood type requirement. Use only for critical emergencies.';

  @override
  String get patient_details => 'Patient Details';

  @override
  String get enter_patient_details =>
      'Enter details about the patient in need of blood';

  @override
  String get blood_type_needed => 'Blood Type Needed';

  @override
  String get confirm_donation => 'Confirm Donation';

  @override
  String get generate_donation_qr => 'Generate Donation QR';

  @override
  String get qr_valid_message =>
      'This QR code is valid for 5 minutes and can only be used once';

  @override
  String get time_remaining => 'Time Remaining';

  @override
  String get qr_expiry_warning => 'This QR code can only be used once';

  @override
  String get total_points => 'Total Points';

  @override
  String get next_milestone => 'Next Milestone';

  @override
  String points_until_milestone(Object milestone, Object points) {
    return '$points points until $milestone';
  }

  @override
  String get locked => 'Locked';

  @override
  String get achievement_badges => 'Achievement Badges';

  @override
  String get upcoming_rewards => 'Upcoming Rewards';

  @override
  String get gold_badge_reward => '🎁 Gold Badge: Priority donation scheduling';

  @override
  String get platinum_badge_reward =>
      '🏆 Platinum Badge (5,000 pts): Exclusive merchandise';

  @override
  String get confirm_donation_title => 'Confirm your donation';

  @override
  String get confirm_donation_desc =>
      'Scan the hospital QR code to confirm your blood donation and earn points.';

  @override
  String get scan_qr_code => 'Scan QR Code';

  @override
  String get points_short => 'pts';

  @override
  String get bronze_donor => 'Bronze Donor';

  @override
  String get silver_donor => 'Silver Donor';

  @override
  String get gold_donor => 'Gold Donor';

  @override
  String get no_badge => 'New Donor';

  @override
  String get scan_donation_qr => 'Scan Donation QR';

  @override
  String get confirm_donation_qr_desc =>
      'Confirm your donation with hospital QR code';

  @override
  String get how_it_works => 'How it works?';

  @override
  String get step_visit_hospital =>
      'Visit the hospital or blood donation center';

  @override
  String get step_request_qr => 'Request the donation QR code from staff';

  @override
  String get step_start_scanning => 'Tap \"Start Scanning\" below';

  @override
  String get step_point_camera => 'Point your camera at the QR code';

  @override
  String get step_wait_confirmation => 'Wait for confirmation';

  @override
  String get camera_scanner => 'Camera Scanner';

  @override
  String get camera_ready => 'Camera Ready';

  @override
  String get tap_to_start => 'Tap button below to start';

  @override
  String get scan_qr_description =>
      'Scan the QR code provided by the hospital to confirm your donation.';

  @override
  String get start_scanning => 'Start Scanning';

  @override
  String get security_notice_message =>
      'Only scan QR codes provided directly by verified hospital staff. Never scan codes from untrusted sources.';

  @override
  String get recent_confirmations => 'Recent Confirmations';

  @override
  String get donationConfirmedTitle => 'Donation Confirmed!';

  @override
  String get donationConfirmedMessage =>
      'Your blood donation has been successfully verified';

  @override
  String get youEarned => 'You Earned';

  @override
  String get statusLabel => 'Status:';

  @override
  String get donationDetails => 'Donation Details';

  @override
  String get dateLabel => 'Date:';

  @override
  String get view_points => 'View Points';

  @override
  String get align_qr_frame => 'Align the QR code inside the frame';

  @override
  String camera_error(Object error) {
    return 'Camera error: $error';
  }

  @override
  String get diamond_donor => 'Diamond Donor';

  @override
  String get donation_thank_you =>
      'Thank you for saving lives! Your contribution has been recorded in your donation history.';

  @override
  String get typeLabel => 'Type:';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get securitySettings => 'Security Settings';

  @override
  String get securityInfo =>
      'Keep your account secure by regularly updating your password and enabling two-factor authentication.';

  @override
  String get enterCurrentPassword => 'Enter current password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get confirmNewPasswordHint => 'Confirm new password';

  @override
  String get twoFactorAuth => 'Two-Factor Authentication';

  @override
  String get extraSecurityLayer => 'Add extra security layer';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get notificationPreferences => 'Notification Preferences';

  @override
  String get receiveMobileNotifications => 'Receive mobile notifications';

  @override
  String get criticalDonorResponses => 'Critical donor responses';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get updatesViaEmail => 'Updates via email';

  @override
  String get smsAlerts => 'SMS Alerts';

  @override
  String get textMessageUpdates => 'Text message updates';

  @override
  String get savePreferences => 'Save Preferences';

  @override
  String get hospitalName => 'Hospital Name';

  @override
  String get department => 'Department';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get hospitalProfile => 'Hospital Profile';

  @override
  String get manageHospitalInformation => 'Manage hospital information';

  @override
  String get emergencyDepartment => 'Emergency Department';

  @override
  String get edit => 'Edit';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get accountStatistics => 'Account Statistics';

  @override
  String get totalRequests => 'Total Requests';

  @override
  String get fulfilled => 'Fulfilled';

  @override
  String get successRate => 'Success Rate';

  @override
  String get requestHistory => 'Request History';

  @override
  String get trackBloodRequests => 'Track your blood requests';

  @override
  String get recentRequests => 'Recent Requests';

  @override
  String get bloodRequest => 'Blood Request';

  @override
  String get viewDetails => 'View Details';

  @override
  String get high => 'High';

  @override
  String get low => 'Low';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get users => 'Users';

  @override
  String get requests => 'Requests';

  @override
  String get analytics => 'Analytics';

  @override
  String get analyticsSubtitle => 'Data insights and trends';

  @override
  String get growthRate => 'Growth Rate';

  @override
  String get monthlyTrend => 'Monthly Trend';

  @override
  String get aiPredictions => 'AI Predictions';

  @override
  String get aiPrediction1 =>
      'AI predicts a 20% increase in donor turnout next month.';

  @override
  String get aiPrediction2 =>
      'AI identifies a potential shortage of O- blood type in the next 2 weeks.';

  @override
  String get aiPrediction3 =>
      'AI forecasts a 15% growth in successful donations over the next quarter.';

  @override
  String get topic_create_request => 'How to create blood request?';

  @override
  String get topic_qr_code => 'How to generate QR code for blood request?';

  @override
  String get topic_history => 'How to view donation history?';

  @override
  String get topic_contact => 'How to contact support?';

  @override
  String get topic_update_profile => 'How to update hospital profile?';

  @override
  String get faqHowToCreateRequest => 'How to create a blood request?';

  @override
  String get faqHowToCreateRequestAnswer =>
      'Go to the requests section, tap on \'Create Request\', fill in the required details like blood type, quantity, and location, then submit the request.';

  @override
  String get faqQrCode => 'How to generate a QR code for a blood request?';

  @override
  String get faqQrCodeAnswer =>
      'After creating a blood request, open the request details and tap on \'Generate QR Code\' to create and share it.';

  @override
  String get faqHistory => 'How to view donation history?';

  @override
  String get faqHistoryAnswer =>
      'Navigate to the history section from your profile to see all previous donations and requests.';

  @override
  String get faqContact => 'How to contact support?';

  @override
  String get faqContactAnswer =>
      'Go to the Help & Support section and choose \'Contact Us\' to reach out via email or phone.';

  @override
  String get faqUpdateProfile => 'How to update hospital profile?';

  @override
  String get faqUpdateProfileAnswer =>
      'Open your profile settings, update the required information, and tap \'Save\' to apply the changes.';

  @override
  String get requestDetailsSubtitle =>
      'View detailed information about the blood request.';

  @override
  String get unitsRequested => 'Units Requested';

  @override
  String get urgencyLevel => 'Urgency Level';

  @override
  String get donorsContacted => 'Donors Contacted';

  @override
  String get donorsConfirmed => 'Donors Confirmed';

  @override
  String get completionTime => 'Completion Time';

  @override
  String hours(Object count) {
    return '$count hours';
  }

  @override
  String get requestNoteDescription =>
      'All blood request records are maintained for audit and compliance purposes.';

  @override
  String get medium => 'Medium';

  @override
  String get notFulfilled => 'Not Fulfilled';

  @override
  String unitsCount(Object count) {
    return '$count units';
  }

  @override
  String get pdfLoadError => 'Failed to load PDF. Please try again later.';

  @override
  String get retry => 'Retry';

  @override
  String get loadMore => 'Load More';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get dashboardSubtitle => 'System overview and analytics';

  @override
  String get criticalAlerts => 'Critical Alerts';

  @override
  String get alertBloodShortage => 'O- blood shortage at City Hospital';

  @override
  String get alertHighDemand => 'AI prediction: High demand for A+ expected';

  @override
  String get alertEmergency =>
      'Mass casualty event - Multiple blood types needed';

  @override
  String get system => 'System';

  @override
  String get bloodTypeDistribution => 'Blood Type Distribution';

  @override
  String units_count(Object count) {
    return '$count units';
  }

  @override
  String get aiInsights => 'AI Insights';

  @override
  String get predictedHighDemand => 'Predicted High Demand';

  @override
  String get predictedHighDemandDesc =>
      'A+ and O+ blood types expected to be in high demand next week';

  @override
  String get shortageRisk => 'Shortage Risk';

  @override
  String get shortageRiskDesc =>
      'AB- blood type showing low donor availability in downtown area';

  @override
  String confidencePercentage(Object value) {
    return '$value% confidence';
  }

  @override
  String get systemOnline => 'System Online';

  @override
  String get weeklyTrends => 'Weekly Trends';

  @override
  String get allTopDonors => 'All Top Donors';

  @override
  String get allTopDonorsSubtitle =>
      'View all top donors and their contribution history.';

  @override
  String get lastDonation => 'Last donation';

  @override
  String get top_donors_in_month => 'Top donors in the month';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get sendEmergencyBroadcast => 'Send Emergency Broadcast';

  @override
  String get alertDetails => 'Alert Details';

  @override
  String get alertDetailsSubtitle =>
      'View detailed information about this alert.';

  @override
  String get totalDonors => 'Total Donors';

  @override
  String get activeRequests => 'Active Requests';

  @override
  String get criticalCases => 'Critical Cases';

  @override
  String get successfulDonations => 'Successful Donations';

  @override
  String get just_now => 'just now';

  @override
  String minutes_ago(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String days_ago(Object days) {
    return '$days days ago';
  }

  @override
  String get hospitals => 'Hospitals';

  @override
  String get admins => 'Admins';

  @override
  String get userManagement => 'User Management';

  @override
  String get manageUsersSubtitle =>
      'Manage donors, hospitals, and administrators';

  @override
  String get noUsersFound => 'No users found';

  @override
  String get recentUsers => 'Recent Users';

  @override
  String get addHospital => 'Add Hospital';

  @override
  String get addHospitalSubtitle => 'Add a new hospital to the system.';

  @override
  String get type => 'Type';

  @override
  String get selectHospitalType => 'Select hospital type';

  @override
  String get governmentHospital => 'Government Hospital';

  @override
  String get privateHospital => 'Private Hospital';

  @override
  String get specializedHospital => 'Specialized Hospital';

  @override
  String get communityHospital => 'Community Hospital';

  @override
  String get medicalCenter => 'Medical Center';

  @override
  String get enterHospitalName => 'Enter hospital name';

  @override
  String get enterHospitalEmail => 'Enter hospital email';

  @override
  String get enterHospitalContactNumber => 'Enter hospital contact number';

  @override
  String get enterHospitalAddress => 'Enter hospital address';

  @override
  String get latitude => 'Latitude';

  @override
  String get enterHospitalLatitude => 'Enter hospital latitude';

  @override
  String get latitudeRangeError => 'Latitude must be between -90 and 90';

  @override
  String get longitude => 'Longitude';

  @override
  String get enterHospitalLongitude => 'Enter hospital longitude';

  @override
  String get longitudeRangeError => 'Longitude must be between -180 and 180';

  @override
  String get licenseNumber => 'License Number';

  @override
  String get enterHospitalLicenseNumber => 'Enter hospital license number';

  @override
  String get adminContactName => 'Admin Contact Name';

  @override
  String get enterAdminContactName => 'Enter admin contact name';

  @override
  String get adminContactPhone => 'Admin Contact Phone';

  @override
  String get enterAdminContactPhone => 'Enter admin contact phone';

  @override
  String get emergencyContactNumber => 'Emergency Contact Number';

  @override
  String get enterEmergencyContactNumber => 'Enter emergency contact number';

  @override
  String get hospitalAddedSuccessfully => 'Hospital added successfully';

  @override
  String get totalUsers => 'Total Users';

  @override
  String get noTrendDataAvailable => 'No trend data available';

  @override
  String get verified => 'Verified';

  @override
  String get sendEmergencyBroadcastBtn => 'Send Emergency Broadcast';

  @override
  String get contactHospitalBtn => 'Contact Hospital';

  @override
  String get markAsFulfilledBtn => 'Mark as Fulfilled';

  @override
  String get cancelRequestBtn => 'Cancel Request';

  @override
  String get alertPrefix => 'Alert: ';

  @override
  String get alertCriticalMessage =>
      'This is a critical request. Consider sending an emergency broadcast to all nearby donors.';

  @override
  String get closeButton => 'Close';

  @override
  String get downTown => 'DownTown';

  @override
  String get eastSide => 'EastSide';

  @override
  String get westSide => 'WestSide';

  @override
  String hours_left(Object count) {
    return '$count hours left';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String get systemSettingsTitle => 'System Settings';

  @override
  String get systemSettingsSubtitle => 'Configure System Preferences';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get criticalBloodShortageNotifications =>
      'Critical blood shortage notifications';

  @override
  String get machineLearningDemandForecasts =>
      'Machine learning demand forecasts';

  @override
  String get roleBasedPermissions => 'Role-Based Permissions';

  @override
  String get viewAuditLogs => 'View Audit Logs';

  @override
  String get requiredForAllAdminAccounts => 'Required for all admin accounts';

  @override
  String get gpsAndLocation => 'GPS & Location';

  @override
  String get configureSearchRadius => 'Configure Search Radius';

  @override
  String get locationAccuracySettings => 'Location Accuracy Settings';

  @override
  String get systemHealth => 'System Health';

  @override
  String get systemHealthCheck => 'System Health Check';

  @override
  String get editAdminProfile => 'Edit Admin Profile';

  @override
  String get updateAdminProfileInfo =>
      'Update your administrator profile information.';

  @override
  String get enterFullName => 'Enter full name';

  @override
  String get enterEmailAddress => 'Enter email address';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get systemManagement => 'System Management';

  @override
  String get userSupport => 'User Support';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get security => 'Security';

  @override
  String get selectDepartment => 'Select Department';

  @override
  String get accessLevel => 'Access Level';

  @override
  String get selectAccessLevel => 'Select Access Level';

  @override
  String get pleaseSelectAccessLevel => 'Please select access level';

  @override
  String get fullAccess => 'Full Access';

  @override
  String get limitedAccess => 'Limited Access';

  @override
  String get viewOnly => 'View Only';

  @override
  String get adminAddedSuccessfully => 'Admin added successfully';

  @override
  String get bloodRequestsTitle => 'Blood Requests';

  @override
  String get bloodRequestsSubtitle => 'Monitor and manage all blood requests';

  @override
  String get criticalStatus => 'Critical';

  @override
  String get fulfilledToday => 'Fulfilled Today';

  @override
  String get unitsLabel => 'units';

  @override
  String get contactedLabel => 'contacted';

  @override
  String get confirmedLabel => 'confirmed';

  @override
  String get manageButton => 'Manage';

  @override
  String get manageRequestTitle => 'Manage Blood Request';

  @override
  String get manageRequestSubtitle =>
      'Manage the details and actions for this blood request.';

  @override
  String get bloodTypeLabel => 'Blood Type';

  @override
  String get unitsNeededLabel => 'Units Needed';

  @override
  String get donorsContactedLabel => 'Donors Contacted';

  @override
  String get donorsConfirmedLabel => 'Donors Confirmed';

  @override
  String get adminActionsTitle => 'Admin Actions';

  @override
  String get addAdmin => 'Add Admin';

  @override
  String get notePrefix => 'Note:';

  @override
  String get adminNoteMessage =>
      'Changes to your profile will be logged in the audit system and may require verification from another administrator.';

  @override
  String get pleasSelectDepartment => 'Please select a department';

  @override
  String get roleBasedPermissionsTitle => 'Role-Based Permissions';

  @override
  String get roleBasedPermissionsSubtitle =>
      'Configure access levels for different user roles.';

  @override
  String get adminPermissions => 'Admin Permissions';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get emergencyBroadcasts => 'Emergency Broadcasts';

  @override
  String get hospitalPermissions => 'Hospital Permissions';

  @override
  String get createRequests => 'Create Requests';

  @override
  String get generateQrCodes => 'Generate QR Codes';

  @override
  String get viewAnalytics => 'View Analytics';

  @override
  String get donorPermissions => 'Donor Permissions';

  @override
  String get viewRequests => 'View Requests';

  @override
  String get respondToAlerts => 'Respond to Alerts';

  @override
  String get earnRewards => 'Earn Rewards';

  @override
  String get systemControl => 'System Control';

  @override
  String get enableMaintenanceMode => 'Enable Maintenance Mode';

  @override
  String get emergencyShutdown => 'Emergency Shutdown';

  @override
  String get runComprehensiveHealthCheck =>
      'Run a comprehensive system health check.';

  @override
  String get databaseConnection => 'Database Connection';

  @override
  String get responseTime45ms => 'Response time: 45ms';

  @override
  String get apiServer => 'API Server';

  @override
  String get uptime99_9 => 'Uptime: 99.9%';

  @override
  String get notificationService => 'Notification Service';

  @override
  String get queue12Pending => 'Queue: 12 pending';

  @override
  String get gpsServices => 'GPS Services';

  @override
  String get activeConnections234 => 'Active connections: 234';

  @override
  String get storage => 'Storage';

  @override
  String get usedStorage => 'Used: 45% (22GB / 50GB)';

  @override
  String get healthy => 'Healthy';

  @override
  String get warning => 'Warning';

  @override
  String get reRunCheck => 'Re-run Check';

  @override
  String get completeCheck => 'Complete Check';

  @override
  String get maintenanceWarningTitle => 'Warning: ';

  @override
  String get maintenanceWarningMessage =>
      ' Enabling maintenance mode will temporarily disable access for all users except administrator';

  @override
  String get maintenanceNoteMessage =>
      'Users will see a maintenance message and will be unable to access the system during this time.';

  @override
  String get enableMaintenanceModeTitle => 'Enable Maintenance Mode';

  @override
  String get enableMaintenanceModeSubtitle =>
      'Put the system into maintenance mode.';

  @override
  String get reasonForMaintenanceMode => 'Reason for Maintenance Mode';

  @override
  String get enterReasonForMaintenance =>
      'Enter the reason for enabling maintenance mode';

  @override
  String get estimatedDurationMinutes => 'Estimated Duration (minutes)';

  @override
  String get enterEstimatedDuration =>
      'Enter the estimated duration of maintenance mode';

  @override
  String get enableMaintenanceButton => 'Enable Maintenance';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get processingRequest => 'Processing your request...';

  @override
  String get loadingMessage => 'Please wait...';

  @override
  String get operationSuccessful => 'Operation successful';

  @override
  String get successDetails => 'Details';

  @override
  String get continueButton => 'Continue';

  @override
  String get donationSuccessful => 'Donation successful';

  @override
  String get requestSuccessful => 'Request successful';

  @override
  String get thankYouDonation => 'Thank you for your donation';

  @override
  String get error => 'Error';

  @override
  String get somethingWentWrong => 'Oops! Something went wrong';

  @override
  String get errorDetails => 'Error Details';

  @override
  String get errorCode => 'Error Code';

  @override
  String get retryButton => 'Retry';

  @override
  String get dismissButton => 'Dismiss';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get failedToProcess => 'Failed to process';

  @override
  String get loading => 'Loading';

  @override
  String get processing => 'Processing';

  @override
  String get processingDonation => 'Processing your donation...';

  @override
  String get fetchingData => 'Fetching data...';

  @override
  String get fetchingAnalytics => 'Fetching analytics...';

  @override
  String get showQrCode => 'Show QR Code';

  @override
  String get donor_qr_card_title => 'Your Donation QR Code';

  @override
  String get donor_qr_card_subtitle =>
      'Show this QR code to hospital staff upon arrival to confirm your donation.';

  @override
  String get appointmentDetailsTitle => 'Appointment Details';

  @override
  String get appointmentDetailsSubtitle => 'Your donation QR code';

  @override
  String get appointmentPrepStep1 => 'Arrive 10 minutes early';

  @override
  String get appointmentPrepStep2 => 'Bring a valid photo ID';

  @override
  String get appointmentPrepStep3 => 'Have this QR code ready to scan';

  @override
  String get appointmentPrepStep4 => 'Stay hydrated before donation';

  @override
  String get important => 'Important';

  @override
  String get appointmentInformation => 'Appointment Information';

  @override
  String get backToDonations => 'Back to Donations';

  @override
  String get shareQrCode => 'Share Qr Code';

  @override
  String get bloodDonationAppointmentShare => 'Blood Donation Appointment';

  @override
  String get hospitalLabel => 'Hospital';

  @override
  String get timeLabel => 'Time';

  @override
  String get qrTokenLabel => 'QR Token';

  @override
  String get scanDonorQrCodeTitle => 'Scan Donor QR Code';

  @override
  String get scanDonorQrCodeDescription =>
      'Verify donors and record donations quickly using QR codes.';

  @override
  String get openQrScannerButton => 'Open Qr Scanner';

  @override
  String get lifeLinkBot => 'LifeLink Bot';

  @override
  String get connectionTimeout =>
      'Connection timeout. Please check your internet connection.';

  @override
  String get sendTimeout => 'Request timeout while sending data. Try again.';

  @override
  String get receiveTimeout =>
      'Server is taking too long to respond. Try again later.';

  @override
  String get noInternet => 'No internet connection.';

  @override
  String get requestCancelled => 'Request was cancelled.';

  @override
  String get unexpectedError => 'Unexpected network error occurred.';

  @override
  String get emptyResponse => 'Empty response from server';

  @override
  String get serverError => 'Server error';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get registrationSuccess =>
      'Registration successful! Please check your email to verify your account.';

  @override
  String get loginSuccess => 'Login successful! Welcome back.';

  @override
  String get registration => 'Registration';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateRequired => 'Date of birth is required';

  @override
  String get dateHint => 'YYYY-MM-DD';

  @override
  String get pinVerificationCancelled => 'PIN verification cancelled';

  @override
  String get invalidPin => 'Invalid PIN. Please try again.';

  @override
  String get invalid_pin_length => 'PIN must be 6 digits long.';

  @override
  String get rescheduled => 'Rescheduled';

  @override
  String get no_badges_found => 'No badges found';

  @override
  String get no_rewards_found => 'No rewards found';

  @override
  String get no_points_history => 'No points history found';

  @override
  String get current => 'Current';

  @override
  String get next => 'Next';

  @override
  String get bronze => 'Bronze';

  @override
  String get silver => 'Silver';

  @override
  String get gold => 'Gold';

  @override
  String get platinum => 'Platinum';

  @override
  String get diamond => 'Diamond';

  @override
  String get coffeeVoucher => 'Coffee Voucher';

  @override
  String get movieTickets => 'Movie Tickets';

  @override
  String get restaurantGiftCard => 'Restaurant Gift Card';

  @override
  String get healthCheckUp => 'Health Check-up';

  @override
  String get premiumBadge => 'Premium Badge';

  @override
  String get gymMembership => 'Gym Membership';

  @override
  String get no_notifications => 'You have no notifications at this time.';

  @override
  String get noHospitalsFound => 'No hospitals found in this area.';

  @override
  String get unknownHospital => 'Unknown Hospital';

  @override
  String get keepAppointment => 'Keep your appointment';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancelAppointmentTitle => 'Cancel Appointment';

  @override
  String get cancelAppointmentMessage =>
      'Are you sure you want to cancel your appointment? This may affect your donation history and points.';

  @override
  String get noUpcomingAppointments => 'You have no upcoming appointments.';

  @override
  String get community_helper => 'Community Helper';

  @override
  String get responded_to_25_emergencies => 'Responded to 25 Emergencies';

  @override
  String get first_donation => 'First Donation';

  @override
  String get tier_bonus => 'Tier Bonus';

  @override
  String get badge_unlock => 'Badge Unlock';

  @override
  String get reward_redeemed => 'Reward Redemption';

  @override
  String get plasma_donation => 'Plasma Donation';

  @override
  String get platelets_donation => 'Platelets Donation';

  @override
  String get organ_donation => 'Organ Donation';

  @override
  String get admin_adjustment => 'Admin Adjustment';

  @override
  String get referral => 'Referral';

  @override
  String get requestAcceptedSuccessfully => 'Request accepted successfully';

  @override
  String get cancelRequest => 'Cancel Request';

  @override
  String get cancelRequestConfirmation =>
      'Are you sure you want to cancel this request? This action cannot be undone.';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get requestCancelledSuccessfully => 'Request cancelled successfully';

  @override
  String get delete_all_notifications_title => 'Delete All Notifications';

  @override
  String get delete_all_notifications_message =>
      'Are you sure you want to delete all notifications? This action cannot be undone.';

  @override
  String badge_unlocked_title(String badgeName) {
    return '🏆 Badge Unlocked: $badgeName';
  }

  @override
  String badge_unlocked_message(String badgeDescription) {
    return '$badgeDescription';
  }

  @override
  String tier_up_title(String tier) {
    return '🎉 Tier Upgraded to $tier!';
  }

  @override
  String tier_up_message(String tier) {
    return 'Congratulations! You\'ve reached $tier tier. Keep donating to unlock more rewards!';
  }

  @override
  String get reward_redeemed_title => '🎁 Reward Redeemed!';

  @override
  String reward_redeemed_message(String rewardName, String confirmationCode) {
    return 'Your $rewardName is confirmed. Code: $confirmationCode';
  }

  @override
  String get emergency_request_title => '🚨 Emergency Blood Request';

  @override
  String emergency_request_body(String bloodType, String hospitalName) {
    return 'Critical $bloodType blood needed near $hospitalName';
  }

  @override
  String get urgent_request_accepted_title => 'Urgent Request Accepted';

  @override
  String urgent_request_accepted_message(String requestType, String urgency) {
    return 'You accepted an urgent $requestType request with $urgency urgency.';
  }

  @override
  String get urgent_request_declined_title => 'Urgent Request Declined';

  @override
  String urgent_request_declined_message(String requestType, String urgency) {
    return 'You declined an urgent $requestType request with $urgency urgency.';
  }

  @override
  String get error_network_timeout =>
      'Connection timed out. Please check your internet.';

  @override
  String get error_server => 'Server error. Please try again later.';

  @override
  String get error_request_cancelled => 'Request was cancelled.';

  @override
  String get error_already_cancelled => 'This request is already cancelled.';

  @override
  String get error_unknown => 'Something went wrong. Please try again.';

  @override
  String get error_unauthorized => 'Unauthorized. Please log in again.';

  @override
  String get error_not_found => 'The requested resource was not found.';

  @override
  String get no_donations_found => 'No donation records found';

  @override
  String get hospital => 'Hospital';

  @override
  String get noDonationsYet => 'No donations yet.';

  @override
  String get governorate => 'Governorate';

  @override
  String get profile_updated_successfully => 'Profile updated successfully';

  @override
  String get currentPasswordRequired => 'Current password is required';

  @override
  String get newPasswordRequired => 'New password is required';

  @override
  String get passwordAtLeast6Characters =>
      'Password must be at least 6 characters';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get pleaseConfirmPassword => 'Please confirm your password';

  @override
  String get emailSupport => 'Email Support';

  @override
  String get locationNotReady =>
      'Location services are not ready. Please try again.';

  @override
  String get selectGender => 'Select Gender';

  @override
  String get selectGovernorate => 'Select Governorate';

  @override
  String get locationPermanentlyDenied =>
      'Location permissions are permanently denied. Please enable them in settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get waitingForLocation => 'Waiting for location...';

  @override
  String get acquiringLocation => 'Acquiring location...';

  @override
  String get locationUnavailable => 'Location unavailable';

  @override
  String get platelet_donation => 'Platelet Donation';

  @override
  String get first_donation_bonus => 'First Donation Bonus';

  @override
  String get error_invalid_credentials =>
      'Invalid email or password. Please check and try again.';

  @override
  String get error_invalid_email =>
      'Invalid email address. Please check and try again.';

  @override
  String get error_invalid_password => 'Invalid password. Please try again.';

  @override
  String get error_wrong_password =>
      'Wrong password. Please check and try again.';

  @override
  String get error_incorrect_current_password =>
      'Current password is incorrect. Please try again.';

  @override
  String get error_user_not_found =>
      'user account not found. Please sign up first.';

  @override
  String get error_email_already_exists =>
      'This email is already registered. Please log in or use a different email.';

  @override
  String get error_account_locked =>
      'Your account has been locked. Please contact support.';

  @override
  String get error_account_disabled =>
      'Your account has been disabled. Please contact support.';

  @override
  String get error_email_not_verified =>
      'Please verify your email address first.';

  @override
  String get error_validation => 'Please check your input and try again.';

  @override
  String get error_forbidden =>
      'You do not have permission to perform this action.';

  @override
  String get error_token_expired =>
      'Your session has expired. Please log in again.';

  @override
  String get unauthorized => 'Unauthorized access. Please log in again.';

  @override
  String get email_error => 'Invalid email address.';

  @override
  String get password_error => 'Invalid password.';

  @override
  String get dateOfBirthRequired => 'Date of birth is required';

  @override
  String get minimumAge => 'You must be at least 17 years old to donate';

  @override
  String get invalidDateOfBirth => 'Date of birth must be a valid past date';

  @override
  String get ageVerificationFailed => 'Unable to verify age from date of birth';

  @override
  String get donorNotFound => 'Donor not found';

  @override
  String get donorOrRequestNotFound => 'Donor or request not found';

  @override
  String get donorOptedOutOfMatching => 'Donor opted out of matching';

  @override
  String get donorHasNoBloodType =>
      'Donor has not provided blood type information';

  @override
  String get bloodTypeIncompatible =>
      'Donor blood type is not compatible with the request';

  @override
  String get matchingLocationUnavailable =>
      'Matching location is not available';

  @override
  String get outsideMatchingRadius => 'Donor is outside the matching radius';

  @override
  String get requestNotFound => 'Request not found';

  @override
  String get donorEligible => 'Donor is eligible';

  @override
  String get noTemporaryDeferral => 'No temporary deferral';

  @override
  String get temporaryDeferralExpired => 'Temporary deferral expired';

  @override
  String get temporarilyDeferred => 'Temporarily deferred';

  @override
  String get travelDeferral => 'Travel to high-risk country';

  @override
  String get noDonationIntervalRestriction =>
      'No donation interval restriction';

  @override
  String get invalidLastDonationDateIgnored =>
      'Invalid last donation date ignored';

  @override
  String get donationCooldownActive => 'You need to wait before donating again';

  @override
  String get donationIntervalSatisfied => 'Donation interval satisfied';

  @override
  String get noHemoglobinRestriction => 'No hemoglobin restriction';

  @override
  String get hemoglobinBelowMinimum => 'Low hemoglobin level';

  @override
  String get hemoglobinLevelAcceptable => 'Hemoglobin level acceptable';

  @override
  String get donorSuspended => 'Donor is suspended';

  @override
  String get donorCurrentlyUnavailable => 'Donor is currently unavailable';

  @override
  String get requestNoLongerActive => 'The linked request is no longer active';

  @override
  String get notEligible => 'Not Eligible';

  @override
  String get reason => 'Reason';

  @override
  String get canDonate => 'Can donate';

  @override
  String get login_successful => 'Login successful! Welcome back.';

  @override
  String get noDonorsFound => 'No donors found';

  @override
  String get noDataFound => 'No data found';

  @override
  String get alreadyCancelled => 'Appointment Already Cancelled';

  @override
  String get alreadyCancelledMessage =>
      'This appointment has already been cancelled.';

  @override
  String get ok => 'OK';

  @override
  String get rescheduleSuccess => 'Appointment Rescheduled';

  @override
  String get rescheduleSuccessMessage =>
      'Your appointment has been updated successfully.';

  @override
  String get rescheduleError => 'Reschedule Failed';

  @override
  String get error_hospital_id_date_required =>
      'Hospital and appointment date are required';

  @override
  String get error_invalid_donation_type => 'Invalid donation type';

  @override
  String get error_appointment_date_future =>
      'Appointment date must be in the future';

  @override
  String get error_appointment_date_invalid => 'Appointment date is invalid';

  @override
  String get error_appointment_min_hours =>
      'Appointment must be scheduled further in advance';

  @override
  String get error_appointment_max_days =>
      'Appointment cannot be scheduled that far in advance';

  @override
  String get error_day_not_available =>
      'Selected day is not available for appointments';

  @override
  String get error_hospital_scheduling_disabled =>
      'Hospital appointment scheduling is currently disabled';

  @override
  String get error_hospital_donation_type_not_supported =>
      'Hospital does not support this donation type';

  @override
  String get error_invalid_donor_or_hospital => 'Invalid donor or hospital';

  @override
  String get error_invalid_request_id => 'Invalid request ID';

  @override
  String get error_request_not_belong_hospital =>
      'Request does not belong to this hospital';

  @override
  String get error_request_no_longer_active =>
      'The linked request is no longer active';

  @override
  String get error_outside_operating_hours =>
      'Selected time slot is outside operating hours';

  @override
  String get error_time_slot_not_available =>
      'Selected time slot is no longer available';

  @override
  String get error_daily_capacity_reached =>
      'Daily appointment capacity has been reached';

  @override
  String get error_donor_unavailable => 'Donor is currently unavailable';

  @override
  String get error_donor_suspended => 'Donor account is suspended';

  @override
  String get error_donor_cooldown => 'Donor is in a cooldown period';

  @override
  String get error_incompatible_blood_type => 'Incompatible blood type';

  @override
  String get error_active_donation_in_progress =>
      'There is already an active donation in progress';

  @override
  String get error_hospital_not_found => 'Hospital not found';

  @override
  String get error_donor_not_found => 'Donor not found';

  @override
  String get error_request_not_found => 'Request not found';

  @override
  String get error_appointment_already_exists =>
      'You already have an active appointment at this hospital';

  @override
  String get error_appointment_id_required => 'Appointment ID is required';

  @override
  String get error_date_required => 'Date is required';

  @override
  String get error_invalid_appointment_id => 'Invalid appointment ID';

  @override
  String get error_only_pending_confirmed_reschedule =>
      'Only pending or confirmed appointments can be rescheduled';

  @override
  String get error_reschedule_date_future =>
      'New appointment date must be in the future';

  @override
  String get error_reschedule_same_details =>
      'New appointment details must be different from the current appointment';

  @override
  String get error_max_reschedules_reached =>
      'This appointment has reached the maximum number of reschedules';

  @override
  String get error_hospital_no_rescheduling =>
      'This hospital does not allow rescheduling';

  @override
  String get error_reschedule_min_hours =>
      'Reschedule must be further in advance';

  @override
  String get error_reschedule_max_days =>
      'Reschedule cannot be that far in advance';

  @override
  String get error_appointment_not_found => 'Appointment not found';

  @override
  String get error_hospital_suspended => 'Hospital is currently suspended';

  @override
  String get error_hospital_not_verified => 'Hospital is not verified';

  @override
  String get noAlerts => 'You have no alerts at this time.';

  @override
  String get suspended => 'Suspended';

  @override
  String get noRequestsFound => 'No requests found';

  @override
  String get noContactNumberAvailable => 'No contact number available';

  @override
  String get couldNotLaunchDialer =>
      'Could not launch dialer. Please check your device settings.';

  @override
  String get cancelRequestConfirmationMessage =>
      'Are you sure you want to cancel this request? This action cannot be undone.';

  @override
  String get deleteUserConfirmation =>
      'Are you sure you want to delete this user? This action cannot be undone.';

  @override
  String get rewardsConfigAnalyticsTitle => 'Rewards Config & Analytics';

  @override
  String get rewardsConfigAnalyticsDescription =>
      'Catalog, configuration & point management';

  @override
  String get overview => 'Overview';

  @override
  String get configuration => 'Configuration';

  @override
  String get adjustPoints => 'Adjust Points';

  @override
  String get increase_from_last_month => 'Increase from last month';

  @override
  String get topRedeemedRewards => 'Top Redeemed Rewards';

  @override
  String get pointsConfiguration => 'Points Configuration';

  @override
  String get globalPointAllocationSettings =>
      'Global point allocation settings';

  @override
  String get configurationNote => 'Configuration Note';

  @override
  String get configurationNoteDescription =>
      'Changes apply globally to all future point events. Previously earned points are not affected.';

  @override
  String get manualPointsAdjustment => 'Manual Points Adjustment';

  @override
  String get manualPointsAdjustmentDescription =>
      'Directly modify a specific donor\'s balance';

  @override
  String get userIdOrEmail => 'User ID / Email';

  @override
  String get userIdOrEmailHint => 'Enter User ID or Email';

  @override
  String get amountPoints => 'Amount (Points)';

  @override
  String get amountPointsHint => 'Enter Amount in Points';

  @override
  String get reasonHint => 'Enter Reason for Adjustment';

  @override
  String get submitAdjustment => 'Submit Adjustment';

  @override
  String get recentAdjustments => 'Recent Adjustments';

  @override
  String get banUser => 'Ban User';

  @override
  String get banUserConfirmation => 'Are you sure you want to ban';

  @override
  String get banReasonHint => 'Enter the reason for banning this user';

  @override
  String get ban => 'Ban';

  @override
  String get unbanUser => 'Unban User';

  @override
  String get unbanUserConfirmation => 'Are you sure you want to unban';

  @override
  String get unban => 'Unban';

  @override
  String aiPredictionDemandIncrease(Object percentage) {
    return 'Blood demand expected to increase $percentage% next month based on historical trends — consider scheduling additional donation drives and sending proactive alerts to O+ and A+ donors.';
  }

  @override
  String aiPredictionDemandSteady(Object percentage) {
    return 'Blood demand showing a steady $percentage% weekly increase. Monitor inventory levels closely over the next 2 weeks.';
  }

  @override
  String aiPredictionShortageRisk(Object bloodType, Object ratio) {
    return '$bloodType supply at risk with a $ratio:1 demand-to-supply ratio. Proactive targeted outreach to $bloodType donors recommended this week.';
  }

  @override
  String aiPredictionRetentionDrop(Object rate) {
    return 'Donor return rate has dropped to $rate% — consider launching a re-engagement campaign with bonus points for returning donors this month.';
  }

  @override
  String aiPredictionRetentionImprove(Object rate) {
    return 'Donor retention has improved to $rate% — current momentum is strong. Capitalize by introducing referral rewards to sustain growth.';
  }

  @override
  String get jan => 'January';

  @override
  String get feb => 'February';

  @override
  String get mar => 'March';

  @override
  String get apr => 'April';

  @override
  String get may => 'May';

  @override
  String get jun => 'June';

  @override
  String get jul => 'July';

  @override
  String get aug => 'August';

  @override
  String get sep => 'September';

  @override
  String get oct => 'October';

  @override
  String get nov => 'November';

  @override
  String get dec => 'December';

  @override
  String get selectLocationOnMap => 'Select Location on Map';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Location permissions are permanently denied. Please enable them in settings.';

  @override
  String get tapOnMapToSelectLocation =>
      'Tap on the map to select your location';

  @override
  String get confirmLocation => 'Confirm Location';

  @override
  String get locationOnMap => 'Location on Map';

  @override
  String get tapToSelectLocationOnMap => 'Tap to select location on map';

  @override
  String get enterCity => 'Enter city';

  @override
  String get enterState => 'Enter state or governorate';

  @override
  String get zipCode => 'Zip Code';

  @override
  String get enterZipCode => 'Enter zip code';

  @override
  String get capacity => 'Capacity';

  @override
  String get enterCapacity => 'Enter bed capacity';

  @override
  String get capacityInvalidError => 'Please enter a valid capacity';

  @override
  String get locationSelected => 'Location selected';

  @override
  String get bloodBanksAvailable => 'Blood Banks Available';

  @override
  String get selectAtLeastOneBloodBank =>
      'Please select at least one blood type';

  @override
  String get failedToCreateHospital => 'Failed to create hospital';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get share => 'Share';

  @override
  String get done => 'Done';

  @override
  String get copy => 'Copy';

  @override
  String get addNewReward => 'Add New Reward';

  @override
  String get addNewRewardSubtitle =>
      'Fill in the details to add a new reward to the catalog.';

  @override
  String get rewardName => 'Reward Name';

  @override
  String get enterRewardName => 'Enter reward name';

  @override
  String get category => 'Category';

  @override
  String get enterRewardCategory => 'Enter reward category';

  @override
  String get pointsRequired => 'Points Required';

  @override
  String get enterPointsRequired => 'Enter points required';

  @override
  String get initialState => 'Initial State';

  @override
  String get selectState => 'Select state';

  @override
  String get addReward => 'Add Reward';

  @override
  String get rewardCatalog => 'Reward Catalog';

  @override
  String itemsCount(int count) {
    return '$count Items';
  }

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidNumber => 'Please enter a valid number';

  @override
  String get rewardSubtitle => 'Reward Subtitle';

  @override
  String get admin => 'Admin';

  @override
  String get superAdmin => 'Super Admin';

  @override
  String get inboundEmailsTitle => 'Inbound Emails';

  @override
  String get inboundEmailSearchHint => 'Search emails...';

  @override
  String get inboundEmailFilterAll => 'All';

  @override
  String get inboundEmailFilterUnread => 'Unread';

  @override
  String get inboundEmailFilterArchived => 'Archived';

  @override
  String get inboundEmailEmptyState => 'No emails here';

  @override
  String get inboundEmailDeleteTitle => 'Delete email';

  @override
  String inboundEmailDeleteConfirm(String subject) {
    return 'Are you sure you want to delete \"$subject\"? This cannot be undone.';
  }

  @override
  String get inboundEmailCancel => 'Cancel';

  @override
  String get inboundEmailDelete => 'Delete';

  @override
  String get inboundEmailMarkAsRead => 'Mark as read';

  @override
  String get inboundEmailArchive => 'Archive';

  @override
  String inboundEmailFrom(String from) {
    return 'From: $from';
  }

  @override
  String get inboundEmailArchivedBadge => 'Archived';

  @override
  String get inboundEmailUnreadBadge => 'Unread';

  @override
  String get inboundEmailDetailFrom => 'From';

  @override
  String get inboundEmailDetailTo => 'To';

  @override
  String get inboundEmailDetailProvider => 'Provider';

  @override
  String get inboundEmailDetailReceived => 'Received';

  @override
  String get inboundEmailMarkedAsReadSnack => 'Marked as read';

  @override
  String get inboundEmailArchivedSnack => 'Email archived';

  @override
  String get inboundEmailDeletedSnack => 'Email deleted';

  @override
  String get inboundEmailErrorGeneric =>
      'Something went wrong. Please try again.';

  @override
  String get inboundEmailErrorNetworkTimeout =>
      'Connection timed out. Please check your internet and try again.';

  @override
  String get inboundEmailErrorUnauthorized =>
      'You are not authorized to perform this action.';

  @override
  String get inboundEmailErrorNotFound => 'Email not found.';

  @override
  String get inboundEmailErrorRequestCancelled => 'Request was cancelled.';

  @override
  String get inboundEmails => 'Inbound Emails';

  @override
  String get admin_reset_password_title => 'Reset Admin Password';

  @override
  String get admin_reset_password_subtitle =>
      'Enter a new password for the admin account.';

  @override
  String get hospital_reset_password_title => 'Reset Hospital Password';

  @override
  String get hospital_reset_password_subtitle =>
      'Enter a new password for the hospital account.';

  @override
  String get noMoreHospitals => 'No more hospitals available';

  @override
  String get acceptedRequestSectionTitle => 'Accepted Requests';

  @override
  String get requestedAt => 'Requested at';

  @override
  String get status => 'Status';

  @override
  String get notes => 'Notes';

  @override
  String get showDetails => 'Show Details';

  @override
  String get adult => 'Adult';

  @override
  String get child => 'Child';

  @override
  String get urgent => 'Urgent';

  @override
  String get normal => 'Normal';

  @override
  String get emergency2Units => '2 units';

  @override
  String get emergencyLabel => 'Emergency';

  @override
  String get loadingAcceptedRequestsMessage => 'Loading accepted requests...';

  @override
  String get noAcceptedRequestsMessage => 'No accepted requests found.';

  @override
  String get cancellingRequest => 'Cancelling request...';

  @override
  String get requestAlreadyCancelled =>
      'This request has already been cancelled';

  @override
  String get cancelConfirmationMessage =>
      'Are you sure you want to cancel this request?';

  @override
  String get addressNotAvailable => 'Address not available';

  @override
  String get acceptedRequestsLoadingMoreMessage => 'Loading more requests...';

  @override
  String get connection_timeout =>
      'Connection timeout. Please check your internet connection.';

  @override
  String get request_cancelled => 'Request was cancelled.';

  @override
  String get no_internet => 'No internet connection.';

  @override
  String get unknown_error => 'Unexpected network error occurred.';

  @override
  String get empty_response => 'Empty response from server';

  @override
  String get server_error => 'Server error';

  @override
  String get donor_login_success_message => 'Login successful! Welcome back.';

  @override
  String get donorNotEligible => 'Donor is not eligible';

  @override
  String get donorAccountDeletedOrInactive =>
      'Donor account is deleted or inactive';

  @override
  String get invalidDonorRole => 'Invalid donor role';

  @override
  String get donorAccountSuspended => 'Donor account is suspended';

  @override
  String get donorChronicMedicalConditions =>
      'Donor has chronic medical conditions';

  @override
  String get donorActiveDonationInProgress =>
      'Donor already has an active donation in progress';

  @override
  String get donorCompletedOrRejectedRequest =>
      'Donor has already completed or rejected this request';

  @override
  String get cannotSpecifyAnotherDonorId =>
      'You cannot specify another donor\'s ID — only your authenticated ID is used';

  @override
  String get requestIdAndDonationTypeNotAccepted =>
      'requestId and donationType parameters are not accepted on this endpoint';

  @override
  String get authenticatedDonorIdNotFound =>
      'Authenticated donor ID not found in authentication token';

  @override
  String get activityTimelineRetrievedSuccessfully =>
      'Activity timeline retrieved successfully';

  @override
  String get pageMustBePositiveInteger => 'Page must be a positive integer';

  @override
  String get limitMustBePositiveInteger => 'Limit must be a positive integer';

  @override
  String invalidTypeFilter(String typeParam) {
    return 'Invalid type filter: $typeParam';
  }

  @override
  String get activityProfileCompleted => 'Profile Completed';

  @override
  String get activityUrgentRequestNearby => 'Urgent Request Nearby';

  @override
  String activityPointsEarned(String points, String activity) {
    return '$points Points Earned — $activity';
  }

  @override
  String get relativeTimeJustNow => 'just now';

  @override
  String get relativeTime1MinuteAgo => '1 minute ago';

  @override
  String relativeTimeMinutesAgo(String count) {
    return '$count minutes ago';
  }

  @override
  String get relativeTime1HourAgo => '1 hour ago';

  @override
  String relativeTimeHoursAgo(String count) {
    return '$count hours ago';
  }

  @override
  String get relativeTime1DayAgo => '1 day ago';

  @override
  String relativeTimeDaysAgo(String count) {
    return '$count days ago';
  }

  @override
  String get relativeTime1WeekAgo => '1 week ago';

  @override
  String relativeTimeWeeksAgo(String count) {
    return '$count weeks ago';
  }

  @override
  String get relativeTime1MonthAgo => '1 month ago';

  @override
  String relativeTimeMonthsAgo(String count) {
    return '$count months ago';
  }

  @override
  String get relativeTime1YearAgo => '1 year ago';

  @override
  String relativeTimeYearsAgo(String count) {
    return '$count years ago';
  }

  @override
  String get activityStatusPending => 'Pending';

  @override
  String get activityStatusSuccess => 'Success';

  @override
  String get activityStatusCancelled => 'Cancelled';

  @override
  String get noActivitiesFound => 'No activities found';

  @override
  String get activityProfileUpdated => 'Profile Updated';

  @override
  String get activityDonationCompleted => 'Donation Completed';

  @override
  String get activityDonationCancelled => 'Donation Cancelled';

  @override
  String get reward_redeemed_successfully => 'Reward redeemed successfully';

  @override
  String get participationUpdated => 'Participation updated successfully';

  @override
  String get youAreNotEligible => 'You are not eligible for this activity';

  @override
  String get youAreEligible => 'You are eligible for this activity';

  @override
  String get donationEligibility => 'Donation Eligibility';

  @override
  String get contact_support => 'Contact Support';

  @override
  String get contact_support_subtitle =>
      'Fill out the form below to submit a support ticket.';

  @override
  String get subject => 'Subject';

  @override
  String get select_category => 'Select a category';

  @override
  String get submit_ticket => 'Submit Ticket';

  @override
  String get account_management => 'Account Management';

  @override
  String get technical_issue => 'Technical Issue';

  @override
  String get donation_process => 'Donation Process';

  @override
  String get rewards_point => 'Rewards Point';

  @override
  String get other => 'Other';

  @override
  String get support_request_sent_successfully =>
      'Support request sent successfully';

  @override
  String get please_enter_your_name => 'Please enter your name';

  @override
  String get please_enter_your_email => 'Please enter your email';

  @override
  String get please_enter_valid_email => 'Please enter a valid email';

  @override
  String get please_enter_subject => 'Please enter a subject';

  @override
  String get please_select_category => 'Please select a category';

  @override
  String get please_enter_message => 'Please enter a message';

  @override
  String get network_timeout => 'Network timeout. Please try again.';

  @override
  String get not_found => 'Resource not found.';

  @override
  String get rewardsPoint => 'Rewards Point';

  @override
  String get donationProcess => 'Donation Process';

  @override
  String get technicalIssue => 'Technical Issue';

  @override
  String get accountManagement => 'Account Management';

  @override
  String get ticket_submitted_successfully => 'Ticket submitted successfully';

  @override
  String get editDonor => 'Edit Donor';

  @override
  String get editHospital => 'Edit Hospital';

  @override
  String get editAdmin => 'Edit Admin';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get updateSuccess => 'Updated successfully';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get participationAddedSuccessfully =>
      'Participation added successfully';

  @override
  String get participationAddedFailed => 'Participation added failed';

  @override
  String get activityAddedSuccessfully => 'Activity added successfully';

  @override
  String get activityAddedFailed => 'Activity added failed';

  @override
  String get noInsightsAvailable => 'No insights available';

  @override
  String get topDonors => 'Top Donors';

  @override
  String get growth => 'Growth';

  @override
  String get isEligibleToDonate => 'Eligible to Donate';

  @override
  String get isActive => 'Active';

  @override
  String get isVerified => 'Verified';

  @override
  String get healthStatus => 'Health Status';

  @override
  String get isBanned => 'Banned';

  @override
  String get donorRank => 'Rank';

  @override
  String get memberSince => 'Member Since';

  @override
  String get hospitalContact => 'Contact';

  @override
  String get requiredBy => 'Required By';

  @override
  String get title => 'Alert';

  @override
  String get description => 'Description';

  @override
  String get confidence => 'Confidence';

  @override
  String get predictMatchPercentage => 'Match Likelihood';

  @override
  String get summaryStats => 'Summary Statistics';

  @override
  String get risingDemandTrend => 'Rising Demand Trend';

  @override
  String get decliningDemand => 'Declining Demand';

  @override
  String get supplyWarning => 'Supply Warning';

  @override
  String get peakDayInsight => 'Peak Day Insight';

  @override
  String get donorRetentionAlert => 'Donor Retention Alert';

  @override
  String get donorGrowthPositive => 'Donor Growth Positive';

  @override
  String get emergencyDemandSpike => 'Emergency Demand Spike';

  @override
  String get risingDemandTrendDesc =>
      'Blood requests are trending upward. Prepare additional resources.';

  @override
  String get decliningDemandDesc =>
      'Blood requests are declining. Review inventory allocation.';

  @override
  String supplyWarningDesc(Object bloodType) {
    return '$bloodType blood supply is approaching critical levels.';
  }

  @override
  String peakDayInsightDesc(Object dayName, Object percentage) {
    return '$dayName shows $percentage% higher donation activity. Consider scheduling more drives on this day.';
  }

  @override
  String get donorRetentionAlertDesc =>
      'Donor return rate has dropped significantly. Consider re-engagement campaigns.';

  @override
  String get donorGrowthPositiveDesc =>
      'More donors are returning compared to last month. Momentum is strong.';

  @override
  String get emergencyDemandSpikeDesc =>
      'Blood demand has surged unexpectedly in the last 3 days. Emergency response may be needed.';

  @override
  String criticalNeed(Object bloodTypes) {
    return 'Critical need for $bloodTypes';
  }

  @override
  String get typeCritical => 'Critical';

  @override
  String get typeWarning => 'Warning';

  @override
  String get chronicConditions => 'Chronic Conditions';

  @override
  String get booleanTrue => 'Yes';

  @override
  String get booleanFalse => 'No';

  @override
  String get monAbbr => 'Mon';

  @override
  String get tueAbbr => 'Tue';

  @override
  String get wedAbbr => 'Wed';

  @override
  String get thuAbbr => 'Thu';

  @override
  String get friAbbr => 'Fri';

  @override
  String alertTitle(String bloodTypes) {
    return 'Critical need for $bloodTypes';
  }

  @override
  String alertDescription(String bloodTypes) {
    return 'Critical request for $bloodTypes blood type(s).';
  }

  @override
  String get satAbbr => 'Sat';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String aiPredictionTodaySpike(String percentage) {
    return 'Today shows a $percentage% increase in demand.';
  }

  @override
  String aiPredictionDemandDecline(String percentage) {
    return 'Blood demand has declined $percentage% in the past week. Consider reducing scheduled drive frequency and reviewing inventory redistribution across hospitals.';
  }

  @override
  String aiPredictionShortageCritical(
    String bloodType,
    String available,
    String needed,
  ) {
    return '$bloodType critically low — only $available donors available against $needed units needed. Launch emergency campaign within 48 hours.';
  }

  @override
  String aiPredictionPeakDay(String dayName, String percentage) {
    return '$dayName shows $percentage% higher donation activity — schedule more mobile drives and staff on this day to maximize collections.';
  }

  @override
  String aiPredictionWeekend(String percentage) {
    return 'Weekend donation drives show $percentage% higher success rates compared to weekdays. Prioritize weekend scheduling for upcoming emergency campaigns.';
  }

  @override
  String get rewardCoffeeVoucher => 'Coffee Voucher';

  @override
  String get rewardCoffeeVoucherDesc => 'Free coffee at partner cafes';

  @override
  String get rewardGymMembership => 'Gym Membership';

  @override
  String get rewardPremiumBadge => 'Premium Badge';

  @override
  String get rewardHealthCheckup => 'Health Check-up';

  @override
  String get rewardRestaurantGiftCard => 'Restaurant Gift Card';

  @override
  String get rewardMovieTickets => 'Movie Tickets';

  @override
  String get rewardStatusActive => 'Active';

  @override
  String get rewardStatusInactive => 'Inactive';

  @override
  String get rewardCategoryHealth => 'Health';

  @override
  String get rewardCategoryStatus => 'Status';

  @override
  String get rewardCategoryFood => 'Food';

  @override
  String get rewardCategoryEntertainment => 'Entertainment';

  @override
  String get point => 'Point';

  @override
  String get redeemed => 'Redeemed';

  @override
  String get setRewardActive => 'Set ACTIVE';

  @override
  String get setRewardInactive => 'Set INACTIVE';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get confirmEmergencyShutdown =>
      'Are you sure you want to shut down the system immediately? All users will be disconnected.';

  @override
  String get emergencyShutdownInitiated => 'EMERGENCY SHUTDOWN INITIATED';

  @override
  String get systemRestored => 'System Restored';

  @override
  String get statusOnline => 'ONLINE';

  @override
  String get statusOffline => 'OFFLINE / MAINTENANCE';

  @override
  String get disableMaintenanceMode => 'Restore System & Disable Maintenance';

  @override
  String get system_status_updated_successfully =>
      'System status updated successfully';

  @override
  String get auditLogs => 'Audit Logs';

  @override
  String get filterByTargetType => 'Filter by Target Type';

  @override
  String get isLoadingMore => 'Loading more logs...';

  @override
  String get noAuditLogsFound => 'No audit logs found';

  @override
  String get allTypes => 'All Types';

  @override
  String get rotate_admin_key => 'Rotate Key';

  @override
  String get rotate_admin_key_title => 'Rotate Admin Key?';

  @override
  String get rotate_admin_key_confirm_message =>
      'This will generate a new admin key and immediately invalidate the current one. This action cannot be undone. Are you sure you want to continue?';

  @override
  String get new_admin_key_title => 'New Admin Key Generated';

  @override
  String get new_admin_key_warning =>
      'This key is shown only once. Make sure to copy and store it securely before closing this dialog.';

  @override
  String get copied_to_clipboard => 'Copied to clipboard';

  @override
  String get auditLogsTitle => 'Audit logs';

  @override
  String get actionHospitalAdded => 'Hospital Added';

  @override
  String get actionUserBanned => 'User Banned';

  @override
  String get actionUserUnbanned => 'User Unbanned';

  @override
  String get actionUserSuspended => 'User Suspended';

  @override
  String get actionUserUnsuspended => 'User Unsuspended';

  @override
  String get actionUserDeleted => 'User Deleted';

  @override
  String get actionAdminAdded => 'Admin Added';

  @override
  String get actionMaintenanceModeUpdated => 'Maintenance Mode Updated';

  @override
  String get detailCreateHospital => 'Added hospital account';

  @override
  String detailBan(String targetId) {
    return 'Banned user account (ID: $targetId)';
  }

  @override
  String detailUnban(String targetId) {
    return 'Unbanned user account (ID: $targetId)';
  }

  @override
  String detailSuspend(String targetId) {
    return 'Suspended user account (ID: $targetId)';
  }

  @override
  String detailUnsuspend(String targetId) {
    return 'Unsuspended user account (ID: $targetId)';
  }

  @override
  String detailDelete(String targetId) {
    return 'Soft-deleted user account (ID: $targetId)';
  }

  @override
  String detailCreateAdmin(String targetId) {
    return 'Created admin account (ID: $targetId)';
  }

  @override
  String get detailMaintenance => 'Updated system maintenance mode';

  @override
  String detailDefault(String action, String targetType) {
    return 'Performed action $action on $targetType';
  }

  @override
  String get targetTypeUser => 'user';

  @override
  String get targetTypeRequest => 'request';

  @override
  String get targetTypeDonation => 'donation';

  @override
  String get targetTypeSystem => 'system';

  @override
  String get actionDonorUpdated => 'Donor Updated';

  @override
  String get actionHospitalUpdated => 'Hospital Updated';

  @override
  String get actionAdminUpdated => 'Admin Updated';

  @override
  String get actionAdminDeleted => 'Admin Deleted';

  @override
  String get actionAdminKeyRotated => 'Admin Key Rotated';

  @override
  String get actionProfileUpdated => 'Profile Updated';

  @override
  String get actionBadgeUpdated => 'Badge Updated';

  @override
  String get actionRewardsConfigUpdated => 'Rewards Config Updated';

  @override
  String get actionRoleCreated => 'Role Created';

  @override
  String get actionRoleUpdated => 'Role Updated';

  @override
  String get actionRoleDeleted => 'Role Deleted';

  @override
  String get actionHospitalCreated => 'Hospital Created';

  @override
  String get supportTicketsTab => 'Support Tickets';

  @override
  String get supportTicketStatus => 'Status';

  @override
  String get supportTicketCategory => 'Category';

  @override
  String get supportTicketFrom => 'From';

  @override
  String get supportTicketCreatedAt => 'Created';

  @override
  String get supportTicketReply => 'Reply';

  @override
  String get supportTicketReplyHint => 'Type your reply...';

  @override
  String get supportTicketSendReply => 'Send Reply';

  @override
  String get supportTicketStatusOpen => 'Open';

  @override
  String get supportTicketStatusClosed => 'Closed';

  @override
  String get supportTicketStatusInProgress => 'In Progress';

  @override
  String get supportTicketEmptyState => 'No support tickets';

  @override
  String get supportTicketReplySentSnack => 'Reply sent successfully';

  @override
  String get supportTicketReplyErrorSnack => 'Failed to send reply';

  @override
  String get supportTicketAdminReply => 'Admin Reply';

  @override
  String get supportTicketNoReply => 'No reply yet';

  @override
  String get actionRequestFulfilled => 'Request Fulfilled';

  @override
  String get actionRequestCancelled => 'Request Cancelled';

  @override
  String get actionRequestBroadcasted => 'Request Broadcasted';

  @override
  String detailRequestAction(Object action, Object id) {
    return '$action (ID: $id)';
  }

  @override
  String get earningRulesSubtitle => 'Manage your earning rules here';

  @override
  String get addRule => 'Add Rule';

  @override
  String get totalRules => 'Total Rules';

  @override
  String get activeRules => 'Active Rules';

  @override
  String get inactiveRules => 'Inactive Rules';

  @override
  String get noEarningRules => 'No Earning Rules Found';

  @override
  String get noEarningRulesSubtitle => 'Create a new rule to get started';

  @override
  String get earningRuleCategory => 'Category';

  @override
  String get editPoints => 'Edit Points';

  @override
  String get addEarningRule => 'Add Earning Rule';

  @override
  String get addEarningRuleSubtitle =>
      'Fill in the details to create a new rule';

  @override
  String get earningRuleType => 'Rule Type';

  @override
  String get earningRuleTypeHint => 'e.g., Donation';

  @override
  String get earningRuleTitle => 'Rule Title';

  @override
  String get earningRuleTitleHint => 'e.g., First Donation';

  @override
  String get earningRulePointsHint => 'Enter points';

  @override
  String get earningRuleActiveStatus => 'Is Active';

  @override
  String get deleteEarningRuleTitle => 'Delete Earning Rule';

  @override
  String get deleteEarningRuleConfirmation =>
      'Are you sure you want to delete this earning rule?';

  @override
  String get earningRulesTitle => 'Earning Rules';

  @override
  String get activityType => 'Activity Type';

  @override
  String detailAdminUpdated(Object id) {
    return 'Updated admin account (ID: $id)';
  }

  @override
  String detailAdminKeyRotated(Object id) {
    return 'Rotated admin key (ID: $id)';
  }

  @override
  String detailHospitalUpdated(Object id) {
    return 'Updated hospital account (ID: $id)';
  }

  @override
  String get broadcastSent => 'Broadcast Sent';

  @override
  String get requestFulfilled => 'Request marked as fulfilled';

  @override
  String get error_authorization_required => 'Authorization header is required';

  @override
  String get error_account_suspended => 'Account is suspended';

  @override
  String get error_reward_fields_required =>
      'Reward name, category, and points required are mandatory';

  @override
  String get error_status_required => 'Status is required';

  @override
  String get error_invalid_status_value =>
      'Status must be ACTIVE, INACTIVE, or LIMITED';

  @override
  String get error_reward_not_found => 'Reward not found';

  @override
  String get error_bulk_points_empty =>
      'Updates array must have at least one entry';

  @override
  String get error_bulk_points_invalid_update =>
      'Each update must have an ID and points required number';

  @override
  String get error_adjustment_fields_required =>
      'Email, amount, and reason are required';

  @override
  String get error_amount_non_zero => 'Amount must be a non-zero number';

  @override
  String get error_only_donors_have_points => 'Only donor accounts have points';

  @override
  String get error_earning_rule_fields_required =>
      'Type, title, points, and category are required';

  @override
  String get error_points_non_negative =>
      'Points must be a non-negative number';

  @override
  String get error_invalid_rule_type =>
      'Invalid rule type. Must be one of: bloodDonation, plasmaDonation, plateletsDonation, doubleRedCellsDonation, emergencyResponse, profileCompletion, referral, firstDonation';

  @override
  String get error_earning_rule_exists => 'This earning rule already exists';

  @override
  String get error_earning_rule_not_found => 'Earning rule not found';

  @override
  String get categoryDonation => 'Donation';

  @override
  String get categoryReferral => 'Referral';

  @override
  String get categoryRegistration => 'Registration';

  @override
  String get categoryOther => 'Other';

  @override
  String get ruleBloodDonation => 'Blood Donation';

  @override
  String get ruleDoubleRedCells => 'Double Red Cells Donation';

  @override
  String get rulePlasmaDonation => 'Plasma Donation';

  @override
  String get rulePlateletsDonation => 'Platelets Donation';

  @override
  String get detailProfileUpdated => 'Updated admin profile';

  @override
  String detailDonorUpdated(Object id) {
    return 'Updated donor account (ID: $id)';
  }

  @override
  String get error_current_new_password_required =>
      'Current and new passwords are required';

  @override
  String get error_new_password_same_as_current =>
      'New password cannot be the same as current';

  @override
  String get inboundEmailEmptyArchived => 'No archived emails here';

  @override
  String get inboundEmailEmptyUnread => 'No unread emails here';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusReviewed => 'Reviewed';

  @override
  String get statusClosed => 'Closed';

  @override
  String get categoryTechnical => 'Technical';

  @override
  String get categoryAccount => 'Account';

  @override
  String get categoryRewards => 'Rewards';
}
