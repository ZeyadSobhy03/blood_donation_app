import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart'; // عدّل المسار حسب مشروعك

extension DateTimeEx on DateTime {
  String toDateOnly({String? locale}) {
    return DateFormat('dd MMM yyyy', locale).format(this);
  }

  String toDateOnlyWithDay({String? locale}) {
    return DateFormat('EEEE, dd MMM yyyy', locale).format(this);
  }

  String toDateOnlyNumeric({String? locale}) {
    return DateFormat('dd/MM/yyyy', locale).format(this);
  }

  String toDateTime({String? locale}) {
    return DateFormat('dd MMM yyyy, hh:mm a', locale).format(this);
  }

  String toTimeOnly({String? locale}) {
    return DateFormat('hh:mm a', locale).format(this);
  }

  String toTimeAgo(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return appLocalization.just_now;
    } else if (difference.inMinutes < 60) {
      return appLocalization.minutes_ago(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return appLocalization.hours_ago(difference.inHours);
    } else if (difference.inDays < 7) {
      return appLocalization.days_ago(difference.inDays);
    } else {
      return toDateOnly(locale: Localizations.localeOf(context).toString());
    }
  }
}