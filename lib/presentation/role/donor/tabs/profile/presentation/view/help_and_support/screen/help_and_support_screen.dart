import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/user_role.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../donate/presentation/view/widgets/title_colum.dart';
import '../section/about_section.dart';
import '../section/faq_section.dart';
import '../section/get_help_section.dart';
import '../section/popular_topics_section.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final appLocalization=AppLocalizations.of(context)!;
      final List<String> topics = [
        appLocalization.topicDonateBlood,
        appLocalization.topicEligibility,
        appLocalization.topicEarnPoints,
        appLocalization.topicEmergencies,
      ];
      final List<Map<String, String>> faqs = [
        {'question': appLocalization.faqHowToDonate, 'answer': appLocalization.faqHowToDonateAnswer},
        {'question': appLocalization.faqEligibility, 'answer': appLocalization.faqEligibilityAnswer},
        {'question': appLocalization.faqEarnPoints, 'answer': appLocalization.faqEarnPointsAnswer},
        {'question': appLocalization.faqDonationFrequency, 'answer': appLocalization.faqDonationFrequencyAnswer},
        {'question': appLocalization.faqBeforeDonation, 'answer': appLocalization.faqBeforeDonationAnswer},
        {'question': appLocalization.faqEmergencyResponse, 'answer': appLocalization.faqEmergencyResponseAnswer},
        {'question': appLocalization.faqChangeBloodType, 'answer': appLocalization.faqChangeBloodTypeAnswer},
      ];
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
              const GetHelpSection(
                userRole: UserRole.donor,
              ),
              SizedBox(height: 16.h),
               PopularTopicsSection(
                topics: topics,

              ),
              SizedBox(height: 16.h),
              const AboutSection(),
              SizedBox(height: 16.h),
               FaqSection(
                 faqs:faqs ,
               ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}