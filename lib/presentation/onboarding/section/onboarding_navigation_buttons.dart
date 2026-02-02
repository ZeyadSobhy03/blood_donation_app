import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/widgets/custom_text.dart';

class OnboardingNavigationButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onDone;
  final bool isFirst;
  final bool isLast;

  const OnboardingNavigationButtons({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onDone,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 32.w : 24.w,
        vertical: 16.h,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 520 : double.infinity),
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  foregroundColor: ColorManger.black,
                  backgroundColor: ColorManger.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  elevation: 2,

                  onPressed: isFirst ? onDone : onBack,
                  child: CustomText(
                    text: isFirst ? 'Skip' : 'Back',
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManger.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomElevatedButton(
                  elevation: 2,
                  backgroundColor: ColorManger.brightRed,
                  foregroundColor: ColorManger.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  onPressed: onNext,
                  child: CustomText(
                    text: isLast ? 'Get Started' : 'Next',
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManger.pureWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
