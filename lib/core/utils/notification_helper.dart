import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart'
as notification_model;

class NotificationHelper {
  /// Returns the localized title based on the notification type.
  static String getTitle(
      notification_model.Notifications item,
      AppLocalizations loc,
      ) {
    switch (item.type) {
      case 'reward':
        return loc.badge_unlocked_title(item.title ?? '');
      case 'emergency':
        return loc.emergency_request_title;
      case 'achievement':
        return loc.tier_up_title(item.title ?? '');
      case 'admin':
        return loc.support_reply_title;
      case 'system':
        return loc.reward_redeemed_title;
      default:
        return item.title ?? '';
    }
  }

  /// Returns the localized body/message based on the notification type.
  static String getBody(
      notification_model.Notifications item,
      AppLocalizations loc,
      ) {
    switch (item.type) {
      case 'emergency':
        return loc.emergency_request_body(
          item.data?.requestType ?? '',
          item.data?.hospitalName ?? '',
        );
      case 'reward':
        return loc.badge_unlocked_message(item.message ?? '');
      case 'achievement':
        return loc.tier_up_message(item.title ?? '');
      case 'admin':
        String ticketSubject = '';

        if (item.message != null) {
          // Regex to parse: 'Your support request "Need help with reward redemption" has been answered.'
          final RegExp regex = RegExp(r'Your support request "(.*?)" has been answered\.');
          final match = regex.firstMatch(item.message!);

          if (match != null && match.groupCount >= 1) {
            ticketSubject = match.group(1) ?? '';
            return loc.support_reply_message(ticketSubject);
          }
        }
        return item.message ?? '';
      case 'system':
        String rewardName = '';
        String code = '';

        if (item.message != null) {
          // Regex to parse: "Your Coffee Voucher is confirmed. Code: RWD-2026-894E33"
          final RegExp regex = RegExp(r'Your (.*?) is confirmed\. Code: (.*)');
          final match = regex.firstMatch(item.message!);

          if (match != null && match.groupCount >= 2) {
            rewardName = match.group(1) ?? '';
            code = match.group(2) ?? '';
            return loc.reward_redeemed_message(rewardName, code);
          }
        }
        return item.message ?? '';
      default:
        return item.message ?? '';
    }
  }

  /// Returns the appropriate icon based on the notification type.
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
      default:
        return Icons.notifications;
    }
  }

  /// Returns the appropriate icon color based on the notification type.
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
      default:
        return ColorManger.skyBlue;
    }
  }
}