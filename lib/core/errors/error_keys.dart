class ErrorKeys {
  // Network Errors
  static const connectionTimeout = 'connection_timeout';
  static const noInternet = 'no_internet';
  static const networkTimeout = 'network_timeout';
  static const requestCancelled = 'request_cancelled';

  // Server Errors
  static const serverError = 'server_error';
  static const invalidCredentials = 'error_invalid_credentials';
  static const invalidEmail = 'error_invalid_email';
  static const invalidPassword = 'error_invalid_password';
  static const wrongPassword = 'error_wrong_password';
  static const incorrectCurrentPassword = 'error_incorrect_current_password';
  static const userNotFound = 'error_user_not_found';
  static const emailAlreadyExists = 'error_email_already_exists';
  static const accountLocked = 'error_account_locked';
  static const accountDisabled = 'error_account_disabled';
  static const emailNotVerified = 'error_email_not_verified';

  // Validation Errors
  static const emailError = 'email_error';
  static const passwordError = 'password_error';
  static const validationError = 'error_validation';

  // Auth Errors
  static const unauthorized = 'unauthorized';
  static const forbidden = 'error_forbidden';
  static const tokenExpired = 'error_token_expired';
  static const notFound = 'error_not_found';

  // Generic Errors
  static const unknown = 'unknown_error';
  static const emptyResponse = 'empty_response';
}