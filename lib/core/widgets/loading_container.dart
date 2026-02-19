import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../resources/colors/color_manger.dart';
import '../resources/fonts/font_manger.dart';
import 'custom_text.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: ColorManger.pureWhite,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: ColorManger.brightRed),
                SizedBox(height: 12.h),
                CustomText(
                  text: appLocalizations.saving,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
