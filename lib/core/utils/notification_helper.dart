import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart'
    as notification_model;

class NotificationHelper {
  static String getTitle(
    notification_model.Notifications item,
    AppLocalizations loc,
  ) {
    return getTitleFromFields(
      type: item.type,
      title: item.title,
      message: item.message,
      loc: loc,
    );
  }

  static String getBody(
    notification_model.Notifications item,
    AppLocalizations loc,
  ) {
    return getBodyFromFields(
      type: item.type,
      title: item.title,
      message: item.message,
      data: item.data,
      loc: loc,
    );
  }

  static String getTitleFromFields({
    required String? type,
    String? title,
    String? message,
    Map<String, dynamic>? dataRaw,
    required AppLocalizations loc,
  }) {
    final titleFromFields = _extractTitleFromFields(type, title, message, loc);
    if (titleFromFields != null) return titleFromFields;

    switch (type) {
      case 'reward':
        return loc.badge_unlocked_title(title ?? '');
      case 'emergency':
        return loc.emergency_request_title;
      case 'achievement':
        return loc.tier_up_title(title ?? '');
      case 'admin':
        return loc.support_reply_title;
      case 'system':
        return loc.reward_redeemed_title;
      case 'match':
        return loc.notifications_donor_response_title;
      case 'appointment_new_booked':
        return loc.notifications_appointment_new_booked;
      case 'appointment_cancelled':
      case 'appointment_cancelled_by_donor':
        return loc.notifications_appointment_cancelled_by_donor;
      default:
        return title ?? '';
    }
  }

  static String getBodyFromFields({
    required String? type,
    String? title,
    String? message,
    dynamic data,
    Map<String, dynamic>? dataRaw,
    required AppLocalizations loc,
  }) {
    final bodyFromMessage = _extractBodyFromMessage(type, message, loc);
    if (bodyFromMessage != null) return bodyFromMessage;

    switch (type) {
      case 'emergency':
        final hospitalName = _getMapValue(dataRaw, 'hospitalName') ??
            _getDataValue(data, 'hospitalName') ??
            '';
        final bloodType = _getMapValue(dataRaw, 'bloodType') ??
            _getDataValue(data, 'requestType') ??
            '';
        return loc.emergency_request_body(bloodType, hospitalName);
      case 'reward':
        return loc.badge_unlocked_message(message ?? '');
      case 'achievement':
        return loc.tier_up_message(title ?? '');
      case 'admin':
        String ticketSubject = '';
        if (message != null) {
          final RegExp regex = RegExp(r'Your support request "(.*?)" has been answered\.');
          final match = regex.firstMatch(message);
          if (match != null && match.groupCount >= 1) {
            ticketSubject = match.group(1) ?? '';
            return loc.support_reply_message(ticketSubject);
          }
        }
        return message ?? '';
      case 'system':
        String rewardName = '';
        String code = '';
        if (message != null) {
          final RegExp regex = RegExp(r'Your (.*?) is confirmed\. Code: (.*)');
          final match = regex.firstMatch(message);
          if (match != null && match.groupCount >= 2) {
            rewardName = match.group(1) ?? '';
            code = match.group(2) ?? '';
            return loc.reward_redeemed_message(rewardName, code);
          }
        }
        return message ?? '';
      default:
        return message ?? '';
    }
  }

  static String? _extractTitleFromFields(
    String? type,
    String? title,
    String? message,
    AppLocalizations loc,
  ) {
    if (message != null) {
      if (message.contains('donation appointment is confirmed') ||
          message.contains('تم تأكيد موعد التبرع')) {
        return loc.notifications_donor_response_title;
      }
      if (message.contains('cancelled their appointment on') ||
          message.contains('ألغى')) {
        return loc.notifications_appointment_cancelled_by_donor;
      }
      if (message.contains('booked an appointment for') ||
          message.contains('حجز موعد')) {
        return loc.notifications_appointment_new_booked;
      }
      if (message.contains('pledged') && message.contains('unit(s)')) {
        return loc.notifications_donor_response_title;
      }
    }
    if (title != null) {
      if (title.contains('cancelled by donor') || title.contains('إلغاء الموعد')) {
        return loc.notifications_appointment_cancelled_by_donor;
      }
      if (title.contains('New donor response') || title.contains('استجابة متبرع')) {
        return loc.notifications_donor_response_title;
      }
      if (title.contains('New Appointment') || title.contains('موعد جديد')) {
        return loc.notifications_appointment_new_booked;
      }
      if (title.contains('New Response') || title.contains('استجابة')) {
        return loc.notifications_donor_response_title;
      }
    }
    return null;
  }

  static String? _extractBodyFromMessage(
    String? type,
    String? message,
    AppLocalizations loc,
  ) {
    if (message == null) return null;

    if (message.contains('pledged') && message.contains('unit(s)')) {
      final RegExp regex = RegExp(r'(.+?) pledged (\d+) unit\(s\) for (.+?)\. (\d+) more needed');
      final match = regex.firstMatch(message);
      if (match != null && match.groupCount >= 4) {
        return loc.notifications_donor_pledged_body(
          match.group(1)!,
          match.group(2)!,
          match.group(3)!,
          match.group(4)!,
        );
      }
    }

    if (message.contains('donation appointment is confirmed') ||
        message.contains('تم تأكيد موعد التبرع')) {
      final RegExp regex = RegExp(r'Your (.+?) donation appointment is confirmed!?');
      final match = regex.firstMatch(message);
      if (match != null && match.groupCount >= 1) {
        return loc.notifications_appointment_confirmed_body(match.group(1)!);
      }
      final RegExp regexAr = RegExp(r'تم تأكيد موعد التبرع في (.+?)!?');
      final matchAr = regexAr.firstMatch(message);
      if (matchAr != null && matchAr.groupCount >= 1) {
        return loc.notifications_appointment_confirmed_body(matchAr.group(1)!);
      }
    }

    if (message.contains('cancelled their appointment on')) {
      final RegExp regex = RegExp(r'(.+?) cancelled their appointment on (.+)');
      final match = regex.firstMatch(message);
      if (match != null && match.groupCount >= 2) {
        return loc.notifications_appointment_cancelled_body(
          match.group(1)!,
          match.group(2)!,
        );
      }
    }

    if (message.contains('booked an appointment for') ||
        message.contains('بحجز موعد في')) {
      final RegExp regexEn = RegExp(r'A donor has booked an appointment for (.+)');
      final matchEn = regexEn.firstMatch(message);
      if (matchEn != null && matchEn.groupCount >= 1) {
        return loc.notifications_appointment_booked_body(matchEn.group(1)!);
      }
      final RegExp regexAr = RegExp(r'قام متبرع بحجز موعد في (.+)');
      final matchAr = regexAr.firstMatch(message);
      if (matchAr != null && matchAr.groupCount >= 1) {
        return loc.notifications_appointment_booked_body(matchAr.group(1)!);
      }
    }

    return null;
  }

  static String? _getMapValue(Map<String, dynamic>? map, String key) {
    if (map == null) return null;
    final val = map[key];
    return val?.toString();
  }

  static String? _getDataValue(dynamic data, String key) {
    if (data == null) return null;
    if (data is Map) {
      final val = data[key];
      return val?.toString();
    }
    try {
      final val = data.getField(key);
      return val?.toString();
    } catch (_) {
      return null;
    }
  }

  static IconData getIcon(String? type) {
    switch (type) {
      case 'reward':
        return Icons.workspace_premium;
      case 'info':
        return Icons.access_time;
      case 'achievement':
        return Icons.emoji_events;
      case 'emergency':
        return Icons.error_outline;
      case 'admin':
        return Icons.support_agent;
      case 'system':
        return Icons.card_giftcard;
      case 'match':
      case 'appointment_new_booked':
        return Icons.calendar_today;
      case 'appointment_cancelled':
      case 'appointment_cancelled_by_donor':
        return Icons.cancel_outlined;
      default:
        return Icons.notifications;
    }
  }

  static Color getIconColor(String? type) {
    switch (type) {
      case 'reward':
        return ColorManger.gold;
      case 'info':
        return ColorManger.skyBlue;
      case 'achievement':
        return ColorManger.brightRed;
      case 'emergency':
        return ColorManger.brightRed;
      case 'admin':
        return ColorManger.darkBlue;
      case 'system':
        return ColorManger.gold;
      case 'match':
      case 'appointment_new_booked':
        return ColorManger.skyBlue;
      case 'appointment_cancelled':
      case 'appointment_cancelled_by_donor':
        return ColorManger.slateGrey;
      default:
        return ColorManger.skyBlue;
    }
  }
}
