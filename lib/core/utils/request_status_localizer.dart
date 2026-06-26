import 'package:blood_donation_app/l10n/app_localizations.dart';

class RequestStatusLocalizer {

  static String localizeStatus(String rawStatus, AppLocalizations loc) {
    final status = rawStatus.toLowerCase().trim();

    if (status.contains('cancelled')) {
      return loc.requestCancelled;
    } else if (status.contains('broadcast')) {
      return loc.broadcastSent;
    } else if (status.contains('fulfilled')) {
      return loc.requestFulfilled;
    }

    return rawStatus;
  }
}