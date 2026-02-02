import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/onboarding/model/onboarding_model.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return OnboardingPage(
      pages: [
        OnboardingModel(
          backgroundColor: ColorManger.softPinkishWhite,
          icon: Icons.favorite_border,
          iconColor: ColorManger.brightRed,
          title: appLocalization.onboarding_1_title,
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: appLocalization.onboarding_1_subTitle,
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(text: appLocalization.onboarding_1_desc_1),
          ],
          descriptionStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
            height: 1.6,
          ),
        ),
        OnboardingModel(
          backgroundColor: ColorManger.pureWhite,
          icon: Icons.access_time_rounded,
          iconColor: ColorManger.slateGrey,
          title: appLocalization.onboarding_2_title,
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: appLocalization.onboarding_2_subTitle,
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text: appLocalization.onboarding_2_desc_1,
              prefixWidget: Container(
                height: 12.h,
                width: 12.w,
                decoration: BoxDecoration(
                  color: ColorManger.brightRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            OnboardingItem(
              text: appLocalization.onboarding_2_desc_2,
              prefixWidget: Container(
                height: 12.h,
                width: 12.w,
                decoration: BoxDecoration(
                  color: ColorManger.brightRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            OnboardingItem(
              text: appLocalization.onboarding_2_desc_3,
              prefixWidget: Container(
                height: 12.h,
                width: 12.w,
                decoration: BoxDecoration(
                  color: ColorManger.brightRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
          descriptionStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.black,
            height: 1.6,
          ),
        ),
        OnboardingModel(
          backgroundColor: ColorManger.lightBlueGrey,
          icon: Icons.people,
          iconColor: ColorManger.royalBlue,
          title: appLocalization.onboarding_3_title,
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: appLocalization.onboarding_3_subTitle,
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text: appLocalization.onboarding_3_desc_1,
              prefixWidget: Icon(
                Icons.location_on_outlined,
                color: ColorManger.royalBlue,
              ),
            ),
            OnboardingItem(
              text: appLocalization.onboarding_3_desc_2,
              prefixWidget: Icon(
                Icons.notifications_none,
                color: ColorManger.royalBlue,
              ),
            ),
            OnboardingItem(
              text: appLocalization.onboarding_3_desc_3,
              prefixWidget: Icon(
                Icons.military_tech,
                color: ColorManger.royalBlue,
              ),
            ),
          ],
          descriptionStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.black,
            height: 1.6,
          ),
        ),
        OnboardingModel(
          backgroundColor: ColorManger.softPinkishWhite,
          icon: Icons.favorite_border,
          iconColor: ColorManger.brightRed,
          title: appLocalization.onboarding_4_title,
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: appLocalization.onboarding_4_subTitle,
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(text: appLocalization.onboarding_4_desc_1),
          ],
          descriptionStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
            height: 1.6,
          ),
        ),
      ],
      onDone: () {
        Navigator.pushNamed(context, RouteManger.chooseRole);
      },
    );
  }
}
