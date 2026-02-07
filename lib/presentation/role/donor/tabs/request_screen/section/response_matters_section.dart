import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class ResponseMattersSection extends StatelessWidget {
  const ResponseMattersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightRed,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: ColorManger.pureWhite,
                ),
                child: Icon(
                  Icons.favorite_border,
                  color: ColorManger.brightRed,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appLocalization.whyYourResponseMatters,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        height: 1.4,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    CustomText(text: appLocalization.responseMattersDescription,textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManger.slateGrey,

                    ),)

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

