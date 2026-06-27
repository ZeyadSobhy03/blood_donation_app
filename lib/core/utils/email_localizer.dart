import '../../l10n/app_localizations.dart';

class EmailLocalizer {
 static String localizeStatus(String? status, AppLocalizations l10n) {
    switch (status) {
      case 'OPEN':
        return l10n.statusOpen;
      case 'REVIEWED':
        return l10n.statusReviewed;
      case 'CLOSED':
        return l10n.statusClosed;
      default:
        return status ?? ''; // Fallback to raw string if unknown
    }
  }

 static String localizeCategory(String? category, AppLocalizations l10n) {
    switch (category) {
      case 'TECHNICAL':
        return l10n.categoryTechnical;
      case 'ACCOUNT':
        return l10n.categoryAccount;
      case 'DONATION':
        return l10n.categoryDonation;
      case 'REWARDS':
        return l10n.categoryRewards;
      case 'OTHER':
        return l10n.categoryOther;
      default:
        return category ?? ''; // Fallback to raw string if unknown
    }
  }
}