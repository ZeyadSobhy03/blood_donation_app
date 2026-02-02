import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageIndicators extends StatelessWidget {
  final int currentIndex;
  final int total;

  const OnboardingPageIndicators({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
          width: currentIndex == index ? 8.w.clamp(8, 10) : 8.w.clamp(8, 10),
          height: 8.h.clamp(8, 10),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? ColorManger.brightRed
                : ColorManger.mutedGrey,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
