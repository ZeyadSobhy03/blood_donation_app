import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/fonts/font_manger.dart';

class OnboardingDescriptionList extends StatelessWidget {
  final List<OnboardingItem> description;
  final TextStyle? textStyle;

  const OnboardingDescriptionList({
    super.key,
    required this.description,
    this.textStyle,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth >= 1024
              ? 520
              : screenWidth >= 600
              ? 420
              : double.infinity,
        ),
        child: Card(
          color: ColorManger.pureWhite,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: description.map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.prefixWidget != null) ...[
                        item.prefixWidget!,
                        SizedBox(width: 10.w),
                      ],
                      Expanded(
                        child: CustomText(
                          text: item.text,
                          textStyle: textStyle ??
                              TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManger.slateGrey,
                                height: 1.6,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

}
