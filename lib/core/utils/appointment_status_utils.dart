import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppointmentStatusUtils {
  AppointmentStatusUtils._();

  static String localizeStatus(String? status, AppLocalizations loc) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return loc.pending;
      case 'confirmed':
        return loc.confirmed;
      case 'completed':
        return loc.completed;
      case 'cancelled':
        return loc.cancelled;
      case 'rescheduled':
        return loc.rescheduled;
      default:
        return status ?? loc.unknown;
    }
  }

  static Color statusBackgroundColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange.withValues(alpha: 0.2);
      case 'confirmed':
        return ColorManger.green.withValues(alpha: 0.2);
      case 'completed':
        return Colors.green.shade200;
      case 'cancelled':
        return Colors.red.shade200;
      case 'rescheduled':
        return Colors.orange.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  static Color statusTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return ColorManger.green;
      case 'completed':
        return Colors.green.shade700;
      case 'cancelled':
        return ColorManger.brightRed;
      case 'rescheduled':
        return Colors.orange.shade700;
      default:
        return ColorManger.slateGrey;
    }
  }
}