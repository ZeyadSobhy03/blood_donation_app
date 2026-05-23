import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import '../../resources/colors/color_manger.dart';
import '../../resources/fonts/font_manger.dart';
import '../../widgets/custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final String? errorCode;
  final VoidCallback onRetry;
  final VoidCallback? onDismiss;

  const CustomErrorWidget({
    super.key,
    required this.message,
    this.errorCode,
    required this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorManger.errorLightBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: ColorManger.brightRed,
                size: 50.sp,
              ),
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: appLocalizations.somethingWentWrong,
              textStyle: TextStyle(
                color: ColorManger.brightRed,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s18,
              ),
            ),
            SizedBox(height: 12.h),
            // Error Message
            CustomText(
              text: message,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: ColorManger.grey600,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
              ),
            ),
            // Error Code (if provided)
            if (errorCode != null) ...[
              SizedBox(height: 12.h),
              CustomText(
                text: '${appLocalizations.errorCode}: $errorCode',
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
            SizedBox(height: 24.h),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onDismiss != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDismiss,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: ColorManger.grey300,
                          width: 1.5,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: CustomText(
                        text: appLocalizations.dismissButton,
                        textStyle: TextStyle(
                          color: ColorManger.grey600,
                          fontWeight: FontWeightManager.semiBold,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ),
                if (onDismiss != null) SizedBox(width: 12.w),
                // Retry Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManger.brightRed,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: CustomText(
                      text: appLocalizations.retryButton,
                      textStyle: TextStyle(
                        color: ColorManger.pureWhite,
                        fontWeight: FontWeightManager.semiBold,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

