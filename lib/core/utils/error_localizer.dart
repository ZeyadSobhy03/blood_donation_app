import 'package:blood_donation_app/l10n/app_localizations.dart';

String mapServerErrorToKey(String? errorMessage) {
  if (errorMessage == null || errorMessage.isEmpty) {
    return 'server_error';
  }

  final lowerMessage = errorMessage.toLowerCase().trim();

  if (lowerMessage.contains('password') && lowerMessage.contains('invalid')) {
    return 'error_invalid_password';
  }
  if (lowerMessage.contains('wrong') && lowerMessage.contains('password')) {
    return 'error_wrong_password';
  }
  if (lowerMessage.contains('incorrect') && lowerMessage.contains('current') &&
      lowerMessage.contains('password')) {
    return 'error_incorrect_current_password';
  }
  if (lowerMessage.contains('current') && (lowerMessage.contains('password') &&
      (lowerMessage.contains('incorrect') || lowerMessage.contains('wrong') ||
       lowerMessage.contains('invalid')))) {
    return 'error_incorrect_current_password';
  }
  if (lowerMessage.contains('invalid email or password') ||
      lowerMessage.contains('invalid credentials')) {
    return 'error_invalid_credentials';
  }

  if (lowerMessage.contains('invalid') && lowerMessage.contains('email')) {
    return 'error_invalid_email';
  }
  if (lowerMessage.contains('email') && lowerMessage.contains('already')) {
    return 'error_email_already_exists';
  }
  if (lowerMessage.contains('email') && lowerMessage.contains('not verified')) {
    return 'error_email_not_verified';
  }

  if (lowerMessage.contains('user') && lowerMessage.contains('not found')) {
    return 'error_user_not_found';
  }
  if (lowerMessage.contains('account') && lowerMessage.contains('locked')) {
    return 'error_account_locked';
  }
  if (lowerMessage.contains('account') && lowerMessage.contains('disabled')) {
    return 'error_account_disabled';
  }

  if (lowerMessage.contains('token') && lowerMessage.contains('expired')) {
    return 'error_token_expired';
  }
  if (lowerMessage.contains('unauthorized')) {
    return 'unauthorized';
  }

  if (lowerMessage.contains('forbidden') ||
      lowerMessage.contains('permission')) {
    return 'error_forbidden';
  }

  if (lowerMessage.contains('not found')) {
    return 'error_not_found';
  }

  if (lowerMessage.contains('validation') ||
      lowerMessage.contains('invalid')) {
    return 'error_validation';
  }

  return 'server_error';
}

String localizeError(String errorKey, AppLocalizations loc) {
  switch (errorKey) {
    case 'connection_timeout':
    case 'network_timeout':
      return loc.error_network_timeout;

    case 'no_internet':
      return loc.noInternet;

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

    case 'error_email_not_verified':
      return loc.error_email_not_verified;

    case 'error_validation':
      return loc.error_validation;

    case 'error_forbidden':
      return loc.error_forbidden;

    case 'error_token_expired':
      return loc.error_token_expired;

    case 'unauthorized':
      return loc.error_unauthorized;

    case 'error_not_found':
      return loc.error_not_found;

    case 'request_cancelled':
      return loc.error_request_cancelled;

    case 'server_error':
    case 'bad_response':
      return loc.error_server;

    case 'empty_response':
      return loc.emptyResponse;

    case 'unknown_error':
    default:
      return loc.error_unknown;
  }
}