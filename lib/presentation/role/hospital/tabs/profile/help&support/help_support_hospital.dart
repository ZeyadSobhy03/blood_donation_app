import 'package:blood_donation_app/core/resources/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/widgets/title_colum.dart';
import '../../../../donor/tabs/profile/help_and_support/section/about_section.dart';
import '../../../../donor/tabs/profile/help_and_support/section/faq_section.dart';
import '../../../../donor/tabs/profile/help_and_support/section/get_help_section.dart';
import '../../../../donor/tabs/profile/help_and_support/section/popular_topics_section.dart';

class HelpAndSupportHospital extends StatelessWidget {
  const HelpAndSupportHospital({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final List<String> topics = [
      appLocalization.topic_create_request,
      appLocalization.topic_qr_code,
      appLocalization.topic_history,
      appLocalization.topic_contact,
      appLocalization.topic_update_profile,
    ];
    final List<Map<String, String>> faqs = [
      {
        'question': appLocalization.faqHowToCreateRequest,
        'answer': appLocalization.faqHowToCreateRequestAnswer,
      },
      {
        'question': appLocalization.faqQrCode,
        'answer': appLocalization.faqQrCodeAnswer,
      },
      {
        'question': appLocalization.faqHistory,
        'answer': appLocalization.faqHistoryAnswer,
      },
      {
        'question': appLocalization.faqContact,
        'answer': appLocalization.faqContactAnswer,
      },
      {
        'question': appLocalization.faqUpdateProfile,
        'answer': appLocalization.faqUpdateProfileAnswer,
      },
    ];
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.royalBlue,
        foregroundColor: ColorManger.pureWhite,
        title: TitleColum(
          title: appLocalization.helpAndSupport,
          subTitle: appLocalization.helpSubtitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GetHelpSection(userRole: UserRole.hospital),
                SizedBox(height: 16.h),
                PopularTopicsSection(topics: topics),
                SizedBox(height: 16.h),
                const AboutSection(),
                SizedBox(height: 16.h),
                FaqSection(faqs: faqs),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
