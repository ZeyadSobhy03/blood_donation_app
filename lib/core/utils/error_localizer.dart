import 'package:blood_donation_app/l10n/app_localizations.dart';

String mapServerErrorToKey(String? errorMessage) {
  if (errorMessage == null || errorMessage.isEmpty) {
    return 'server_error';
  }

  final lowerMessage = errorMessage.toLowerCase().trim();

  // ── Password Update ──
  if (lowerMessage.contains('currentpassword') && lowerMessage.contains('newpassword') &&
      (lowerMessage.contains('required') || lowerMessage.contains('missing'))) {
    return 'error_current_new_password_required';
  }
  if (lowerMessage.contains('new password must be different') ||
      lowerMessage.contains('same old and new password')) {
    return 'error_new_password_same_as_current';
  }
  if (lowerMessage.contains('current password is required') ||
      lowerMessage.contains('currentpassword') && lowerMessage.contains('missing')) {
    return 'currentPasswordRequired';
  }
  if (lowerMessage.contains('new password is required') ||
      lowerMessage.contains('newpassword') && lowerMessage.contains('missing')) {
    return 'newPasswordRequired';
  }
  if (lowerMessage.contains('password updated successfully')) {
    return 'passwordChangedSuccessfully';
  }

  if (lowerMessage.contains('incorrect') && lowerMessage.contains('current') &&
      lowerMessage.contains('password')) {
    return 'error_incorrect_current_password';
  }
  if (lowerMessage.contains('current') && lowerMessage.contains('password') &&
      (lowerMessage.contains('incorrect') || lowerMessage.contains('wrong') ||
          lowerMessage.contains('invalid'))) {
    return 'error_incorrect_current_password';
  }
  if (lowerMessage.contains('invalid email or password') ||
      lowerMessage.contains('invalid credentials')) {
    return 'error_invalid_credentials';
  }
  if (lowerMessage.contains('password') && lowerMessage.contains('invalid')) {
    return 'error_invalid_password';
  }
  if (lowerMessage.contains('wrong') && lowerMessage.contains('password')) {
    return 'error_wrong_password';
  }

  // ── Email errors ──
  if (lowerMessage.contains('invalid') && lowerMessage.contains('email')) {
    return 'error_invalid_email';
  }
  if (lowerMessage.contains('email') && lowerMessage.contains('already')) {
    return 'error_email_already_exists';
  }
  if (lowerMessage.contains('email') && lowerMessage.contains('not verified')) {
    return 'error_email_not_verified';
  }

  // ── Account errors ──
  if (lowerMessage.contains('account') && lowerMessage.contains('locked')) {
    return 'error_account_locked';
  }
  if (lowerMessage.contains('account') && lowerMessage.contains('disabled')) {
    return 'error_account_disabled';
  }

  // ── Token / Auth errors ──
  if (lowerMessage.contains('token') && lowerMessage.contains('expired')) {
    return 'error_token_expired';
  }
  if (lowerMessage.contains('authorization header is required')) {
    return 'error_authorization_required';
  }
  if (lowerMessage.contains('account is suspended')) {
    return 'error_account_suspended';
  }
  if (lowerMessage.contains('unauthorized')) {
    return 'error_unauthorized';
  }
  if (lowerMessage.contains('forbidden') || lowerMessage.contains('permission')) {
    return 'error_forbidden';
  }

  // ── Appointment booking errors ──
  if (lowerMessage.contains('hospitalid') && lowerMessage.contains('appointmentdate') ||
      lowerMessage.contains('hospital') && lowerMessage.contains('date') &&
          lowerMessage.contains('required')) {
    return 'error_hospital_id_date_required';
  }
  if (lowerMessage.contains('invalid donation type')) {
    return 'error_invalid_donation_type';
  }
  if (lowerMessage.contains('appointment date must be in the future') ||
      lowerMessage.contains('new appointment date must be in the future')) {
    return 'error_appointment_date_future';
  }
  if (lowerMessage.contains('appointment date is invalid')) {
    return 'error_appointment_date_invalid';
  }
  if (lowerMessage.contains('at least') && lowerMessage.contains('hours') &&
      lowerMessage.contains('advance')) {
    return 'error_appointment_min_hours';
  }
  if (lowerMessage.contains('more than') && lowerMessage.contains('days') &&
      lowerMessage.contains('advance')) {
    return 'error_appointment_max_days';
  }
  if (lowerMessage.contains('selected day') && lowerMessage.contains('not available')) {
    return 'error_day_not_available';
  }
  if (lowerMessage.contains('scheduling') && lowerMessage.contains('disabled')) {
    return 'error_hospital_scheduling_disabled';
  }
  if (lowerMessage.contains('does not support') && lowerMessage.contains('donation type')) {
    return 'error_hospital_donation_type_not_supported';
  }
  if (lowerMessage.contains('invalid donor or hospital')) {
    return 'error_invalid_donor_or_hospital';
  }
  if (lowerMessage.contains('invalid request id') ||
      lowerMessage.contains('invalid request')) {
    return 'error_invalid_request_id';
  }
  if (lowerMessage.contains('request') && lowerMessage.contains('not belong')) {
    return 'error_request_not_belong_hospital';
  }
  if (lowerMessage.contains('request') && lowerMessage.contains('no longer active') ||
      lowerMessage.contains('linked request') && lowerMessage.contains('active')) {
    return 'error_request_no_longer_active';
  }
  if (lowerMessage.contains('request') && lowerMessage.contains('already cancelled') ||
      lowerMessage.contains('already_cancelled')) {
    return 'error_already_cancelled';
  }
  if (lowerMessage.contains('outside operating hours')) {
    return 'error_outside_operating_hours';
  }
  if (lowerMessage.contains('time slot') && lowerMessage.contains('no longer available')) {
    return 'error_time_slot_not_available';
  }
  if (lowerMessage.contains('daily') && lowerMessage.contains('capacity')) {
    return 'error_daily_capacity_reached';
  }

  // ── Donor eligibility errors ──
  if (lowerMessage.contains('donor') && lowerMessage.contains('unavailable')) {
    return 'error_donor_unavailable';
  }
  if (lowerMessage.contains('donor') && lowerMessage.contains('suspended')) {
    return 'error_donor_suspended';
  }
  if (lowerMessage.contains('cooldown')) {
    return 'error_donor_cooldown';
  }
  if (lowerMessage.contains('incompatible blood type') ||
      lowerMessage.contains('blood type')) {
    return 'error_incompatible_blood_type';
  }
  if (lowerMessage.contains('active donation') && lowerMessage.contains('progress')) {
    return 'error_active_donation_in_progress';
  }

  // ── Conflict errors ──
  if (lowerMessage.contains('appointment_already_exists') ||
      lowerMessage.contains('already has an active appointment') ||
      lowerMessage.contains('already have an active appointment')) {
    return 'error_appointment_already_exists';
  }

  // ── Reschedule specific errors ──
  if (lowerMessage.contains('appointmentid') && lowerMessage.contains('required') ||
      lowerMessage.contains('appointment id') && lowerMessage.contains('required')) {
    return 'error_appointment_id_required';
  }
  if (lowerMessage.contains('date') && lowerMessage.contains('required') &&
      !lowerMessage.contains('appointment')) {
    return 'error_date_required';
  }
  if (lowerMessage.contains('invalid appointment id')) {
    return 'error_invalid_appointment_id';
  }
  if (lowerMessage.contains('only pending or confirmed')) {
    return 'error_only_pending_confirmed_reschedule';
  }
  if (lowerMessage.contains('must be different') ||
      lowerMessage.contains('same details') ||
      lowerMessage.contains('different from the current')) {
    return 'error_reschedule_same_details';
  }
  if (lowerMessage.contains('maximum number of reschedules') ||
      lowerMessage.contains('max') && lowerMessage.contains('reschedule')) {
    return 'error_max_reschedules_reached';
  }
  if (lowerMessage.contains('does not allow rescheduling') ||
      lowerMessage.contains('allow reschedul')) {
    return 'error_hospital_no_rescheduling';
  }
  if (lowerMessage.contains('reschedule') && lowerMessage.contains('hours') &&
      lowerMessage.contains('advance')) {
    return 'error_reschedule_min_hours';
  }
  if (lowerMessage.contains('reschedule') && lowerMessage.contains('days') &&
      lowerMessage.contains('advance')) {
    return 'error_reschedule_max_days';
  }

  // ── Reward & Points errors ──
  if (lowerMessage.contains('reward') && lowerMessage.contains('name') &&
      lowerMessage.contains('category') && lowerMessage.contains('mandatory')) {
    return 'error_reward_fields_required';
  }
  if (lowerMessage.contains('status is required')) {
    return 'error_status_required';
  }
  if (lowerMessage.contains('status must be active, inactive, or limited')) {
    return 'error_invalid_status_value';
  }
  if (lowerMessage.contains('reward not found')) {
    return 'error_reward_not_found';
  }
  if (lowerMessage.contains('updates array must have at least one entry')) {
    return 'error_bulk_points_empty';
  }
  if (lowerMessage.contains('each update must have an id and points required number')) {
    return 'error_bulk_points_invalid_update';
  }
  if (lowerMessage.contains('email, amount, and reason are required')) {
    return 'error_adjustment_fields_required';
  }
  if (lowerMessage.contains('amount must be a non-zero number')) {
    return 'error_amount_non_zero';
  }
  if (lowerMessage.contains('only donor accounts have points')) {
    return 'error_only_donors_have_points';
  }

  // ── Earning Rule errors ──
  if (lowerMessage.contains('type, title, points, and category are required')) {
    return 'error_earning_rule_fields_required';
  }
  if (lowerMessage.contains('points must be a non-negative number')) {
    return 'error_points_non_negative';
  }
  if (lowerMessage.contains('invalid rule type')) {
    return 'error_invalid_rule_type';
  }
  if (lowerMessage.contains('earning rule already exists')) {
    return 'error_earning_rule_exists';
  }
  if (lowerMessage.contains('earning rule not found')) {
    return 'error_earning_rule_not_found';
  }

  // ── Hospital status errors ──
  if (lowerMessage.contains('hospital') && lowerMessage.contains('suspended')) {
    return 'error_hospital_suspended';
  }
  if (lowerMessage.contains('hospital') && lowerMessage.contains('not verified')) {
    return 'error_hospital_not_verified';
  }

  // ── Not found errors ──
  if (lowerMessage.contains('appointment') && lowerMessage.contains('not found')) {
    return 'error_appointment_not_found';
  }
  if (lowerMessage.contains('hospital') && lowerMessage.contains('not found')) {
    return 'error_hospital_not_found';
  }
  if (lowerMessage.contains('donor') && lowerMessage.contains('not found')) {
    return 'error_donor_not_found';
  }
  if (lowerMessage.contains('request') && lowerMessage.contains('not found')) {
    return 'error_request_not_found';
  }
  if (lowerMessage.contains('user') && lowerMessage.contains('not found')) {
    return 'error_user_not_found';
  }
  if (lowerMessage.contains('not found')) {
    return 'error_not_found';
  }

  if (lowerMessage.contains('maintenance') && lowerMessage.contains('updated')) {
    return 'system_status_updated_successfully';
  }

  // ── Validation / fallback ──
  if (lowerMessage.contains('validation') || lowerMessage.contains('invalid')) {
    return 'error_validation';
  }

  return 'server_error';
}

String localizeError(String errorKey, AppLocalizations loc) {
  switch (errorKey) {
    case 'connection_timeout':
    case 'network_timeout':
      return loc.connection_timeout;
    case 'no_internet':
      return loc.no_internet;
    case 'request_cancelled':
      return loc.request_cancelled;

  // ── Authentication Errors ──
    case 'error_invalid_credentials':
      return loc.error_invalid_credentials;
    case 'error_invalid_email':
      return loc.error_invalid_email;
    case 'error_invalid_password':
      return loc.error_invalid_password;
    case 'error_wrong_password':
      return loc.error_wrong_password;
    case 'error_incorrect_current_password':
      return loc.error_incorrect_current_password;
    case 'error_user_not_found':
      return loc.error_user_not_found;
    case 'error_email_already_exists':
      return loc.error_email_already_exists;
    case 'error_account_locked':
      return loc.error_account_locked;
    case 'error_account_disabled':
      return loc.error_account_disabled;
    case 'error_current_new_password_required':
      return loc.error_current_new_password_required;
    case 'currentPasswordRequired':
      return loc.currentPasswordRequired;
    case 'newPasswordRequired':
      return loc.newPasswordRequired;
    case 'error_new_password_same_as_current':
      return loc.error_new_password_same_as_current;
    case 'passwordChangedSuccessfully':
      return loc.passwordChangedSuccessfully;

    case 'error_reschedule_same_details':
      return loc.error_reschedule_same_details;
    case 'error_email_not_verified':
      return loc.error_email_not_verified;
    case 'error_token_expired':
      return loc.error_token_expired;
    case 'unauthorized':
    case 'error_unauthorized':
      return loc.error_unauthorized;
    case 'error_forbidden':
      return loc.error_forbidden;

  // ── Validation Errors ──
    case 'email_error':
      return loc.email_error;
    case 'password_error':
      return loc.password_error;
    case 'error_validation':
      return loc.error_validation;

    case 'error_hospital_id_date_required':
      return loc.error_hospital_id_date_required;
    case 'error_invalid_donation_type':
      return loc.error_invalid_donation_type;
    case 'error_appointment_date_future':
      return loc.error_appointment_date_future;
    case 'error_appointment_date_invalid':
      return loc.error_appointment_date_invalid;
    case 'error_appointment_min_hours':
      return loc.error_appointment_min_hours;
    case 'error_appointment_max_days':
      return loc.error_appointment_max_days;
    case 'error_day_not_available':
      return loc.error_day_not_available;
    case 'error_hospital_scheduling_disabled':
      return loc.error_hospital_scheduling_disabled;
    case 'error_hospital_donation_type_not_supported':
      return loc.error_hospital_donation_type_not_supported;
    case 'error_invalid_donor_or_hospital':
      return loc.error_invalid_donor_or_hospital;
    case 'error_invalid_request_id':
      return loc.error_invalid_request_id;
    case 'error_request_not_belong_hospital':
      return loc.error_request_not_belong_hospital;
    case 'error_request_no_longer_active':
      return loc.error_request_no_longer_active;
    case 'error_outside_operating_hours':
      return loc.error_outside_operating_hours;
    case 'error_time_slot_not_available':
      return loc.error_time_slot_not_available;
    case 'error_daily_capacity_reached':
      return loc.error_daily_capacity_reached;
    case 'error_appointment_already_exists':
      return loc.error_appointment_already_exists;

  // ── Donor Eligibility Errors ──
    case 'error_donor_unavailable':
      return loc.error_donor_unavailable;
    case 'error_donor_suspended':
      return loc.error_donor_suspended;
    case 'error_donor_cooldown':
      return loc.error_donor_cooldown;
    case 'error_incompatible_blood_type':
      return loc.error_incompatible_blood_type;
    case 'error_active_donation_in_progress':
      return loc.error_active_donation_in_progress;

  // ── Reschedule Errors ──
    case 'error_appointment_id_required':
      return loc.error_appointment_id_required;
    case 'error_date_required':
      return loc.error_date_required;
    case 'error_invalid_appointment_id':
      return loc.error_invalid_appointment_id;
    case 'error_only_pending_confirmed_reschedule':
      return loc.error_only_pending_confirmed_reschedule;
    case 'error_reschedule_date_future':
      return loc.error_reschedule_date_future;
    case 'error_reschedule_same_details':
      return loc.error_reschedule_same_details;
    case 'error_max_reschedules_reached':
      return loc.error_max_reschedules_reached;
    case 'error_hospital_no_rescheduling':
      return loc.error_hospital_no_rescheduling;
    case 'error_reschedule_min_hours':
      return loc.error_reschedule_min_hours;
    case 'error_reschedule_max_days':
      return loc.error_reschedule_max_days;

  // ── Not Found Errors ──
    case 'error_appointment_not_found':
      return loc.error_appointment_not_found;
    case 'error_hospital_not_found':
      return loc.error_hospital_not_found;
    case 'error_donor_not_found':
      return loc.error_donor_not_found;
    case 'error_request_not_found':
      return loc.error_request_not_found;
    case 'error_not_found':
      return loc.error_not_found;

  // ── Hospital Errors ──
    case 'error_hospital_suspended':
      return loc.error_hospital_suspended;
    case 'error_hospital_not_verified':
      return loc.error_hospital_not_verified;

  // ── Auth & Account Errors ──
    case 'error_authorization_required':
      return loc.error_authorization_required;
    case 'error_account_suspended':
      return loc.error_account_suspended;

  // ── Reward & Points Errors ──
    case 'error_reward_fields_required':
      return loc.error_reward_fields_required;
    case 'error_status_required':
      return loc.error_status_required;
    case 'error_invalid_status_value':
      return loc.error_invalid_status_value;
    case 'error_reward_not_found':
      return loc.error_reward_not_found;
    case 'error_bulk_points_empty':
      return loc.error_bulk_points_empty;
    case 'error_bulk_points_invalid_update':
      return loc.error_bulk_points_invalid_update;
    case 'error_adjustment_fields_required':
      return loc.error_adjustment_fields_required;
    case 'error_amount_non_zero':
      return loc.error_amount_non_zero;
    case 'error_only_donors_have_points':
      return loc.error_only_donors_have_points;

  // ── Earning Rule Errors ──
    case 'error_earning_rule_fields_required':
      return loc.error_earning_rule_fields_required;
    case 'error_points_non_negative':
      return loc.error_points_non_negative;
    case 'error_invalid_rule_type':
      return loc.error_invalid_rule_type;
    case 'error_earning_rule_exists':
      return loc.error_earning_rule_exists;
    case 'error_earning_rule_not_found':
      return loc.error_earning_rule_not_found;

  // ── Request Errors ──
    case 'error_already_cancelled':
      return loc.error_already_cancelled;

    case 'system_status_updated_successfully':
      return loc.system_status_updated_successfully;

    case 'server_error':
    case 'bad_response':
      return loc.server_error;
    case 'empty_response':
      return loc.empty_response;
    case 'unknown_error':
    default:
      return loc.unknown_error;
  }
}