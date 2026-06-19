import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';
import '../resources/colors/color_manger.dart';
import '../resources/constant/constant_manger.dart';

class AlertStatus {
  static const String _unknown = 'unknown';

  static String normalizeType(String type) {
    switch (type.toLowerCase()) {
      case 'critical':
      case 'حرج':
        return ConstantManager.critical;
      case 'system':
      case 'نظام':
        return ConstantManager.system;
      case 'emergency':
      case 'عاجل':
        return ConstantManager.emergency;
      default:
        return _unknown;
    }
  }

  static String getLabel(String type, BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final normalizedType = normalizeType(type);

    if (normalizedType == ConstantManager.critical) {
      return appLocalization.critical;
    } else if (normalizedType == ConstantManager.system) {
      return appLocalization.system;
    } else if (normalizedType == ConstantManager.emergency) {
      return appLocalization.emergency;
    } else {
      return appLocalization.unknown;
    }
  }

  static Color getColor(String type) {
    switch (normalizeType(type)) {
      case ConstantManager.critical:
        return ColorManger.orange;
      case ConstantManager.system:
        return ColorManger.yellow;
      case ConstantManager.emergency:
        return ColorManger.brightRed;
      default:
        return ColorManger.grey500;
    }
  }

  static Color getBackgroundColor(String type) {
    switch (normalizeType(type)) {
      case ConstantManager.critical:
        return ColorManger.lightOrange;
      case ConstantManager.system:
        return ColorManger.lightYellow;
      case ConstantManager.emergency:
        return ColorManger.lightRed;
      default:
        return ColorManger.grey100;
    }
  }
}