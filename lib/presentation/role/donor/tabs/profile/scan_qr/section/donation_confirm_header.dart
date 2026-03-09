import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class DonationConfirmHeader extends StatelessWidget {
  const DonationConfirmHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: ColorManger.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            color: ColorManger.green,
            size: 32,
          ),
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: appLocalization.donationConfirmedTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: 8.h),
        CustomText(
          text: appLocalization.donationConfirmedMessage,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
