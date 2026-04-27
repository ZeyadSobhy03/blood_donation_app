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
}
