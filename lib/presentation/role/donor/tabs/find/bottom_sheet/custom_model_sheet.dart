import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';

void showModelSheet({
  required BuildContext context,
  required Color cardBackgroundColor,
  required String title,
  required Widget prefixWidget,
  required Widget subTitleWidget,
  required Widget primaryButtonChild,
 required Widget secondaryButton,
  required Widget tertiaryButton,
  required Color buttonBackgroundColor,
  required String text,
   void Function()? primaryButtonPressed,
   void Function()? secondaryButtonPressed


}) {
  showModalBottomSheet(
    backgroundColor: ColorManger.pureWhite,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                text: title,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.s15,
                ),
              ),
              Card(
                elevation: 6,
                color:cardBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: cardBackgroundColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      prefixWidget,
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: text,
                            textStyle: TextStyle(
                              color: ColorManger.black,
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s15,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          subTitleWidget
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              CustomElevatedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                backgroundColor: buttonBackgroundColor,
                onPressed:primaryButtonPressed ,
                foregroundColor: ColorManger.pureWhite,
                child: primaryButtonChild,
              ),
              SizedBox(height: 4.h),
              CustomElevatedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                backgroundColor: ColorManger.pureWhite,
                onPressed: secondaryButtonPressed,
                foregroundColor: ColorManger.black,
                child: secondaryButton,
              ),
              SizedBox(height: 4.h),
              CustomElevatedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                backgroundColor: ColorManger.pureWhite,
                onPressed: () {
                  Navigator.pop(context);
                },
                foregroundColor: ColorManger.black,
                child: tertiaryButton,
              ),
            ],
          ),
        ),
      );
    },
  );
}
