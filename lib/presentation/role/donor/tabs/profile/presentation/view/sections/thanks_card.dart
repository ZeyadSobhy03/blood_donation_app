import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';


class ThanksCard extends StatelessWidget {
  const ThanksCard({
    super.key,
    required this.donationsCount,
    required this.livesSaved,
  });

  final int donationsCount;
  final int livesSaved;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: ColorManger.royalBlue.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        color: ColorManger.lightBlue,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                text: appLocalization.thanksHero,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.royalBlue,
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: appLocalization.thanksHeroDesc(
                  donationsCount,
                  livesSaved,
                ),
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.royalBlue,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
