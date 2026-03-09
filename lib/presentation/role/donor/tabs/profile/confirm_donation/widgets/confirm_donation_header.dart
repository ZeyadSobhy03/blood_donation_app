import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class ConfirmDonationHeader extends StatelessWidget {
  const ConfirmDonationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return        Container(
      decoration: BoxDecoration(color: ColorManger.primaryRed),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                child: const Icon(Icons.arrow_back, color: ColorManger.pureWhite),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: 6.w),
              CustomText(
                text: appLocalization.button_back,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.pureWhite,
                ),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          CustomText(
            text: appLocalization.scan_donation_qr,
            textStyle: TextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.bold,
              color: ColorManger.pureWhite,
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: appLocalization.confirm_donation_qr_desc,
            textStyle: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManger.pureWhite,
            ),
          ),
        ],
      ),
    );
  }
}
