import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../model/hospital_request_model.dart';
import 'hospital_extra_info.dart';

class HospitalInfo extends StatelessWidget {
  const HospitalInfo({super.key, required this.hospitalRequestModel});

  final HospitalRequestModel hospitalRequestModel;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: hospitalRequestModel.hospitalName,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontWeight: FontWeightManager.medium,
            fontSize: FontSize.s15,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManger.lightRed,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomText(
                    text: hospitalRequestModel.bloodTypes,
                    textStyle: TextStyle(
                      color: ColorManger.brightRed,
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s14,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: ColorManger.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.h),
                CustomText(
                  text: appLocalization.available,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 4.h),
        HospitalExtraInfo(
          distanceKm: hospitalRequestModel.distanceKm,
          urgentNeedsCount: hospitalRequestModel.urgentNeedsCount,
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalization.hospitalType(hospitalRequestModel.hospitalType),
          textStyle: TextStyle(
            height: 1.4,
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s14,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
