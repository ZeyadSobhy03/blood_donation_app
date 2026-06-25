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

    return ActivityItemModel(
      title: item.title ?? '',
      subtitle: item.subtitle ?? '',
      time: item.timestamp?.toTimeAgo(context) ?? '',
      dotColor: dotColor,
      status: status,
      contactNumber: item.donorPhone ?? '',
    );
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
