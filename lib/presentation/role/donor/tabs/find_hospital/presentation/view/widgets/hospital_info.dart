import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import 'hospital_extra_info.dart';

class HospitalInfo extends StatelessWidget {
  const HospitalInfo({super.key, required this.hospitals});

  final Hospitals hospitals;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: hospitals.name ?? '',
          textStyle: TextStyle(
            color: ColorManger.black,
            fontWeight: FontWeightManager.medium,
            fontSize: FontSize.s15,
          ),
        ),
        SizedBox(height: 4.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: List.generate(
            hospitals.bloodTypes?.length ?? 0,
                (index) {
              final bloodType = hospitals.bloodTypes?[index] ?? '';

              return Container(
                decoration: BoxDecoration(
                  color: ColorManger.lightRed,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: CustomText(
                  text: bloodType,
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontSize: FontSize.s14,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 4.h),
        HospitalExtraInfo(
          distanceKm: hospitals.distanceKm ?? 0.0,
          urgentNeedsCount: hospitals.urgentNeedsCount ?? 0,
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalization.hospitalType(hospitals.hospitalType?? ''),
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
