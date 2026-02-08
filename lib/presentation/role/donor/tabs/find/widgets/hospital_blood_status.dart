import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';

class HospitalBloodStatus extends StatelessWidget {
  const HospitalBloodStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CustomText(
            text: 'O+, A+, AB+',
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              color: ColorManger.brightRed,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: ColorManger.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            CustomText(
              text: appLocalization.available,
              textStyle: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManger.slateGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
