import 'package:blood_donation_app/l10n/app_localizations.dart';

String localizeMonthLabel(String raw, AppLocalizations loc) {
  switch (raw.trim().toLowerCase()) {
    case 'jan':
      return loc.jan;
    case 'feb':
      return loc.feb;
    case 'mar':
      return loc.mar;
    case 'apr':
      return loc.apr;
    case 'may':
      return loc.may;
    case 'jun':
      return loc.jun;
    case 'jul':
      return loc.jul;
    case 'aug':
      return loc.aug;
    case 'sep':
      return loc.sep;
    case 'oct':
      return loc.oct;
    case 'nov':
      return loc.nov;
    case 'dec':
      return loc.dec;
    default:
      return raw;
  }
}

List<String> localizeMonthLabels(List<String> raw, AppLocalizations loc) {
  return raw.map((m) => localizeMonthLabel(m, loc)).toList();
}