import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

class LocalizedInsight {
  final String title;
  final String description;

  LocalizedInsight({required this.title, required this.description});
}

LocalizedInsight localizeInsight(
    BuildContext context,
    String title,
    String description,
    ) {
  final appLocalization = AppLocalizations.of(context);
  if (appLocalization == null) {
    return LocalizedInsight(title: title, description: description);
  }

  final variables = parseVariablesFromDescription(description);
  final localizedTitle = localizeInsightTitle(context, title);
  final localizedDescription = localizeInsightDescription(
    context,
    title,
    description,
    variables,
  );

  return LocalizedInsight(title: localizedTitle, description: localizedDescription);
}

String localizeInsightTitle(BuildContext context, String title) {
  final appLocalization = AppLocalizations.of(context);
  if (appLocalization == null) return title;

  final key = getLocalizationKeyFromTitle(title);
  if (key.isEmpty) return title;

  return _getLocalizedString(appLocalization, key, null) ?? title;
}

String localizeInsightDescription(
    BuildContext context,
    String title,
    String description,
    Map<String, dynamic> variables,
    ) {
  final appLocalization = AppLocalizations.of(context);
  if (appLocalization == null) return description;

  final titleKey = getLocalizationKeyFromTitle(title);
  if (titleKey.isEmpty) return description;

  final descKey = getDescriptionLocalizationKey(titleKey);
  return _getLocalizedString(appLocalization, descKey, variables) ?? description;
}

String getLocalizationKeyFromTitle(String title) {
  final titleToKeyMap = {
    'Predicted High Demand': 'predictedHighDemand',
    'Rising Demand Trend': 'risingDemandTrend',
    'Declining Demand': 'decliningDemand',
    'Shortage Risk': 'shortageRisk',
    'Supply Warning': 'supplyWarning',
    'Peak Day Insight': 'peakDayInsight',
    'Donor Retention Alert': 'donorRetentionAlert',
    'Donor Growth Positive': 'donorGrowthPositive',
    'Emergency Demand Spike': 'emergencyDemandSpike',
  };

  if (titleToKeyMap.containsKey(title)) return titleToKeyMap[title]!;

  for (var entry in titleToKeyMap.entries) {
    if (title.contains(entry.key)) return entry.value;
  }

  return '';
}

String getDescriptionLocalizationKey(String titleKey) {
  return '${titleKey}Desc';
}

Map<String, dynamic> parseVariablesFromDescription(String description) {
  final variables = <String, dynamic>{};

  final percentMatch = RegExp(r'(\d+)%').firstMatch(description);
  if (percentMatch != null) {
    variables['growthRate'] = percentMatch.group(1);
    variables['percentage'] = percentMatch.group(1);
  }

  final bloodTypeMatch = RegExp(
    r'(O\+|O\-|A\+|A\-|B\+|B\-|AB\+|AB\-)',
  ).firstMatch(description);
  if (bloodTypeMatch != null) {
    variables['bloodType'] = bloodTypeMatch.group(1);
    variables['bloodTypes'] = bloodTypeMatch.group(1);
  }

  final days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  for (var day in days) {
    if (description.contains(day)) {
      variables['dayName'] = day;
      break;
    }
  }

  final numberMatches = RegExp(r'\d+').allMatches(description);
  if (numberMatches.isNotEmpty) {
    variables['value'] = numberMatches.first.group(0);
  }

  return variables;
}

String _getLocalizedDay(AppLocalizations l10n, String englishDay) {
  switch (englishDay) {
    case 'Monday': return l10n.monday;
    case 'Tuesday': return l10n.tuesday;
    case 'Wednesday': return l10n.wednesday;
    case 'Thursday': return l10n.thursday;
    case 'Friday': return l10n.friday;
    case 'Saturday': return l10n.saturday;
    case 'Sunday': return l10n.sunday;
    default: return englishDay;
  }
}

String? _getLocalizedString(
    AppLocalizations appLocalization,
    String key,
    Map<String, dynamic>? variables,
    ) {
  switch (key) {
    case 'predictedHighDemand': return appLocalization.predictedHighDemand;
    case 'risingDemandTrend': return appLocalization.risingDemandTrend;
    case 'decliningDemand': return appLocalization.decliningDemand;
    case 'shortageRisk': return appLocalization.shortageRisk;
    case 'supplyWarning': return appLocalization.supplyWarning;
    case 'peakDayInsight': return appLocalization.peakDayInsight;
    case 'donorRetentionAlert': return appLocalization.donorRetentionAlert;
    case 'donorGrowthPositive': return appLocalization.donorGrowthPositive;
    case 'emergencyDemandSpike': return appLocalization.emergencyDemandSpike;

    case 'risingDemandTrendDesc': return appLocalization.risingDemandTrendDesc;
    case 'decliningDemandDesc': return appLocalization.decliningDemandDesc;
    case 'donorRetentionAlertDesc': return appLocalization.donorRetentionAlertDesc;
    case 'donorGrowthPositiveDesc': return appLocalization.donorGrowthPositiveDesc;
    case 'emergencyDemandSpikeDesc': return appLocalization.emergencyDemandSpikeDesc;

    case 'predictedHighDemandDesc':
      return appLocalization.predictedHighDemandDesc;

    case 'shortageRiskDesc':
      return appLocalization.shortageRiskDesc;

    case 'supplyWarningDesc':
      return appLocalization.supplyWarningDesc(
        variables?['bloodType']?.toString() ?? '',
      );

    case 'peakDayInsightDesc':
    // 1. Get the English day name from variables
      final englishDay = variables?['dayName']?.toString() ?? '';
      // 2. Translate it to Arabic (or keep English if locale is En)
      final localizedDay = _getLocalizedDay(appLocalization, englishDay);

      // 3. Pass the translated day to the description function
      return appLocalization.peakDayInsightDesc(
        localizedDay,
        variables?['percentage']?.toString() ?? '',
      );

    default:
      return null;
  }
}