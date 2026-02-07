import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/date_and_time_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/donation_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class AppointmentConfirmed extends StatelessWidget {
  const AppointmentConfirmed({super.key, required this.next});

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
              SizedBox(height: 8.h),
              Icon(
                Icons.check_circle_outline,
                color: ColorManger.green,
                size: 48,
              ),
              SizedBox(height: 4.h),
              TitleStep(
                isCenter: true,
                title: appLocalization.appointmentConfirmedTitle,
                subTitle: appLocalization.appointmentConfirmedSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              DateAndTimeCard(),
              SizedBox(height: 4.h),
              DonationCard(
                title: appLocalization.whatsNextTitle,
                items: [
                  appLocalization.nextStepEmail,
                  appLocalization.nextStepReminder,
                  appLocalization.nextStepId,
                ],
                textColor: ColorManger.skyBlue,
                cardColor: ColorManger.lightBlue,
                bulletColor: ColorManger.skyBlue,
                borderColor: ColorManger.skyBlue.withValues(alpha: 0.3),
              ),
              SizedBox(height: 8.h),
              NavigationButton(
                foregroundColor: ColorManger.pureWhite,
                backgroundColor: ColorManger.brightRed,
                nextStep: () {
                  Navigator.pushNamed(context, RouteManger.donorMainLayout);
                },
                text: appLocalization.backToHome,
              ),
              SizedBox(height: 4.h),
              NavigationButton(
                foregroundColor: ColorManger.black,
                backgroundColor: ColorManger.pureWhite,
                nextStep: () {
                  Navigator.pushNamed(context, RouteManger.donorMainLayout);
                },
                text: appLocalization.addToCalendar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
