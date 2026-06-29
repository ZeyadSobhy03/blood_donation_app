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
      case 'request':
        final title = item.title?.toLowerCase() ?? '';
        if (title.contains('reopened')) {
          return loc.request_reopened_title;
        } else if (title.contains('cancelled')) {
          return loc.request_cancelled_title;
        } else if (title.contains('confirmed')) {
          return loc.donation_confirmed_title;
        }
        return item.title ?? '';
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
      case 'request':
        if (item.message == null) return '';
        final msg = item.message!;

        // Handle Reopened: "A donation slot has opened up for adult at Sadat City Emergency Hospital."
        if (msg.contains('donation slot has opened up')) {
          final RegExp regex =
              RegExp(r'A donation slot has opened up for (.*?) at (.*?)\.');
          final match = regex.firstMatch(msg);
          if (match != null && match.groupCount >= 2) {
            String patientType = match.group(1) ?? '';
            final hospitalName = match.group(2) ?? '';

            if (patientType.toLowerCase() == 'adult') {
              patientType = loc.patientTypeAdult;
            } else if (patientType.toLowerCase() == 'child') {
              patientType = loc.patientTypeChild;
            } else if (patientType.toLowerCase() == 'infant') {
              patientType = loc.patientTypeInfant;
            }

            return loc.request_reopened_body(patientType, hospitalName);
          }
        }

        // Handle Confirmed: "You've been assigned to Sadat City Specialized Medical Center for A+, A-, B+, B-, AB+, AB-, O+, O-. Arrive by 6/29/2026, 11:17:30 PM. Open the request to view your QR code."
        if (msg.contains("assigned to")) {
          final RegExp regex = RegExp(
              r"You've been assigned to (.*?) for (.*?)\. Arrive by (.*?)\. Open the request to view your QR code\.");
          final match = regex.firstMatch(msg);
          if (match != null && match.groupCount >= 3) {
            final hospitalName = match.group(1) ?? '';
            final bloodTypes = match.group(2) ?? '';
            final deadline = match.group(3) ?? '';
            return loc.donation_confirmed_body(
                hospitalName, bloodTypes, deadline);
          }
        }

        // Handle Cancelled: "Donation cancelled by donor"
        if (msg.contains('cancelled by donor')) {
          return loc.request_cancelled_body;
        }

        return msg;
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
      case 'request':
        return Icons.event_available;
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
      case 'request':
        return ColorManger.darkBlue;
      default:
        return ColorManger.skyBlue;
    }
  }
}