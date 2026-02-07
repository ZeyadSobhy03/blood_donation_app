import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentActivityRow extends StatelessWidget {
  const RecentActivityRow({
    super.key,
    required this.color,
    required this.title,
    required this.subTitle, required this.points,
  });

  final Color color;
  final String title;
  final String subTitle;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        children: [
          Container(
            height: 12.h,
            width: 12,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  height: 1.4,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: subTitle,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  height: 1.4,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
              child: CustomText(text: points,  textStyle: TextStyle(
                color: color,
                height: 1.4,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
