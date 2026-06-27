import 'package:blood_donation_app/l10n/app_localizations.dart';

class EarningRuleLocalizer {

  static String localizeCategory(String? category, AppLocalizations loc) {
    if (category == null || category.isEmpty) return '';

    switch (category.toLowerCase().trim()) {
      case 'donation': return loc.categoryDonation;
      case 'referral': return loc.categoryReferral;
      case 'registration': return loc.categoryRegistration;
      case 'other': return loc.categoryOther;
      default: return category;
    }
  }

  static String localizeType(String? type, AppLocalizations loc) {
    if (type == null || type.isEmpty) return '';

    final lowerType = type.toLowerCase().trim();
    if (lowerType.contains('blooddonation') || lowerType.contains('blood_donation')) return loc.ruleBloodDonation;
    if (lowerType.contains('doubleredcells') || lowerType.contains('double_red')) return loc.ruleDoubleRedCells;
    if (lowerType.contains('plasma')) return loc.rulePlasmaDonation;
    if (lowerType.contains('platelet')) return loc.rulePlateletsDonation;

    return type;
  }

  static String localizeTitle(String? title, AppLocalizations loc) {
    if (title == null || title.isEmpty) return '';

    final lowerTitle = title.toLowerCase().trim();
    if (lowerTitle.contains('blood donation')) return loc.ruleBloodDonation;
    if (lowerTitle.contains('double red')) return loc.ruleDoubleRedCells;
    if (lowerTitle.contains('plasma donation')) return loc.rulePlasmaDonation;
    if (lowerTitle.contains('platelet donation') || lowerTitle.contains('platelets donation')) return loc.rulePlateletsDonation;

    return title;
  }
}