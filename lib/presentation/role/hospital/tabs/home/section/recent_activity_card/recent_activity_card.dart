import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/model/activity_item.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/recent_activity_card/widgets/activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ActivityItemModel> activities = [
      ActivityItemModel(
        contactNumber: '+201141935341',
        title: 'Request fulfilled - O+ blood',
        subtitle: '3 units received',
        time: '2 hours ago',
        dotColor: ColorManger.green,
        status: ActivityStatus.complete,
      ),
      ActivityItemModel(
        contactNumber: '+201141935341',
        title: 'New donor response - Sarah J.',
        subtitle: 'O+ donor confirmed',
        time: '4 hours ago',
        dotColor: ColorManger.skyBlue,
        status: ActivityStatus.contact,
      ),
      ActivityItemModel(
        contactNumber: '+201141935341',
        title: 'Request created - A- blood',
        subtitle: '2 units requested',
        time: '6 hours ago',
        dotColor: ColorManger.orange,
        status: ActivityStatus.active,
      ),
    ];
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

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: activities.length,

              itemBuilder: (context, index) {
                final item = activities[index];
                return ActivityTile(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
