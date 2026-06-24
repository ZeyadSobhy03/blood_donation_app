import 'package:blood_donation_app/l10n/app_localizations.dart';

String localizeTier(String? tier, AppLocalizations loc) {
  switch (tier?.toLowerCase()) {
    case 'bronze':
      return loc.bronze;
    case 'silver':
      return loc.silver;
    case 'gold':
      return loc.gold;
    case 'platinum':
      return loc.platinum;
    default:
      return tier ?? '';
  }
}