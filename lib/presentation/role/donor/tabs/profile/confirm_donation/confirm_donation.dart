import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/sections/camera_scanner_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/sections/how_work_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/sections/recent_confirmations_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/sections/security_notice_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/confirm_donation/widgets/confirm_donation_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class ConfirmDonation extends StatelessWidget {
  const ConfirmDonation({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              SizedBox(height: 8.h),
              ConfirmDonationHeader(),
              SizedBox(height: 8.h,),
              HowWorkCard(),
              SizedBox(height: 8.h,),
              CameraScannerCard(),
              SizedBox(height: 8.h,),
              SecurityNoticeCard(),
              SizedBox(height: 8.h,),
              RecentConfirmationsCard()
          
          
            ],
          ),
        ),
      ),
    );
  }
}
