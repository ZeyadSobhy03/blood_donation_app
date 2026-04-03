import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RequestDetailRow extends StatelessWidget {
  const RequestDetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: '$label: ',
            textStyle: TextStyle(
              fontWeight: FontWeightManager.regular,
              color: ColorManger.slateGrey,
              fontSize: FontSize.s14,
            ),
          ),
          CustomText(
            text: value,
            textStyle: TextStyle(
              fontWeight: FontWeightManager.semiBold,
              color: ColorManger.black,
              fontSize: FontSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}
