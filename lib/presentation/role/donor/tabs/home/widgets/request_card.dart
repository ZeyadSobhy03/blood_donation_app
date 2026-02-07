import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.backgroundColor,
    required this.dotColor,
    required this.title,
    required this.location,
    required this.time,
    required this.buttonBackgroundColor,
    this.onPressed,
    this.onTap,
    required this.borderColor,
    required this.width,
    required this.widget,
    required this.isButtonExist,
  });

  final Color backgroundColor;
  final Color dotColor;
  final String title;
  final String location;
  final String time;
  final Color buttonBackgroundColor;
  final void Function()? onPressed;
  final void Function()? onTap;
  final Color borderColor;
  final double width;
  final Widget widget;
  final bool isButtonExist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        color: backgroundColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: borderColor, width: width),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              widget,
              SizedBox(width: 8.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    textStyle: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManger.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorManger.slateGrey,
                        size: 18.sp,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: location,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: ColorManger.slateGrey,
                        size: 18.sp,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: time,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              isButtonExist
                  ? CustomElevatedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 3,
                      backgroundColor: buttonBackgroundColor,
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      foregroundColor: ColorManger.pureWhite,
                      onPressed: onPressed,
                      child: CustomText(text: AppLocalizations.of(context)!.respond),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
