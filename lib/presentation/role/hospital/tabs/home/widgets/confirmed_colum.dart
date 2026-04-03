import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ConfirmedColum extends StatelessWidget {
  const ConfirmedColum({super.key, required this.confirmed});
  final int confirmed ;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: '1',
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.bold,
            color: ColorManger.green,
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: appLocalizations.confirmed,
          textStyle: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.bold,
            color: ColorManger.slateGrey,
          ),
        ),
      ],
    );
  }
}
