import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/question_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({super.key});


  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionTile(question: appLocalization.faqQuestion1, answer: appLocalization.faqAnswer1, ),
            SizedBox(height: 16.h),
            QuestionTile(question: appLocalization.faqQuestion2, answer: appLocalization.faqAnswer2, ),
            SizedBox(height: 16.h),
            QuestionTile(question: appLocalization.faqQuestion3, answer: appLocalization.faqAnswer3, ),
            SizedBox(height: 16.h),
            QuestionTile(question: appLocalization.faqQuestion4, answer: appLocalization.faqAnswer4, ),
          ],
        ),
      ),
    );
  }
}
