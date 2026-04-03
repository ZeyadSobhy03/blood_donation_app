import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class PopularTopicsSection extends StatelessWidget {
  const PopularTopicsSection({super.key, required this.topics});

  final List<String>topics;



  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;


    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),

        side: BorderSide(width: 1.w, color: ColorManger.lightBlue),
      ),
      elevation: 3,
      color: ColorManger.lightBlue,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(
              text: appLocalizations.popularTopicsTitle,
              textStyle: TextStyle(
                color: ColorManger.royalBlue,
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s15,
                height: 1.4
              ),
            ),
            SizedBox(height: 24.h),
            ...topics.map(
              (topic) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CustomText(
                  text: topic,
                  textStyle: TextStyle(
                    color: ColorManger.royalBlue,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
