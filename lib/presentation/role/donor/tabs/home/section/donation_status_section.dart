import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class DonationStatusCard extends StatelessWidget {
  const DonationStatusCard({super.key, required this.donationStatus, required this.bloodType});
  final String donationStatus;
  final String bloodType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManger.brightRed,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:AppLocalizations.of(context)!.donationStatus,
                  textStyle: TextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManger.pureWhite,
                  ),
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [
                    Container(
                      height: 8.h,
                      width: 8.h,
                      decoration: BoxDecoration(
                        color: ColorManger.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: donationStatus,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                CustomText(
                  text: AppLocalizations.of(context)!.nextDonationReady,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: ColorManger.pureWhite.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: ColorManger.pureWhite,
                    size: 36.sp,
                  ),
                ),

                SizedBox(height: 8.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManger.pureWhite,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    text: '$bloodType ${AppLocalizations.of(context)!.donor}',
                    textStyle: TextStyle(
                      color: ColorManger.brightRed,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
