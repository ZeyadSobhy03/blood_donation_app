import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors/color_manger.dart';
import '../resources/fonts/font_manger.dart';
import 'custom_text.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    this.onChanged,
    required this.items,
    required this.hintText,
    this.initialValue, this.prefixIcon,
  });

  final void Function(dynamic)? onChanged;
  final List<String> items;
  final String hintText;
  final String? initialValue;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(

      style: TextStyle(
          color: ColorManger.black
      ),
      isDense: true,
      initialValue: initialValue,

      isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down, color: ColorManger.slateGrey),

      decoration: InputDecoration(
        prefixIcon:prefixIcon ,
        filled: true,
        fillColor: ColorManger.textFormFieldGrey,

        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorManger.grey600,
          fontSize: FontSize.s14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),

      items: items
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,

              child: CustomText(
                text: type,

              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
