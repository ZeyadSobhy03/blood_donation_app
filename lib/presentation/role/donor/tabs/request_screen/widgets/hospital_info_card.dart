import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class HospitalInfoCard extends StatelessWidget {
  const HospitalInfoCard({
    super.key,
    required this.hospitalName,
    required this.location,
    required this.iconColor,
    required this.unitsNeeded,
    required this.distance,
    this.onNavigate,
  });

  final String hospitalName;
  final String location;
  final Color iconColor;
  final String unitsNeeded;
  final String distance;
  final VoidCallback? onNavigate;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            Divider(
              color: ColorManger.slateGrey.withValues(alpha: 0.4),
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoColumn(appLocalizations.unitsNeeded, unitsNeeded),
                _buildInfoColumn(appLocalizations.distance, distance),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.local_hospital,
          size: 26.sp,
          color: iconColor,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: hospitalName,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: ColorManger.slateGrey,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: CustomText(
                      text: location,
                      maxLines: 1,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildActionButton(),
      ],
    );
  }

  Widget _buildActionButton() {
    return Material(
      color: ColorManger.pureWhite,
      elevation: 2,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onNavigate,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Transform.rotate(
            angle: -0.785,
            child: Icon(
              Icons.send_rounded,
              size: 18.sp,
              color: ColorManger.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: value,
          textStyle: TextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
        ),
      ],
    );
  }
}
