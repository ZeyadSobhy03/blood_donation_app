import 'package:blood_donation_app/l10n/app_localizations.dart';

String localizeError(String errorKey, AppLocalizations loc) {
  switch (errorKey) {
    case 'network_timeout':
      return loc.error_network_timeout;
    case 'server_error':
      return loc.error_server;
    case 'unauthorized':
      return loc.error_unauthorized;
    case 'not_found':
      return loc.error_not_found;
    case 'request_cancelled':
      return loc.error_request_cancelled;
    default:
      return loc.error_unknown;
  }
}