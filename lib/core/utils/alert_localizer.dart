import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

class LocalizedAlert {
  final String title;
  final String description;
  final String type;

  LocalizedAlert({
    required this.title,
    required this.description,
    required this.type,
  });
}

LocalizedAlert localizeAlert(
    BuildContext context,
    String rawTitle,
    String rawDescription,
    String rawType,
    ) {
  final appLocalization = AppLocalizations.of(context);
  if (appLocalization == null) {
    return LocalizedAlert(title: rawTitle, description: rawDescription, type: rawType);
  }

  final bloodTypes = _extractBloodTypes("$rawTitle $rawDescription");

  String localizedTitle = rawTitle;
  if (rawTitle.toLowerCase().contains('critical need for')) {
    localizedTitle = appLocalization.alertTitle(bloodTypes);
  }

  String localizedDescription = rawDescription;
  if (rawDescription.toLowerCase().contains('critical request for')) {
    localizedDescription = appLocalization.alertDescription(bloodTypes);
  }

  String localizedType = rawType;
  if (rawType.toLowerCase() == 'critical') {
    localizedType = appLocalization.typeCritical;
  } else if (rawType.toLowerCase() == 'warning') {
    localizedType = appLocalization.typeWarning;
  }

  return LocalizedAlert(
    title: localizedTitle,
    description: localizedDescription,
    type: localizedType,
  );
}

String _extractBloodTypes(String text) {
  final bloodTypeMatches = RegExp(r'(A\+|A\-|B\+|B\-|AB\+|AB\-|O\+|O\-)').allMatches(text);

  if (bloodTypeMatches.isEmpty) return '';

  return bloodTypeMatches.map((m) => m.group(0)).toSet().join(', ');
}