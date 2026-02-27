import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ContactDonorHeader extends StatelessWidget {
  const ContactDonorHeader({
    super.key,
    required this.name,
    required this.bloodType,
    required this.location,
  });

  final String name;
  final String bloodType;
  final String location;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: ColorManger.lightRed,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite_border,
            color: ColorManger.brightRed,
            size: 24,
          ),
        ),
        SizedBox(width: 4.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.medium,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: '${appLocalization.blood_type}: $bloodType',
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: '${appLocalization.location}: $location',
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
