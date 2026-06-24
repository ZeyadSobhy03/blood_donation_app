class ErrorKeys {
  // ── Network Errors ──
  static const String connectionTimeout = 'connection_timeout';
  static const String noInternet = 'no_internet';
  static const String networkTimeout = 'network_timeout';
  static const String requestCancelled = 'request_cancelled';

  // ── Authentication Errors ──
  static const String invalidCredentials = 'error_invalid_credentials';
  static const String invalidEmail = 'error_invalid_email';
  static const String invalidPassword = 'error_invalid_password';
  static const String wrongPassword = 'error_wrong_password';
  static const String incorrectCurrentPassword = 'error_incorrect_current_password';
  static const String userNotFound = 'error_user_not_found';
  static const String emailAlreadyExists = 'error_email_already_exists';
  static const String accountLocked = 'error_account_locked';
  static const String accountDisabled = 'error_account_disabled';
  static const String emailNotVerified = 'error_email_not_verified';
  static const String tokenExpired = 'error_token_expired';
  static const String unauthorized = 'unauthorized';
  static const String forbidden = 'error_forbidden';

  // ── Validation Errors ──
  static const String emailError = 'email_error';
  static const String passwordError = 'password_error';
  static const String validationError = 'error_validation';

  // ── Appointment Booking Errors ──
  static const String hospitalIdDateRequired = 'error_hospital_id_date_required';
  static const String invalidDonationType = 'error_invalid_donation_type';
  static const String appointmentDateFuture = 'error_appointment_date_future';
  static const String appointmentDateInvalid = 'error_appointment_date_invalid';
  static const String appointmentMinHours = 'error_appointment_min_hours';
  static const String appointmentMaxDays = 'error_appointment_max_days';
  static const String dayNotAvailable = 'error_day_not_available';
  static const String hospitalSchedulingDisabled = 'error_hospital_scheduling_disabled';
  static const String hospitalDonationTypeNotSupported = 'error_hospital_donation_type_not_supported';
  static const String invalidDonorOrHospital = 'error_invalid_donor_or_hospital';
  static const String invalidRequestId = 'error_invalid_request_id';
  static const String requestNotBelongHospital = 'error_request_not_belong_hospital';
  static const String requestNoLongerActive = 'error_request_no_longer_active';
  static const String outsideOperatingHours = 'error_outside_operating_hours';
  static const String timeSlotNotAvailable = 'error_time_slot_not_available';
  static const String dailyCapacityReached = 'error_daily_capacity_reached';
  static const String appointmentAlreadyExists = 'error_appointment_already_exists';

  // ── Reschedule Errors ──
  static const String appointmentIdRequired = 'error_appointment_id_required';
  static const String dateRequired = 'error_date_required';
  static const String invalidAppointmentId = 'error_invalid_appointment_id';
  static const String onlyPendingConfirmedReschedule = 'error_only_pending_confirmed_reschedule';
  static const String rescheduleDateFuture = 'error_reschedule_date_future';
  static const String rescheduleSameDetails = 'error_reschedule_same_details';
  static const String maxReschedulesReached = 'error_max_reschedules_reached';
  static const String hospitalNoRescheduling = 'error_hospital_no_rescheduling';
  static const String rescheduleMinHours = 'error_reschedule_min_hours';
  static const String rescheduleMaxDays = 'error_reschedule_max_days';

  // ── Donor Eligibility Errors ──
  static const String donorUnavailable = 'error_donor_unavailable';
  static const String donorSuspended = 'error_donor_suspended';
  static const String donorCooldown = 'error_donor_cooldown';
  static const String incompatibleBloodType = 'error_incompatible_blood_type';
  static const String activeDonationInProgress = 'error_active_donation_in_progress';

  // ── Not Found Errors ──
  static const String appointmentNotFound = 'error_appointment_not_found';
  static const String hospitalNotFound = 'error_hospital_not_found';
  static const String donorNotFound = 'error_donor_not_found';
  static const String requestNotFound = 'error_request_not_found';
  static const String notFound = 'error_not_found';

  // ── Hospital Errors ──
  static const String hospitalSuspended = 'error_hospital_suspended';
  static const String hospitalNotVerified = 'error_hospital_not_verified';

  // ── Server Errors ──
  static const String serverError = 'server_error';
  static const String badResponse = 'bad_response';
  static const String emptyResponse = 'empty_response';
  static const String unknownError = 'unknown_error';
}