import 'package:blood_donation_app/core/extension/data_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/model/activity_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/widgets/activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../data/models/home_activity_model.dart' as api;

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key, required this.activities});

  final List<api.ActivityItem> activities;

  ActivityItemModel _toViewModel(api.ActivityItem item, BuildContext context) {
    ActivityStatus status;
    Color dotColor;

    switch (item.type) {
      case 'donor_response':
        status = ActivityStatus.contact;
        dotColor = ColorManger.skyBlue;
        break;
      case 'request_created':
        status = ActivityStatus.active;
        dotColor = ColorManger.orange;
        break;
      case 'request_completed':
      case 'donation_confirmed':
        status = ActivityStatus.complete;
        dotColor = ColorManger.green;
        break;
      default:
        if (item.status == 'completed') {
          status = ActivityStatus.complete;
          dotColor = ColorManger.green;
        } else if (item.status == 'active') {
          status = ActivityStatus.active;
          dotColor = ColorManger.orange;
        } else {
          status = ActivityStatus.contact;
          dotColor = ColorManger.skyBlue;
        }
    }

    final loc = AppLocalizations.of(context)!;
    final title = _localizeTitle(item.type, item.title, loc);
    final subtitle = _localizeSubtitle(item.type, item.subtitle, loc);

    return ActivityItemModel(
      title: title,
      subtitle: subtitle,
      time: item.timestamp?.toTimeAgo(context) ?? '',
      dotColor: dotColor,
      status: status,
      contactNumber: item.donorPhone ?? '',
    );
  }

  String _localizeTitle(String? type, String? title, AppLocalizations loc) {
    final raw = title ?? '';
    switch (type) {
      case 'request_created':
        final bloodTypes = raw.startsWith('Request created - ')
            ? raw.substring('Request created - '.length)
            : '';
        return bloodTypes.isNotEmpty
            ? loc.activityRequestCreated(bloodTypes)
            : loc.activityRequestCreated('');
      case 'request_fulfilled':
        final bloodTypes = raw.startsWith('Request fulfilled - ')
            ? raw.substring('Request fulfilled - '.length)
            : '';
        return bloodTypes.isNotEmpty
            ? loc.activityRequestFulfilled(bloodTypes)
            : loc.activityRequestFulfilled('');
      case 'donor_response':
        final prefix = 'New donor response - ';
        final donorName = raw.startsWith(prefix)
            ? raw.substring(prefix.length)
            : '';
        return donorName.isNotEmpty && donorName != 'Donor'
            ? loc.activityDonorResponse(donorName)
            : loc.activityDonorResponseFallback;
      default:
        return raw;
    }
  }

  String _localizeSubtitle(String? type, String? subtitle, AppLocalizations loc) {
    final raw = subtitle ?? '';
    final unitsPrefixNeeded = 'units needed ';
    final unitsPrefixReceived = 'units received ';
    final donorSuffix = ' donor responded';

    if (raw.startsWith(unitsPrefixNeeded)) {
      final units = raw.substring(unitsPrefixNeeded.length);
      return loc.activityUnitsNeeded(units);
    }
    if (raw.startsWith(unitsPrefixReceived)) {
      final units = raw.substring(unitsPrefixReceived.length);
      return loc.activityUnitsReceived(units);
    }
    if (raw.endsWith(donorSuffix)) {
      final bloodType = raw.substring(0, raw.length - donorSuffix.length);
      return bloodType.contains(',')
          ? loc.activityDonorRespondedFallback(bloodType)
          : loc.activityDonorResponded(bloodType);
    }
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalizations.recent_activity,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16.h),
            if (activities.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomText(
                  text: appLocalizations.noRecentActivity,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = _toViewModel(activities[index], context);
                  return ActivityTile(item: item);
                },
              ),
          ],
        ),
      ),
    );
  }
}
