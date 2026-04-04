import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension DateTimeEx on DateTime {
  String toDateOnly({String? locale}) {
    return DateFormat('dd MMM yyyy', locale).format(this);
  }
  String toDateOnlyWithDay({String? locale}) {
    return DateFormat('EEEE, dd MMM yyyy', locale).format(this);
  }
  // Example 25/12/2023
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
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return toDateOnly(locale: Localizations.localeOf(context).toString());
    }
  }
}
