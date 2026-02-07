import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/notification.dart';

class NotificationRequest extends StatelessWidget {
  const NotificationRequest({
    super.key,

    this.onPressed,
    required this.notification,
    required this.icon,
    required this.iconColor,
    this.isEmergency = false,
    this.bloodRequest = false,
  });

  final NotificationModel notification;
  final IconData icon;
  final Color iconColor;
  final bool isEmergency;
  final bool bloodRequest;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 18),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: notification.title,
                          textStyle: TextStyle(
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s14,
                            height: 1.4,
                            color: ColorManger.black,
                          ),
                        ),
                        Spacer(),
                        isEmergency
                            ? Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: ColorManger.brightRed,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    CustomText(
                      text: notification.subTitle,
                      textStyle: TextStyle(
                        color: ColorManger.slateGrey,
                        height: 1.4,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: ColorManger.slateGrey,
                          size: 12,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: notification.time,
                          textStyle: TextStyle(
                            color: ColorManger.slateGrey,
                            height: 1.4,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    bloodRequest
                        ? CustomElevatedButton(
                            padding: EdgeInsets.all(6),
                            foregroundColor: ColorManger.pureWhite,
                            backgroundColor: ColorManger.brightRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            onPressed: onPressed,
                            child: CustomText(
                              text: appLocalization.respond_now,
                              textStyle: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: ColorManger.lightGrey),
        ],
      ),
    );
  }
}
