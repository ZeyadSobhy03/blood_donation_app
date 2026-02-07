import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/donation_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/review_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ReviewAndConfirm extends StatelessWidget {
  const ReviewAndConfirm({super.key, required this.next});

  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleStep(
                title: appLocalization.reviewConfirmTitle,
                subTitle: appLocalization.reviewConfirmSubtitle,
              ),
              ReviewCard(),
              SizedBox(height: 4.h),
              DonationCard(
                title: appLocalization.beforeYouDonate,
                items: [
                  appLocalization.donationTipEat,
                  appLocalization.donationTipWater,
                  appLocalization.donationTipId,
                  appLocalization.donationTipSleep,
                ],
                borderColor: ColorManger.goldBorder,
                bulletColor: ColorManger.bulletBrown,
                cardColor: ColorManger.lightCream,
                textColor: ColorManger.textGold,
              ),
              SizedBox(height: 4.h),
              NavigationButton(
                foregroundColor: ColorManger.pureWhite,
                backgroundColor: ColorManger.brightRed,
                nextStep: next,
                text: appLocalization.confirmAppointment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
