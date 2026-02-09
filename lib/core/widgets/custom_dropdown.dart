import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: ColorManger.textFormFieldGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: ColorManger.slateGrey),
          const SizedBox(width: 10),
          CustomText(
            text: text,
            textStyle: TextStyle(color: ColorManger.black),
          ),
          const Spacer(),
          Icon(Icons.keyboard_arrow_down, color: ColorManger.slateGrey),
        ],
      ),
    );
  }
}
