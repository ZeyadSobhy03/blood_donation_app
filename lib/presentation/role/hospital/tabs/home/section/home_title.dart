import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.hospitalName});

  final String hospitalName;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: hospitalName,
          textStyle: TextStyle(
            height: 1.4,
            color: ColorManger.royalBlue,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalizations.blood_request_dashboard,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            height: 1.4,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
