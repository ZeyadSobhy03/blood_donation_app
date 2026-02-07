import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewRow extends StatelessWidget {
  const ReviewRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.isContact,
    this.phone = '',
    this.email = '', required this.iconColor,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final bool isContact;
  final String phone;
  final String email;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s14,
                color: ColorManger.slateGrey,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: subTitle,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s15,
                color: ColorManger.black,
                height: 1.4,
              ),
            ),
            if (isContact) ...[
              SizedBox(height: 6.h),
              CustomText(
                text: phone,
                textStyle:  TextStyle(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                  color: ColorManger.slateGrey,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: email,
                textStyle:  TextStyle(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s14,
                  color: ColorManger.slateGrey,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

