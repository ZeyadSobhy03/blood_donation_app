import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/title_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../section/about_section.dart';
import '../section/faq_section.dart';
import '../section/get_help_section.dart';
import '../section/popular_topics_section.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final appLocalization=AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.brightRed,
        foregroundColor: ColorManger.pureWhite,
        title: TitleColum(
          title: appLocalization.helpAndSupport,
          subTitle: appLocalization.helpSubtitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GetHelpSection(),
              SizedBox(height: 16.h),
              const PopularTopicsSection(),
              SizedBox(height: 16.h),
              const AboutSection(),
              SizedBox(height: 16.h),
              const FaqSection(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}