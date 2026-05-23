import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String localizeStatus(String status, AppLocalizations loc) {
  switch (status) {
    case 'completed':
      return loc.completed;
    case 'pending':
      return loc.pending;
    case 'cancelled':
      return loc.cancelled;
    default:
      return status;
  }
}

Color statusTextColor(String status) {
  switch (status) {
    case 'completed':
      return ColorManger.lightGreen;
    case 'pending':
      return Colors.orange;
    case 'cancelled':
      return ColorManger.brightRed;
    default:
      return ColorManger.slateGrey;
  }
}

Color statusBackgroundColor(String status) {
  switch (status) {
    case 'completed':
      return ColorManger.lightGreen.withValues(alpha: 0.2);
    case 'pending':
      return Colors.orange.withValues(alpha: 0.2);
    case 'cancelled':
      return ColorManger.lightRed;
    default:
      return ColorManger.lightGrey;
  }
}