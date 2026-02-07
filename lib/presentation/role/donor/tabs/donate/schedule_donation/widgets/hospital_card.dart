import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.isSelect, required this.onTap, required this.hospitalName, required this.distance});

  final String hospitalName;
  final String distance;

  final bool isSelect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Card(
        color: isSelect ? ColorManger.lightRed : ColorManger.pureWhite,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),

          side: BorderSide(
            color: isSelect ? ColorManger.brightRed : ColorManger.lightGrey,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: ColorManger.brightRed),
              SizedBox(width: 8.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: hospitalName,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: distance,
                      textStyle: TextStyle(
                        color: ColorManger.slateGrey,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),

              if (isSelect)
                Icon(Icons.check_circle_outline, color: ColorManger.brightRed),
            ],
          ),
        ),
      ),
    );
  }
}
