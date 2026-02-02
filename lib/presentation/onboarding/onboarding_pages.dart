import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/presentation/onboarding/model/onboarding_model.dart';
import 'package:blood_donation_app/presentation/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      pages: [
        OnboardingModel(
          backgroundColor: ColorManger.softPinkishWhite,
          icon: Icons.favorite_border,
          iconColor: ColorManger.brightRed,
          title: 'Welcome to LifeLink',
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: 'Smart Blood Donation App',
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text:
                  'Connecting donors with those in need, saving lives one donation at a time.',
            ),
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
          title: 'The Problem',
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: 'Current Challenges',
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text: 'Difficulty finding donors quickly in emergencies',
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
              text: 'No centralized donor database',
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
              text: 'Lack of motivation for repeat donations',
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
          title: 'The Problem',
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: 'Current Challenges',
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text: 'Fast GPS-based donor matching',
              prefixWidget: Icon(
                Icons.location_on_outlined,
                color: ColorManger.royalBlue,
              ),
            ),
            OnboardingItem(
              text: 'Instant emergency notifications',
              prefixWidget: Icon(
                Icons.notifications_none,
                color: ColorManger.royalBlue,
              ),
            ),
            OnboardingItem(
              text: 'Rewards system for donors',
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
          title: 'Make a Difference',
          titleTextStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.black,
          ),
          subTitle: 'Join Our Community',
          subTitleTextStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
          description: [
            OnboardingItem(
              text:
                  'Every donation can save up to 3 lives. Be a hero in your community.',
            ),
          ],
          descriptionStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
            height: 1.6,
          ),
        ),
      ],
      onDone: () {},
    );
  }
}
