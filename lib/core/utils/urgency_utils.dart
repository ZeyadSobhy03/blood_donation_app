import 'package:flutter/material.dart';

import '../resources/colors/color_manger.dart';
import '../../l10n/app_localizations.dart';

class UrgencyUtils {

  static Color getBadgeColor(String urgencyLevel) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return ColorManger.brightRed;
      case 'high':
        return ColorManger.orange;
      case 'medium':
        return ColorManger.amber;
      case 'low':
        return ColorManger.green;
      default:
        return ColorManger.grey500;
    }
  }

  static Color getBackgroundColor(String urgencyLevel) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return ColorManger.lightRed;
      case 'high':
        return ColorManger.lightOrange;
      case 'medium':
        return ColorManger.lightAmber;
      case 'low':
        return ColorManger.lightGreen;
      default:
        return ColorManger.lightGrey;
    }
  }

  static String getBadgeLabel(String urgencyLevel, AppLocalizations appLocalizations) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return appLocalizations.critical;
      case 'high':
        return appLocalizations.high;
      case 'medium':
        return appLocalizations.medium;
      case 'low':
        return appLocalizations.low;
      default:
        return appLocalizations.unknown;
    }
  }
}