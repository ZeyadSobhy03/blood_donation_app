import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/recent_activity_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/recent_activity.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key, required this.activities});

  final List<RecentActivityModel> activities;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Recent Activity',
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s16,
                height: 1.4,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return RecentActivityRow(
                  points: activity.points,
                  title: activity.title,
                  subTitle: activity.subTitle,
                  color: activity.color,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
