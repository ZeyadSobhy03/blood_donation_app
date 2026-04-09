import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/extension/data_ex.dart';
import '../../../../../../core/resources/models/alert.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.alertModel, this.onTap,
  });

  final Color backgroundColor;

  final Color color;
  final AlertModel alertModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: alertModel.title,
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: alertModel.date.toTimeAgo(context),
                      textStyle: TextStyle(color: ColorManger.slateGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  child: CustomText(
                    text:  alertModel.type,
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
