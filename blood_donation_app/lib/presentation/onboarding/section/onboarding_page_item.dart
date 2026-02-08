import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/onboarding/model/onboarding_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboarding_description_list.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingPageItem({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            page.icon,
            color: page.iconColor ?? ColorManger.brightRed,
            size: 80.sp.clamp(64, 120), // lower size and upper size
          ),
          SizedBox(height: 24.h),
          CustomText(
            text: page.title,
            textStyle:
                page.titleTextStyle ??
                TextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: page.subTitle,
            textStyle:
                page.subTitleTextStyle ??
                TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.slateGrey,
                ),
          ),
          SizedBox(height: 32.h),
          OnboardingDescriptionList(
            description: page.description,
            textStyle: page.descriptionStyle,
          ),
        ],
      ),
    );
  }
}
