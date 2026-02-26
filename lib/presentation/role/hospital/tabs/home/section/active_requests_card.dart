import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/active_request_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/contact_donor/contact_donor_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/view_detail/view_detail_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/confirmed_colum.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/custom_badge.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/widgets/request_meta_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class ActiveRequestsCard extends StatelessWidget {
  const ActiveRequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.brightRed, width: 1),
      ),
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomBadge(
                        text: appLocalizations.critical,
                        backgroundColor: ColorManger.brightRed,
                        fontColor: ColorManger.pureWhite,
                        borderColor: ColorManger.brightRed,
                      ),
                      SizedBox(width: 4.w),
                      CustomBadge(
                        text: 'O+',
                        backgroundColor: ColorManger.pureWhite,
                        fontColor: ColorManger.black,
                        borderColor: ColorManger.lightGrey,
                      ),
                      Spacer(),
                      ConfirmedColum(confirmed: 1),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: appLocalizations.unit_needed(3),
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s14,
                      height: 1.4,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RequestMetaInfo(
                        icon: Icons.access_time,
                        label: appLocalizations.hours_ago(2),
                      ),
                      SizedBox(width: 16.w),
                      RequestMetaInfo(
                        icon: Icons.person_outline,
                        label: appLocalizations.responses(5),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ActiveRequestNavigationButtons(
                    onContactDonorsPressed: () {
                      // Handle contact donors action
                      showDialog(
                        context: context,
                        builder: (context) => ContactDonorDialog(),
                      );
                    },
                    onViewDetailPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ViewDetailDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
