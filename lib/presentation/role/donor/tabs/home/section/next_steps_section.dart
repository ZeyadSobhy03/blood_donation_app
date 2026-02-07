import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class NextStepsSection extends StatelessWidget {
  const NextStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: ColorManger.lightBlueGrey,
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: ColorManger.skyBlue.withValues(alpha: 0.8),
              width:1
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: AppLocalizations.of(context)!.whatHappensNext,textStyle: TextStyle(
                color: ColorManger.royalBlue,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold
            ),),
            SizedBox(height: 4.h,),
            _buildBulletItem(AppLocalizations.of(context)!.hospitalNotified),
            _buildBulletItem(AppLocalizations.of(context)!.directionsAndContact),
            _buildBulletItem(AppLocalizations.of(context)!.arriveOnTime),



          ],
        ),
      ),
    );
  }
  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text:  '•  ',
            textStyle: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
              color: ColorManger.royalBlue,
            ),
          ),
          Expanded(
            child: CustomText(
              text: text,
              textStyle:TextStyle(
                fontSize: FontSize.s16,
                color: ColorManger.royalBlue,
                height: 1.4, // Improves readability
              ) ,


            ),
          ),
        ],
      ),
    );
  }
}
