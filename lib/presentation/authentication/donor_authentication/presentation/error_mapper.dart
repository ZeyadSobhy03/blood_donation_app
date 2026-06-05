import 'package:blood_donation_app/core/utils/error_localizer.dart';
import '../../../../l10n/app_localizations.dart';

class ErrorMapper {
  static String map(String errorKey, AppLocalizations loc) {
    if (errorKey.contains(' ') || errorKey.length > 30) {
      final mappedKey = mapServerErrorToKey(errorKey);
      return localizeError(mappedKey, loc);
    }

    return localizeError(errorKey, loc);
  }
}