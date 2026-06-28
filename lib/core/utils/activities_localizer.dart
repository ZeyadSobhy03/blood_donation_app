import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

class LocalizedActivity {
  final String title;
  final String typeLabel;
  final String statusLabel;
  final String relativeTime;

  LocalizedActivity({
    required this.title,
    required this.typeLabel,
    required this.statusLabel,
    required this.relativeTime,
  });
}

LocalizedActivity localizeActivity(
  BuildContext context, {
    required String title,
    required String type,
    required String status,
    String? createdAt,
    String? relativeTime,
  }) {
  final loc = AppLocalizations.of(context);

  if (loc == null) {
    return LocalizedActivity(
      title: title,
      typeLabel: type,
      statusLabel: status,
      relativeTime: relativeTime ?? '',
    );
  }

  return LocalizedActivity(
    title: _localizeTitle(title, type, status, loc),
    typeLabel: _localizeType(type, loc),
    statusLabel: _localizeStatus(status, loc),
    relativeTime: _localizeRelativeTime(relativeTime ?? '', loc),
  );
}

String _localizeTitle(String title, String type, String status, AppLocalizations loc) {
  final t = title.toLowerCase().trim();

  if (t.contains('tier promoted')) return loc.activityTierPromoted;
  if (t.contains('badge unlocked')) return loc.activityBadgeUnlocked;
  if (t.contains('reward redeemed')) return loc.activityRewardRedeemed;
  if (t.contains('donation created')) return loc.activityDonationCreated;
  if (t.contains('donation verified')) return loc.activityDonationVerified;
  if (t.contains('donation confirmed')) return loc.activityDonationConfirmed;
  if (t.contains('donation completed')) return loc.activityDonationCompleted;
  if (t.contains('donation cancelled')) return loc.activityDonationCancelled;
  if (t.contains('profile completed')) return loc.activityProfileCompleted;
  if (t.contains('profile updated')) return loc.activityProfileUpdated;
  if (t.contains('appointment requested')) return loc.activityAppointmentRequested;
  if (t.contains('urgent request nearby')) return loc.activityUrgentRequestNearby;

  if (t.contains('points earned')) {
    final match = RegExp(r'(\d+)\s+points earned').firstMatch(title);
    if (match != null) {
      final points = match.group(1);
      final separator = title.contains('—') ? '—' : (title.contains(' - ') ? ' - ' : null);
      final activity = separator != null
          ? title.split(separator).length > 1
              ? title.split(separator)[1].trim()
              : ''
          : '';
      return loc.activityPointsEarned(points ?? '0', activity);
    }
    return loc.activityPointsEarnedSimple;
  }

  return _deriveTitleFromType(type, status, loc);
}

String _deriveTitleFromType(String type, String status, AppLocalizations loc) {
  final t = type.toLowerCase().trim();
  final s = status.toLowerCase().trim();

  if (t == 'donation') {
    if (s == 'cancelled') return loc.activityDonationCancelled;
    if (s == 'pending') return loc.activityDonationCreated;
    return loc.activityDonationCompleted;
  }
  if (t == 'reward') return loc.activityRewardRedeemed;
  if (t == 'badge') return loc.activityBadgeUnlocked;
  if (t == 'achievement') return loc.activityTierPromoted;
  if (t == 'profile_update' || t == 'profile update') return loc.activityProfileUpdated;
  if (t == 'appointment') return loc.activityAppointmentRequested;
  if (t == 'referral' || t == 'subscription') {
    if (s == 'cancelled') return loc.activityDonationCancelled;
    return loc.activityDonationCreated;
  }
  if (t == 'emergency_response' || t == 'emergency response') return loc.activityUrgentRequestNearby;
  if (t == 'admin_action' || t == 'admin action') return loc.activityDonationCompleted;

  return type;
}

String _localizeType(String type, AppLocalizations loc) {
  final t = type.toLowerCase().trim();

  if (t == 'donation') return loc.activityTypeLabelDonation;
  if (t == 'reward') return loc.activityTypeLabelReward;
  if (t == 'emergency_response' || t == 'emergency response') {
    return loc.activityTypeLabelEmergencyResponse;
  }
  if (t == 'profile_update' || t == 'profile update') {
    return loc.activityTypeLabelProfileUpdate;
  }
  if (t == 'appointment') return loc.activityTypeLabelAppointment;
  if (t == 'badge') return loc.activityTypeLabelBadge;
  if (t == 'achievement') return loc.activityTypeLabelAchievement;
  if (t == 'referral') return loc.activityTypeLabelReferral;
  if (t == 'subscription') return loc.activityTypeLabelSubscription;
  if (t == 'admin_action' || t == 'admin action') {
    return loc.activityTypeLabelAdminAction;
  }

  return type;
}

String _localizeStatus(String status, AppLocalizations loc) {
  final s = status.toLowerCase().trim();

  if (s == 'pending') return loc.activityStatusPending;
  if (s == 'success') return loc.activityStatusSuccess;
  if (s == 'cancelled') return loc.activityStatusCancelled;

  return status;
}

String _localizeRelativeTime(String relativeTime, AppLocalizations loc) {
  final time = relativeTime.toLowerCase().trim();

  switch (time) {
    case 'just now':
      return loc.relativeTimeJustNow;
    case '1 minute ago':
      return loc.relativeTime1MinuteAgo;
    case '1 hour ago':
      return loc.relativeTime1HourAgo;
    case '1 day ago':
      return loc.relativeTime1DayAgo;
    case '1 week ago':
      return loc.relativeTime1WeekAgo;
    case '1 month ago':
      return loc.relativeTime1MonthAgo;
    case '1 year ago':
      return loc.relativeTime1YearAgo;
    default:
      if (time.contains('minutes ago')) {
        final match = RegExp(r'(\d+)\s+minutes ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeMinutesAgo(match.group(1) ?? '0');
        }
      }
      if (time.contains('hours ago')) {
        final match = RegExp(r'(\d+)\s+hours ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeHoursAgo(match.group(1) ?? '0');
        }
      }
      if (time.contains('days ago')) {
        final match = RegExp(r'(\d+)\s+days ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeDaysAgo(match.group(1) ?? '0');
        }
      }
      if (time.contains('weeks ago')) {
        final match = RegExp(r'(\d+)\s+weeks ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeWeeksAgo(match.group(1) ?? '0');
        }
      }
      if (time.contains('months ago')) {
        final match = RegExp(r'(\d+)\s+months ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeMonthsAgo(match.group(1) ?? '0');
        }
      }
      if (time.contains('years ago')) {
        final match = RegExp(r'(\d+)\s+years ago').firstMatch(relativeTime);
        if (match != null) {
          return loc.relativeTimeYearsAgo(match.group(1) ?? '0');
        }
      }
      return relativeTime;
  }
}
