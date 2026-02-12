import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class MapCard extends StatelessWidget {
  const MapCard({super.key, required this.hospitalName, this.onTap});

  final String hospitalName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorManger.lightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              _buildInfoRow(context),
              SizedBox(height: 8.h),
              _buildInfoColum(context),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  _buildInfoRow(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManger.pureWhite,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: CustomText(
                text: appLocalizations.openInMap,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildInfoColum(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: ColorManger.brightRed,
          size: 36.sp,
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalizations.mapView,
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: hospitalName,
          textStyle: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
