import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import '../../resources/colors/color_manger.dart';
import '../../resources/fonts/font_manger.dart';
import '../../widgets/custom_text.dart';
////////////////////////////////// test
class CustomSuccessWidget<T> extends StatelessWidget {
  final T data;
  final String message;
  final VoidCallback? onAction;
  final String? actionButtonText;

  const CustomSuccessWidget({
    super.key,
    required this.data,
    required this.message,
    this.onAction,
    this.actionButtonText,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorManger.successBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: ColorManger.successColor,
                size: 50.sp,
              ),
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: appLocalizations.success,
              textStyle: TextStyle(
                color: ColorManger.successColor,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s18,
              ),
            ),
            SizedBox(height: 12.h),
            // Details Message
            CustomText(
              text: message,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: ColorManger.grey600,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
              ),
            ),
            SizedBox(height: 24.h),
            // Success Details Box
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorManger.lightGreen,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorManger.successColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: appLocalizations.successDetails,
                    textStyle: TextStyle(
                      color: ColorManger.successColor,
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s13,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: data.toString(),
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: ColorManger.grey800,
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
            ),
            if (onAction != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManger.successColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: CustomText(
                  text: actionButtonText ?? appLocalizations.continueButton,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

