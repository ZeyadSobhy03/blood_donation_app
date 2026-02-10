import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/donation_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/appointment_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/eligibility_checklist_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/eligibility_status_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/faq_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/instruction_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/title_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/routes/route_manger.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../l10n/app_localizations.dart';

class Donate extends StatelessWidget {
  const Donate({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    List<String> items = [
      appLocalization.donationTip1,
      appLocalization.donationTip2,
      appLocalization.donationTip3,
      appLocalization.donationTip4,
      appLocalization.donationTip5,
      appLocalization.donationTip6,
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManger.brightRed,
        foregroundColor: ColorManger.pureWhite,
        title: TitleColum(
          title: appLocalization.readyToDonateTitle,
          subTitle: appLocalization.readyToDonateSubtitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 4.h),
                EligibilityStatusCard(),
                SizedBox(height: 4.h),
                AppointmentCard(),
                SizedBox(height: 4.h),
                EligibilityChecklistCard(),
                SizedBox(height: 4.h),
                DonationCard(
                  needIcon: true,
                  icon: Icons.info_outline,
                  title: appLocalization.beforeYouDonate,
                  items: items,
                  borderColor: ColorManger.lightBlue,
                  cardColor: ColorManger.lightBlue,
                  textColor: ColorManger.skyBlue,
                  bulletColor: ColorManger.skyBlue,
                ),
                SizedBox(height: 4.h),
                InstructionCard(),
                SizedBox(height: 4.h),
                FaqCard(),
                SizedBox(height: 4.h),
                LayoutBuilder(builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      minHeight: 50,
                    ),
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.brightRed,
                      foregroundColor: ColorManger.pureWhite,
                      elevation: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RouteManger.scheduleDonation,
                      ),
                      child: CustomText(text: appLocalization.scheduleDonation),
                    ),
                  );
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
