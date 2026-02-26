import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';

class RequestDetailItem extends StatelessWidget {
  const RequestDetailItem({super.key, required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomLabel(text: label),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r,),
            border: Border.all(
              color: ColorManger.lightGrey,
              width: 1,
            ),

            color: ColorManger.textFormFieldGrey,
          ),
          child: CustomText(
            text: text,
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
              height: 1.4,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
      ],
    );
  }
}
