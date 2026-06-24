import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class TierUtils {
  TierUtils._();

  static Color getColorForTier(String tierName) {
    switch (tierName.toLowerCase()) {
      case 'bronze':
        return ColorManger.bronze;
      case 'silver':
        return ColorManger.silver;
      case 'gold':
        return ColorManger.gold;
      case 'platinum':
        return ColorManger.brightPurple;
      default:
        return ColorManger.slateGrey;
    }
  }
}