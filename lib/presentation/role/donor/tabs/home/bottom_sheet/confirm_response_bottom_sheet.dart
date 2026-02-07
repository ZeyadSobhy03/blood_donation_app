import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../request_screen/model/urgent_request.dart';
import '../section/confirm_navigation_buttons.dart';
import '../section/next_steps_section.dart';
import '../widgets/request_card.dart';


void showConfirmResponseBottomSheet(BuildContext context, UrgentRequestModel request) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorManger.pureWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.confirmResponse,
                      textStyle: TextStyle(
                        height: 1.4,
                        color: ColorManger.black,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: ColorManger.slateGrey),
                RequestCard(
                  isButtonExist: false,
                  borderColor: ColorManger.brightRed,
                  width: 1,
                  widget: Container(
                    decoration: BoxDecoration(
                      color: ColorManger.brightRed,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Icon(Icons.favorite, color: ColorManger.pureWhite),
                  ),
                  backgroundColor: ColorManger.lightRed,
                  dotColor: ColorManger.brightRed,
                  title: request.title,
                  location: request.location,
                  time: request.time,
                  buttonBackgroundColor: ColorManger.brightRed,
                ),
                SizedBox(height: 12.h),
                CustomText(
                  text:
                  AppLocalizations.of(context)!.emergencyRequestQuestion,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.slateGrey,
                  ),
                ),
                SizedBox(height: 8.h),
                NextStepsSection(),
                SizedBox(height: 8.h),
                ConfirmNavigationButtons(cancel: () {}, accept: () {}),
              ],
            ),
          ),
        ),
      );
    },
  );
}

