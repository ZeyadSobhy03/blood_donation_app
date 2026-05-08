
import '../../../../l10n/app_localizations.dart';

class ErrorMapper {
  static String map(String errorKey, AppLocalizations loc) {
    switch (errorKey) {
      case 'CONNECTION_TIMEOUT':
        return loc.connectionTimeout;

      case 'SEND_TIMEOUT':
        return loc.sendTimeout;

      case 'RECEIVE_TIMEOUT':
        return loc.receiveTimeout;

      case 'NO_INTERNET':
        return loc.noInternet;

      case 'REQUEST_CANCELLED':
        return loc.requestCancelled;

      case 'BAD_RESPONSE':
      case 'SERVER_ERROR':
        return loc.serverError;

      case 'EMPTY_RESPONSE':
        return loc.emptyResponse;

      default:
        return loc.unknownError;
    }
  }
}