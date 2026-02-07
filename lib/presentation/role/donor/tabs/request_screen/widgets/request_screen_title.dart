import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';

class RequestScreenTitle extends StatelessWidget {
  const RequestScreenTitle({
    super.key,
    required this.title,
    required this.time,
    required this.status, required this.statusColor,
  });

  final String title;
  final String time;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorManger.pureWhite),
        ),
        SizedBox(width: 4.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              textStyle: TextStyle(
                color: ColorManger.pureWhite,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: time,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
                color: ColorManger.pureWhite,
                height: 1.4,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            color: ColorManger.pureWhite,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: CustomText(
                text: status,
                textStyle: TextStyle(
                  color: statusColor,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
