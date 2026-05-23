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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return RecentActivityRow(
                  points: activity.points ?? 0,
                  title: activity.title ?? '',
                  subTitle: activity.type?? '',
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
      case 'failed':
        return Colors.grey;
      default:
        return ColorManger.brightRed;
    }
  }
}