import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/help_and_support/widgets/tiles/faq_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key, required this.faqs});
  final List<Map<String, String>> faqs;


  @override
  Widget build(BuildContext context) {
    final appLocalization=AppLocalizations.of(context)!;


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: EdgeInsets.all(16.w.clamp(12, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.faqTitle,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s15,
              ),
            ),
            SizedBox(height: 8.h),
            ...faqs.map(
                  (faq) => FaqTile(
                question: faq['question']!,
                answer: faq['answer']!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}