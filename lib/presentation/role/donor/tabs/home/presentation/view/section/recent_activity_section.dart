import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../data/model/activities/activities_model.dart';
import '../widgets/recent_activity_row.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key, required this.activities});

  final List<Activities> activities;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 6,
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalizations.recent_activity,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s16,
                height: 1.4,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16.h),
            activities.isEmpty
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomText(
                text: appLocalizations.noActivitiesFound,
                textStyle: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                  color: ColorManger.slateGrey,
                ),
              ),
            )
                : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return RecentActivityRow(
                  points: activity.points ?? 0,
                  title: _getLocalizedActivityTitle(
                      activity.title, appLocalizations),
                  subTitle: _getLocalizedRelativeTime(
                      activity.relativeTime, appLocalizations),
                  color: _getActivityColor(activity.status),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getActivityColor(String? status) {
    switch (status) {
      case 'success':
        return ColorManger.brightRed;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.grey;
      case 'failed':
        return Colors.grey;
      default:
        return ColorManger.brightRed;
    }
  }


  String _getLocalizedActivityTitle(String? title, AppLocalizations l10n) {
    if (title == null || title.isEmpty) return '';

    switch (title) {
      case 'Profile Completed':
        return l10n.activityProfileCompleted;

      case "Donation Cancelled":
        return l10n.activityDonationCancelled;


      case "Donation Completed":
        return l10n.activityDonationCompleted;

       case "Profile Updated":
        return l10n.activityProfileUpdated;
      case 'Urgent Request Nearby':
        return l10n.activityUrgentRequestNearby;
      default:
      // Handle dynamic titles like "200 Points Earned — Blood Donation"
        if (title.contains('Points Earned')) {
          final match = RegExp(r'(\d+)\s+Points Earned').firstMatch(title);
          if (match != null) {
            final points = match.group(1);
            final activity =
            title.split('—').length > 1 ? title.split('—')[1].trim() : '';
            return l10n.activityPointsEarned(points ?? '0', activity);
          }
        }
        return title; // Return as-is if not recognized
    }
  }

  // Localize relative time strings
  String _getLocalizedRelativeTime(String? time, AppLocalizations l10n) {
    if (time == null || time.isEmpty) return '';

    switch (time) {
      case 'just now':
        return l10n.relativeTimeJustNow;
      case '1 minute ago':
        return l10n.relativeTime1MinuteAgo;
      case '1 hour ago':
        return l10n.relativeTime1HourAgo;
      case '1 day ago':
        return l10n.relativeTime1DayAgo;
      case '1 week ago':
        return l10n.relativeTime1WeekAgo;
      case '1 month ago':
        return l10n.relativeTime1MonthAgo;
      case '1 year ago':
        return l10n.relativeTime1YearAgo;
      default:
      // Handle dynamic formats like "N minutes ago", "N hours ago", etc.
        if (time.contains('minutes ago')) {
          final match = RegExp(r'(\d+)\s+minutes ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeMinutesAgo(match.group(1) ?? '0');
          }
        }
        if (time.contains('hours ago')) {
          final match = RegExp(r'(\d+)\s+hours ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeHoursAgo(match.group(1) ?? '0');
          }
        }
        if (time.contains('days ago')) {
          final match = RegExp(r'(\d+)\s+days ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeDaysAgo(match.group(1) ?? '0');
          }
        }
        if (time.contains('weeks ago')) {
          final match = RegExp(r'(\d+)\s+weeks ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeWeeksAgo(match.group(1) ?? '0');
          }
        }
        if (time.contains('months ago')) {
          final match = RegExp(r'(\d+)\s+months ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeMonthsAgo(match.group(1) ?? '0');
          }
        }
        if (time.contains('years ago')) {
          final match = RegExp(r'(\d+)\s+years ago').firstMatch(time);
          if (match != null) {
            return l10n.relativeTimeYearsAgo(match.group(1) ?? '0');
          }
        }
        return time; // Return as-is if no pattern matches
    }
  }

  // Localize activity status
  String _getLocalizedActivityStatus(String? status, AppLocalizations l10n) {
    if (status == null || status.isEmpty) return '';

    switch (status) {
      case 'pending':
        return l10n.activityStatusPending;
      case 'success':
        return l10n.activityStatusSuccess;
      case 'cancelled':
        return l10n.activityStatusCancelled;
      default:
        return status; // Return as-is for unknown statuses
    }
  }
}